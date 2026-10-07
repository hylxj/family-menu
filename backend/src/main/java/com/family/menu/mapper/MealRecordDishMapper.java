package com.family.menu.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.family.menu.entity.MealRecordDish;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 用餐记录-菜品关联 Mapper
 */
@Mapper
public interface MealRecordDishMapper extends BaseMapper<MealRecordDish> {

    @Select("SELECT * FROM meal_record_dish WHERE meal_record_id = #{mealRecordId}")
    List<MealRecordDish> selectByMealRecordId(@Param("mealRecordId") Long mealRecordId);
}