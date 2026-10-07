package com.family.menu.dto;

import com.family.menu.entity.Dish;
import com.family.menu.entity.DishIngredient;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

/**
 * 菜谱详情 VO（含食材）
 */
@Data
public class DishDetailVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    private Dish dish;

    private List<DishIngredient> ingredients;
}