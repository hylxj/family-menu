package com.family.menu.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 食材
 */
@Data
@TableName("dish_ingredient")
public class DishIngredient implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long dishId;

    /** 食材名 */
    private String name;

    /** 用量 */
    private BigDecimal amount;

    /** 单位 */
    private String unit;

    /** 食材分类 */
    private String category;

    /** 是否可选 */
    private Boolean isOptional;

    private Integer sortOrder;
}