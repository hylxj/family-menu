package com.family.menu.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.family.menu.entity.Dish;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 菜谱 Mapper
 */
@Mapper
public interface DishMapper extends BaseMapper<Dish> {

    /**
     * 查询所有启用的菜
     */
    @Select("SELECT * FROM dish WHERE is_active = 1 AND deleted = 0 ORDER BY sort_order ASC, id ASC")
    List<Dish> selectAllActive();

    /**
     * 按分类查询
     */
    @Select("SELECT * FROM dish WHERE category = #{category} AND is_active = 1 AND deleted = 0 ORDER BY sort_order ASC")
    List<Dish> selectByCategory(@Param("category") String category);

    /**
     * 按辣度筛选
     */
    @Select("SELECT * FROM dish WHERE spicy_level <= #{spicyLevel} AND is_active = 1 AND deleted = 0")
    List<Dish> selectByMaxSpicy(@Param("spicyLevel") Integer spicyLevel);
}