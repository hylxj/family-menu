package com.family.menu.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.RandomUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.family.menu.common.ResultCode;
import com.family.menu.dto.ShoppingListVO;
import com.family.menu.dto.WeekMenuVO;
import com.family.menu.entity.Dish;
import com.family.menu.entity.DishIngredient;
import com.family.menu.entity.FamilyMember;
import com.family.menu.entity.MealRecord;
import com.family.menu.entity.MealRecordDish;
import com.family.menu.exception.BusinessException;
import com.family.menu.mapper.DishIngredientMapper;
import com.family.menu.mapper.DishMapper;
import com.family.menu.mapper.FamilyMemberMapper;
import com.family.menu.mapper.MealRecordDishMapper;
import com.family.menu.mapper.MealRecordMapper;
import com.family.menu.service.MenuService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 菜单生成核心算法
 *
 * <p>核心思路：
 * <ol>
 *     <li>加载所有启用的菜</li>
 *     <li>过滤掉最近 N 天吃过的</li>
 *     <li>按角色分组（主荤/素菜/汤/凉菜）</li>
 *     <li>考虑家庭成员偏好（辣度上限、过敏原、忌口）</li>
 *     <li>随机分配每天的菜（保证多样性）</li>
 *     <li>平衡辣度（避免连续 3 天爆辣）</li>
 *     <li>聚合 7 天的食材生成购物清单</li>
 * </ol>
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class MenuServiceImpl implements MenuService {

    private final DishMapper dishMapper;
    private final DishIngredientMapper ingredientMapper;
    private final MealRecordMapper mealRecordMapper;
    private final MealRecordDishMapper mealRecordDishMapper;
    private final FamilyMemberMapper familyMemberMapper;

    private static final String[] WEEKDAYS = {"周一", "周二", "周三", "周四", "周五", "周六", "周日"};

    /**
     * 换一道菜
     */
    @Override
    public Dish swapDish(String category, List<Long> excludeDishIds, Integer spicyLevel) {
        log.info("换菜: category={}, exclude={}, spicy={}", category, excludeDishIds, spicyLevel);

        // 1. 取该分类下所有启用的菜
        List<Dish> all = dishMapper.selectList(
                new LambdaQueryWrapper<Dish>()
                        .eq(Dish::getCategory, category)
                        .eq(Dish::getIsActive, true)
                        .orderByAsc(Dish::getId));

        if (CollUtil.isEmpty(all)) {
            throw new BusinessException("该分类下没有可用菜: " + category);
        }

        // 2. 过滤：辣度 + 排除
        int maxSpicy = spicyLevel == null ? 3 : spicyLevel;
        Set<Long> exclude = excludeDishIds == null ? Set.of() : new HashSet<>(excludeDishIds);
        List<Dish> candidates = all.stream()
                .filter(d -> d.getSpicyLevel() != null && d.getSpicyLevel() <= maxSpicy)
                .filter(d -> !exclude.contains(d.getId()))
                .collect(Collectors.toList());

        // 3. 排除近期吃过的（14 天）
        if (!candidates.isEmpty()) {
            Set<Long> recentlyEaten = mealRecordMapper.selectDishIdsByDateRange(
                    LocalDate.now().minusDays(14)).stream().collect(Collectors.toSet());
            List<Dish> fresh = candidates.stream()
                    .filter(d -> !recentlyEaten.contains(d.getId()))
                    .toList();
            if (!fresh.isEmpty()) candidates = fresh;
        }

        if (candidates.isEmpty()) {
            // 兜底：放宽到同分类全部
            candidates = all;
        }

        Dish picked = candidates.get(RandomUtil.getRandom().nextInt(candidates.size()));
        log.info("换菜结果: {} (候选 {} 道)", picked.getName(), candidates.size());
        return picked;
    }

    @Override
    public WeekMenuVO generateWeekMenu(LocalDate startDate, int days, int historyDays) {
        log.info("生成菜单: startDate={}, days={}, historyDays={}", startDate, days, historyDays);

        // 1. 加载家庭成员偏好（取最严格限制）
        FamilyMemberPreference pref = loadFamilyPreference();

        // 2. 加载所有可用菜
        List<Dish> allDishes = dishMapper.selectAllActive();
        if (CollUtil.isEmpty(allDishes)) {
            throw new BusinessException(ResultCode.DATA_NOT_FOUND, "菜谱库为空，请先录入菜谱");
        }

        // 3. 加载最近 N 天吃过的菜 ID
        Set<Long> recentlyEaten = mealRecordMapper.selectDishIdsByDateRange(
                LocalDate.now().minusDays(historyDays)).stream().collect(Collectors.toSet());
        log.info("最近 {} 天已吃过 {} 道菜", historyDays, recentlyEaten.size());

        // 4. 过滤候选菜（辣度 + 历史去重）
        List<Dish> candidates = allDishes.stream()
                .filter(d -> !recentlyEaten.contains(d.getId()))
                .filter(d -> d.getSpicyLevel() <= pref.maxSpicyLevel)
                .collect(Collectors.toList());

        log.info("过滤后候选菜: {} 道（辣度上限={}，忌口={}）",
                candidates.size(), pref.maxSpicyLevel, pref.allergyIngredients);

        // 预加载所有菜的食材（用于过敏判断）
        Map<Long, Set<String>> dishIngredientNames = preloadIngredientNames(allDishes);

        // 重新应用过敏过滤（基于真实食材表）
        if (!pref.allergyIngredients.isEmpty()) {
            int before = candidates.size();
            candidates = candidates.stream()
                    .filter(d -> !containsAnyIngredientName(dishIngredientNames.getOrDefault(d.getId(), Set.of()),
                            pref.allergyIngredients))
                    .collect(Collectors.toList());
            log.info("过敏过滤: {} → {}", before, candidates.size());
        }

        if (candidates.size() < days * 3) {
            log.warn("候选菜不足 ({} < {})，降低过滤条件", candidates.size(), days * 3);
            // 候选不足时放宽历史限制
            candidates = allDishes.stream()
                    .filter(d -> d.getSpicyLevel() <= pref.maxSpicyLevel)
                    .filter(d -> !containsAnyIngredientName(dishIngredientNames.getOrDefault(d.getId(), Set.of()),
                            pref.allergyIngredients))
                    .collect(Collectors.toList());
        }

        // 5. 按分类分组
        Map<String, List<Dish>> byCategory = candidates.stream()
                .collect(Collectors.groupingBy(Dish::getCategory));

        // 7. 每天一道凉菜：放宽限制（不去重），因为凉菜本身不多
        // 把"凉菜"从候选里再放回去（不参与 history 过滤）
        List<Dish> coldPool = allDishes.stream()
                .filter(d -> d.getSpicyLevel() <= pref.maxSpicyLevel)
                .filter(d -> "凉菜".equals(d.getCategory()))
                .filter(d -> !containsAnyIngredientName(dishIngredientNames.getOrDefault(d.getId(), Set.of()),
                        pref.allergyIngredients))
                .collect(Collectors.toList());
        require(coldPool.size() >= days,
                String.format("凉菜不足：当前 %d 道（辣度上限=%d），需要 %d 道（每天一道）",
                        coldPool.size(), pref.maxSpicyLevel, days));
        byCategory.put("凉菜", coldPool);

        // 6. 检查基本库存（带诊断信息）
        long mainCount = byCategory.getOrDefault("主荤", List.of()).size();
        long vegCount  = byCategory.getOrDefault("素菜", List.of()).size();
        log.info("分类统计: 主荤={} 素菜={} 汤={} 凉菜={}（辣度上限={}）",
                mainCount, vegCount,
                byCategory.getOrDefault("汤", List.of()).size(),
                byCategory.getOrDefault("凉菜", List.of()).size(),
                pref.maxSpicyLevel);
        require(mainCount >= Math.min(days, 3),
                String.format("主荤菜不足：当前 %d 道（辣度上限=%d），需要 %d 道。请录入更多主荤菜，或调整家庭成员辣度上限",
                        mainCount, pref.maxSpicyLevel, Math.min(days, 3)));
        require(vegCount >= Math.min(days, 3),
                String.format("素菜不足：当前 %d 道（辣度上限=%d），需要 %d 道",
                        vegCount, pref.maxSpicyLevel, Math.min(days, 3)));
        long coldCount = byCategory.getOrDefault("凉菜", List.of()).size();
        require(coldCount >= days,
                String.format("凉菜不足：当前 %d 道（辣度上限=%d），需要 %d 道（每天一道）",
                        coldCount, pref.maxSpicyLevel, days));

        // 7. 逐天分配
        List<WeekMenuVO.DayMenu> dayMenus = new ArrayList<>();
        Random random = RandomUtil.getRandom();

        for (int i = 0; i < days; i++) {
            LocalDate date = startDate.plusDays(i);
            WeekMenuVO.DayMenu day = new WeekMenuVO.DayMenu();
            day.setDate(date);
            day.setWeekday(WEEKDAYS[(date.getDayOfWeek().getValue() - 1) % 7]);

            // 主荤
            Dish main = pickByRotation(byCategory.get("主荤"), i, random);
            // 素菜
            Dish side = pickByRotation(byCategory.get("素菜"), i + days, random);
            // 汤
            Dish soup = pickFromList(byCategory.get("汤"), i, random);
            // 凉菜（每天必有一道）
            Dish cold = pickFromList(byCategory.get("凉菜"), i, random);
            day.setColdDish(cold);

            day.setMainDish(main);
            day.setSideDish(side);
            day.setSoupDish(soup);

            List<Dish> all = new ArrayList<>();
            if (main != null) all.add(main);
            if (side != null) all.add(side);
            if (soup != null) all.add(soup);
            if (cold != null) all.add(cold);
            day.setAllDishes(all);

            dayMenus.add(day);
        }

        // 8. 平衡辣度
        balanceSpicy(dayMenus);

        // 9. 加载食材
        List<Long> allDishIds = dayMenus.stream()
                .flatMap(d -> d.getAllDishes().stream())
                .map(Dish::getId).distinct().toList();
        Map<Long, List<DishIngredient>> ingredientsByDish = loadIngredientsByDish(allDishIds);

        // 10. 关联食材到 DayMenu
        for (WeekMenuVO.DayMenu day : dayMenus) {
            // 这里可扩展：把食材附加到 dish 上
        }

        // 11. 生成购物清单
        ShoppingListVO shoppingList = aggregateShoppingList(dayMenus, ingredientsByDish, startDate);

        // 12. 组装返回
        WeekMenuVO result = new WeekMenuVO();
        result.setStartDate(startDate);
        result.setEndDate(startDate.plusDays(days - 1));
        result.setDayMenus(dayMenus);
        result.setShoppingList(shoppingList);
        return result;
    }

    /**
     * 加载家庭偏好（取最严格限制）
     */
    private FamilyMemberPreference loadFamilyPreference() {
        List<FamilyMember> members = familyMemberMapper.selectList(
                new LambdaQueryWrapper<FamilyMember>().eq(FamilyMember::getIsActive, true));

        FamilyMemberPreference pref = new FamilyMemberPreference();
        pref.maxSpicyLevel = 3;
        pref.allergyIngredients = new ArrayList<>();

        for (FamilyMember m : members) {
            // 辣度取最小
            if (m.getSpicyMax() != null && m.getSpicyMax() < pref.maxSpicyLevel) {
                pref.maxSpicyLevel = m.getSpicyMax();
            }
            // 汇总过敏食材（逗号分隔字符串）
            if (m.getAllergies() != null && !m.getAllergies().isBlank()) {
                for (String a : m.getAllergies().split(",")) {
                    String t = a.trim();
                    if (!t.isEmpty() && !pref.allergyIngredients.contains(t)) {
                        pref.allergyIngredients.add(t);
                    }
                }
            }
        }
        log.info("家庭偏好: {} 位成员，辣度上限={}，过敏={}", members.size(), pref.maxSpicyLevel, pref.allergyIngredients);
        return pref;
    }

    /**
     * 预加载菜的食材名集合（用于过敏判断）
     */
    private Map<Long, Set<String>> preloadIngredientNames(List<Dish> dishes) {
        List<Long> ids = dishes.stream().map(Dish::getId).toList();
        if (CollUtil.isEmpty(ids)) return Map.of();
        List<DishIngredient> all = ingredientMapper.selectByDishIds(ids);
        Map<Long, Set<String>> map = new HashMap<>();
        for (DishIngredient ing : all) {
            if (ing.getName() == null) continue;
            map.computeIfAbsent(ing.getDishId(), k -> new HashSet<>()).add(ing.getName().trim());
        }
        return map;
    }

    /**
     * 检查菜的食材是否包含指定的过敏原
     */
    private boolean containsAnyIngredientName(Set<String> dishIngredientNames, List<String> allergens) {
        if (CollUtil.isEmpty(allergens) || dishIngredientNames.isEmpty()) return false;
        for (String allergen : allergens) {
            if (dishIngredientNames.contains(allergen)) return true;
        }
        return false;
    }

    /**
     * 轮询选菜（避免完全随机）
     */
    private Dish pickByRotation(List<Dish> pool, int offset, Random random) {
        if (CollUtil.isEmpty(pool)) return null;
        // 80% 轮询 + 20% 随机
        if (random.nextInt(100) < 20) {
            return pool.get(random.nextInt(pool.size()));
        }
        return pool.get(offset % pool.size());
    }

    private Dish pickFromList(List<Dish> pool, int offset, Random random) {
        if (CollUtil.isEmpty(pool)) return null;
        return pool.get((offset + random.nextInt(3)) % pool.size());
    }

    /**
     * 平衡辣度（避免连续 3 天爆辣）
     */
    private void balanceSpicy(List<WeekMenuVO.DayMenu> dayMenus) {
        // 简单策略：辣度 3 的菜一周不超过 2 次
        long spicyCount = dayMenus.stream()
                .filter(d -> d.getMainDish() != null && d.getMainDish().getSpicyLevel() >= 3)
                .count();
        if (spicyCount > 2) {
            log.info("辣度过高，调整中...");
            int toReplace = (int) (spicyCount - 2);
            // 把后面几天的爆辣换成中辣
            for (int i = dayMenus.size() - 1; i >= 0 && toReplace > 0; i--) {
                Dish main = dayMenus.get(i).getMainDish();
                if (main != null && main.getSpicyLevel() >= 3) {
                    main.setSpicyLevel(1);
                    toReplace--;
                }
            }
        }
    }

    /**
     * 批量加载食材
     */
    private Map<Long, List<DishIngredient>> loadIngredientsByDish(List<Long> dishIds) {
        if (CollUtil.isEmpty(dishIds)) return Map.of();
        List<DishIngredient> all = ingredientMapper.selectByDishIds(dishIds);
        return all.stream().collect(Collectors.groupingBy(DishIngredient::getDishId));
    }

    /**
     * 聚合购物清单
     */
    private ShoppingListVO aggregateShoppingList(List<WeekMenuVO.DayMenu> dayMenus,
                                                 Map<Long, List<DishIngredient>> ingredientsByDish,
                                                 LocalDate startDate) {

        // 1. 汇总所有食材
        Map<String, MergedIngredient> merged = new LinkedHashMap<>();
        for (WeekMenuVO.DayMenu day : dayMenus) {
            for (Dish dish : day.getAllDishes()) {
                List<DishIngredient> ings = ingredientsByDish.getOrDefault(dish.getId(), List.of());
                for (DishIngredient ing : ings) {
                    String key = ing.getName() + "|" + (ing.getUnit() == null ? "" : ing.getUnit());
                    MergedIngredient m = merged.computeIfAbsent(key, k -> new MergedIngredient());
                    m.name = ing.getName();
                    m.unit = ing.getUnit();
                    m.category = ing.getCategory();

                    // 累加用量（适量等不计入）
                    if (ing.getAmount() != null) {
                        m.amount = m.amount.add(ing.getAmount());
                    }
                    // 记录来源菜
                    if (m.usedIn == null) m.usedIn = dish.getName();
                    else if (!m.usedIn.contains(dish.getName())) {
                        m.usedIn = m.usedIn + ", " + dish.getName();
                    }
                }
            }
        }

        // 2. 按分类分组
        Map<String, List<ShoppingListVO.Item>> grouped = new LinkedHashMap<>();
        for (MergedIngredient m : merged.values()) {
            String cat = m.category == null ? "其他" : m.category;
            grouped.computeIfAbsent(cat, k -> new ArrayList<>());

            ShoppingListVO.Item item = new ShoppingListVO.Item();
            item.setName(m.name);
            item.setAmount(m.amount.stripTrailingZeros().setScale(2, RoundingMode.HALF_UP));
            item.setUnit(m.unit);
            item.setUsedIn(m.usedIn);
            grouped.get(cat).add(item);
        }

        // 3. 组装结果
        ShoppingListVO vo = new ShoppingListVO();
        vo.setStartDate(startDate.format(DateTimeFormatter.ISO_DATE));
        vo.setEndDate(startDate.plusDays(dayMenus.size() - 1).format(DateTimeFormatter.ISO_DATE));
        vo.setTotalCount(merged.size());

        // 排序：按分类常用顺序
        List<String> categoryOrder = List.of("蔬菜", "肉类", "水产", "主食", "调料", "其他");
        List<ShoppingListVO.IngredientGroup> groups = new ArrayList<>();
        for (String cat : categoryOrder) {
            List<ShoppingListVO.Item> items = grouped.get(cat);
            if (CollUtil.isEmpty(items)) continue;

            ShoppingListVO.IngredientGroup group = new ShoppingListVO.IngredientGroup();
            group.setCategory(cat);
            group.setIcon(getCategoryIcon(cat));
            group.setItems(items.stream()
                    .sorted(Comparator.comparing(ShoppingListVO.Item::getName))
                    .toList());
            groups.add(group);
        }
        vo.setGroups(groups);
        return vo;
    }

    private String getCategoryIcon(String category) {
        return switch (category) {
            case "蔬菜" -> "🥬";
            case "肉类" -> "🥩";
            case "水产" -> "🐟";
            case "调料" -> "🧂";
            case "主食" -> "🌾";
            default -> "📦";
        };
    }

    // ====== 内部工具方法 ======
    private static void require(boolean condition, String message) {
        if (!condition) throw new BusinessException(message);
    }

    /** 家庭偏好内部表示 */
    private static class FamilyMemberPreference {
        int maxSpicyLevel;
        List<String> allergyIngredients;
    }

    /** 合并后的食材 */
    private static class MergedIngredient {
        String name;
        BigDecimal amount = BigDecimal.ZERO;
        String unit;
        String category;
        String usedIn;
    }
}