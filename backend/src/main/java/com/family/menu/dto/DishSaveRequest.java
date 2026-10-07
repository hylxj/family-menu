package com.family.menu.dto;

import com.family.menu.entity.Dish;
import com.family.menu.entity.DishIngredient;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

/**
 * 菜谱保存请求
 */
@Data
public class DishSaveRequest implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    private Long id;

    @NotBlank(message = "菜名不能为空")
    private String name;

    @NotBlank(message = "分类不能为空")
    private String category;

    private Integer spicyLevel = 0;

    private Integer cookTime = 30;

    private Boolean kidFriendly = false;

    private Boolean elderFriendly = true;

    private String description;

    private String tags;

    private Integer sortOrder = 0;

    @NotEmpty(message = "食材不能为空")
    private List<DishIngredient> ingredients;
}