package com.family.menu.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.family.menu.common.ResultCode;
import com.family.menu.dto.DishDetailVO;
import com.family.menu.dto.DishSaveRequest;
import com.family.menu.entity.Dish;
import com.family.menu.entity.DishIngredient;
import com.family.menu.exception.BusinessException;
import com.family.menu.mapper.DishIngredientMapper;
import com.family.menu.mapper.DishMapper;
import com.family.menu.service.DishService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 菜谱 Service 实现
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class DishServiceImpl extends ServiceImpl<DishMapper, Dish> implements DishService {

    private final DishMapper dishMapper;
    private final DishIngredientMapper ingredientMapper;

    @Override
    public List<Dish> list(String category, String keyword) {
        LambdaQueryWrapper<Dish> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Dish::getIsActive, true);
        if (StrUtil.isNotBlank(category)) {
            wrapper.eq(Dish::getCategory, category);
        }
        if (StrUtil.isNotBlank(keyword)) {
            wrapper.like(Dish::getName, keyword);
        }
        wrapper.orderByAsc(Dish::getSortOrder).orderByAsc(Dish::getId);
        return dishMapper.selectList(wrapper);
    }

    @Override
    public DishDetailVO getDetail(Long id) {
        Dish dish = dishMapper.selectById(id);
        if (dish == null) {
            throw new BusinessException(ResultCode.DATA_NOT_FOUND, "菜谱不存在");
        }
        List<DishIngredient> ingredients = ingredientMapper.selectList(
                new LambdaQueryWrapper<DishIngredient>().eq(DishIngredient::getDishId, id));
        DishDetailVO vo = new DishDetailVO();
        vo.setDish(dish);
        vo.setIngredients(ingredients);
        return vo;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long save(DishService.DishRequest request) {
        Dish dish = request.dish();
        List<DishIngredient> ingredients = request.ingredients();

        if (CollUtil.isEmpty(ingredients)) {
            throw new BusinessException("食材不能为空");
        }

        // 校验菜名唯一性
        LambdaQueryWrapper<Dish> checkWrapper = new LambdaQueryWrapper<Dish>()
                .eq(Dish::getName, dish.getName())
                .ne(dish.getId() != null, Dish::getId, dish.getId());
        if (dishMapper.selectCount(checkWrapper) > 0) {
            throw new BusinessException(ResultCode.DATA_EXISTS, "菜名已存在: " + dish.getName());
        }

        if (dish.getId() == null) {
            dishMapper.insert(dish);
        } else {
            dishMapper.updateById(dish);
            // 删除旧食材
            ingredientMapper.delete(new LambdaQueryWrapper<DishIngredient>().eq(DishIngredient::getDishId, dish.getId()));
        }

        // 保存食材
        Long dishId = dish.getId();
        for (int i = 0; i < ingredients.size(); i++) {
            DishIngredient ing = ingredients.get(i);
            ing.setId(null);
            ing.setDishId(dishId);
            ing.setSortOrder(i);
            ingredientMapper.insert(ing);
        }
        return dishId;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(Long id) {
        Dish dish = dishMapper.selectById(id);
        if (dish == null) {
            throw new BusinessException(ResultCode.DATA_NOT_FOUND, "菜谱不存在");
        }
        dishMapper.deleteById(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int batchSave(List<DishSaveRequest> requests) {
        int success = 0;
        for (DishSaveRequest req : requests) {
            Dish dish = new Dish();
            BeanUtil.copyProperties(req, dish, "ingredients");
            try {
                save(new DishService.DishRequest(dish, req.getIngredients()));
                success++;
            } catch (Exception e) {
                log.warn("批量导入失败: {} - {}", req.getName(), e.getMessage());
            }
        }
        return success;
    }

    @Override
    public List<String> allIngredientNames() {
        List<DishIngredient> all = ingredientMapper.selectList(null);
        return all.stream()
                .map(DishIngredient::getName)
                .filter(StrUtil::isNotBlank)
                .distinct()
                .sorted()
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateIngredients(Long dishId, List<DishIngredient> ingredients) {
        // 校验菜品存在
        if (dishMapper.selectById(dishId) == null) {
            throw new BusinessException(ResultCode.DATA_NOT_FOUND, "菜谱不存在");
        }
        // 允许清空
        if (ingredients == null) ingredients = List.of();

        // 先删后插（与 save 保持一致）
        ingredientMapper.delete(new LambdaQueryWrapper<DishIngredient>().eq(DishIngredient::getDishId, dishId));
        int i = 0;
        for (DishIngredient ing : ingredients) {
            ing.setId(null);
            ing.setDishId(dishId);
            ing.setSortOrder(i++);
            if (StrUtil.isBlank(ing.getCategory())) {
                ing.setCategory("其他");
            }
            ingredientMapper.insert(ing);
        }
        return ingredients.size();
    }
}