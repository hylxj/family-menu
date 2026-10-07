package com.family.menu.service;

import com.family.menu.dto.MealHistoryVO;
import com.family.menu.dto.MealRecordSaveRequest;

import java.time.LocalDate;
import java.util.List;

/**
 * 用餐记录 Service
 */
public interface MealRecordService {

    /**
     * 保存某天菜单（已存在则覆盖）
     */
    Long save(MealRecordSaveRequest request);

    /**
     * 查询某天的菜单
     */
    MealRecordSaveRequest getByDate(LocalDate date, String mealType);

    /**
     * 查询全部历史（按日期倒序）
     *
     * @param startDate 起始日期（可空，默认查全部）
     * @param endDate   结束日期（可空）
     */
    List<MealHistoryVO> listHistory(LocalDate startDate, LocalDate endDate);

    /**
     * 删除某条记录（连带菜品关联）
     */
    void delete(Long recordId);
}
