package com.family.menu.service.impl;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.family.menu.dto.MealHistoryVO;
import com.family.menu.dto.MealRecordSaveRequest;
import com.family.menu.entity.Dish;
import com.family.menu.entity.MealRecord;
import com.family.menu.entity.MealRecordDish;
import com.family.menu.mapper.DishMapper;
import com.family.menu.mapper.MealRecordDishMapper;
import com.family.menu.mapper.MealRecordMapper;
import com.family.menu.service.MealRecordService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 用餐记录 Service 实现
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class MealRecordServiceImpl implements MealRecordService {

    private final MealRecordMapper mealRecordMapper;
    private final MealRecordDishMapper mealRecordDishMapper;
    private final DishMapper dishMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long save(MealRecordSaveRequest request) {
        if (request.getMealDate() == null) {
            throw new IllegalArgumentException("mealDate 不能为空");
        }
        if (CollUtil.isEmpty(request.getDishes())) {
            throw new IllegalArgumentException("至少需要一道菜");
        }

        String mealType = request.getMealType() == null ? "dinner" : request.getMealType();

        // 1. 查找是否已有（meal_date + meal_type 唯一约束）
        MealRecord existing = mealRecordMapper.selectOne(
                new LambdaQueryWrapper<MealRecord>()
                        .eq(MealRecord::getMealDate, request.getMealDate())
                        .eq(MealRecord::getMealType, mealType)
                        .eq(MealRecord::getDeleted, 0));

        Long recordId;
        if (existing == null) {
            MealRecord record = new MealRecord();
            record.setMealDate(request.getMealDate());
            record.setMealType(mealType);
            record.setNotes(request.getNotes());
            mealRecordMapper.insert(record);
            recordId = record.getId();
            log.info("新建用餐记录: date={}, type={}, id={}", request.getMealDate(), mealType, recordId);
        } else {
            recordId = existing.getId();
            existing.setNotes(request.getNotes());
            mealRecordMapper.updateById(existing);
            // 清掉旧的菜品关联
            mealRecordDishMapper.delete(new LambdaQueryWrapper<MealRecordDish>()
                    .eq(MealRecordDish::getMealRecordId, recordId));
            log.info("覆盖用餐记录: id={}", recordId);
        }

        // 2. 插入菜品
        for (MealRecordSaveRequest.DishItem item : request.getDishes()) {
            if (item.getDishId() == null) continue;
            MealRecordDish mrd = new MealRecordDish();
            mrd.setMealRecordId(recordId);
            mrd.setDishId(item.getDishId());
            mrd.setRole(item.getRole() == null ? "其他" : item.getRole());
            mealRecordDishMapper.insert(mrd);
        }

        return recordId;
    }

    @Override
    public MealRecordSaveRequest getByDate(LocalDate date, String mealType) {
        if (mealType == null) mealType = "dinner";
        MealRecord record = mealRecordMapper.selectOne(
                new LambdaQueryWrapper<MealRecord>()
                        .eq(MealRecord::getMealDate, date)
                        .eq(MealRecord::getMealType, mealType)
                        .eq(MealRecord::getDeleted, 0));
        if (record == null) return null;

        List<MealRecordDish> items = mealRecordDishMapper.selectByMealRecordId(record.getId());

        MealRecordSaveRequest vo = new MealRecordSaveRequest();
        vo.setMealDate(record.getMealDate());
        vo.setMealType(record.getMealType());
        vo.setNotes(record.getNotes());

        List<MealRecordSaveRequest.DishItem> dishes = new ArrayList<>();
        for (MealRecordDish mrd : items) {
            MealRecordSaveRequest.DishItem d = new MealRecordSaveRequest.DishItem();
            d.setDishId(mrd.getDishId());
            d.setRole(mrd.getRole());
            dishes.add(d);
        }
        vo.setDishes(dishes);
        return vo;
    }

    @Override
    public List<MealHistoryVO> listHistory(LocalDate startDate, LocalDate endDate) {
        LambdaQueryWrapper<MealRecord> wrapper = new LambdaQueryWrapper<MealRecord>()
                .eq(MealRecord::getDeleted, 0)
                .orderByDesc(MealRecord::getMealDate);
        if (startDate != null) wrapper.ge(MealRecord::getMealDate, startDate);
        if (endDate != null) wrapper.le(MealRecord::getMealDate, endDate);

        List<MealRecord> records = mealRecordMapper.selectList(wrapper);
        if (CollUtil.isEmpty(records)) return Collections.emptyList();

        // 一次性查所有菜品关联 + 所有 dish 信息
        List<Long> recordIds = records.stream().map(MealRecord::getId).toList();
        List<MealRecordDish> allLinks = mealRecordDishMapper.selectList(
                new LambdaQueryWrapper<MealRecordDish>().in(MealRecordDish::getMealRecordId, recordIds));
        Map<Long, List<MealRecordDish>> linksByRecord = allLinks.stream()
                .collect(Collectors.groupingBy(MealRecordDish::getMealRecordId));

        Set<Long> dishIds = allLinks.stream().map(MealRecordDish::getDishId).collect(Collectors.toSet());
        Map<Long, Dish> dishMap = CollUtil.isEmpty(dishIds) ? Collections.emptyMap()
                : dishMapper.selectBatchIds(dishIds).stream()
                        .collect(Collectors.toMap(Dish::getId, d -> d));

        // 拼装 VO
        String[] weekdays = {"", "周一", "周二", "周三", "周四", "周五", "周六", "周日"};
        List<MealHistoryVO> result = new ArrayList<>();
        for (MealRecord r : records) {
            MealHistoryVO vo = new MealHistoryVO();
            vo.setId(r.getId());
            vo.setDate(r.getMealDate());
            vo.setWeekday(weekdays[r.getMealDate().getDayOfWeek().getValue()]);
            vo.setMealType(r.getMealType());
            vo.setNotes(r.getNotes());

            List<MealRecordDish> links = linksByRecord.getOrDefault(r.getId(), Collections.emptyList());
            List<MealHistoryVO.DishItem> dishes = new ArrayList<>();
            for (MealRecordDish link : links) {
                Dish d = dishMap.get(link.getDishId());
                if (d == null) continue;
                MealHistoryVO.DishItem item = new MealHistoryVO.DishItem();
                item.setId(d.getId());
                item.setName(d.getName());
                item.setCategory(d.getCategory());
                item.setSpicyLevel(d.getSpicyLevel());
                item.setCookTime(d.getCookTime());
                item.setRole(link.getRole());
                dishes.add(item);
            }
            vo.setDishes(dishes);
            result.add(vo);
        }
        log.info("查询历史: {} 条记录, {} 道菜", result.size(), allLinks.size());
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(Long recordId) {
        MealRecord record = mealRecordMapper.selectById(recordId);
        if (record == null) {
            log.warn("删除失败，记录不存在: id={}", recordId);
            return;
        }
        // 先删菜品关联
        mealRecordDishMapper.delete(new LambdaQueryWrapper<MealRecordDish>()
                .eq(MealRecordDish::getMealRecordId, recordId));
        // 逻辑删除主记录
        mealRecordMapper.deleteById(recordId);
        log.info("删除用餐记录: id={}, date={}", recordId, record.getMealDate());
    }
}
