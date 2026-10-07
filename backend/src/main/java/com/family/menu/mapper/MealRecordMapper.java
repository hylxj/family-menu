package com.family.menu.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.family.menu.entity.MealRecord;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.time.LocalDate;
import java.util.List;

/**
 * 用餐记录 Mapper
 */
@Mapper
public interface MealRecordMapper extends BaseMapper<MealRecord> {

    /**
     * 查询最近 N 天的记录
     */
    @Select("SELECT * FROM meal_record WHERE meal_date >= #{startDate} AND deleted = 0 ORDER BY meal_date DESC")
    List<MealRecord> selectByDateRange(@Param("startDate") LocalDate startDate);

    /**
     * 查询日期范围内的 dishIds
     */
    @Select("""
            SELECT mrd.dish_id FROM meal_record mr
            INNER JOIN meal_record_dish mrd ON mr.id = mrd.meal_record_id
            WHERE mr.meal_date >= #{startDate} AND mr.deleted = 0
            """)
    List<Long> selectDishIdsByDateRange(@Param("startDate") LocalDate startDate);
}