package com.family.menu.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.family.menu.entity.DishIngredient;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 食材 Mapper
 */
@Mapper
public interface DishIngredientMapper extends BaseMapper<DishIngredient> {

    /**
     * 根据 dishId 列表查询食材
     */
    @Select("""
            <script>
            SELECT * FROM dish_ingredient
            WHERE dish_id IN
            <foreach collection="dishIds" item="id" open="(" separator="," close=")">
                #{id}
            </foreach>
            ORDER BY dish_id, sort_order
            </script>
            """)
    List<DishIngredient> selectByDishIds(@Param("dishIds") List<Long> dishIds);
}