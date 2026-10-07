package com.family.menu.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 用餐记录-菜品关联
 */
@Data
@TableName("meal_record_dish")
public class MealRecordDish implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long mealRecordId;

    private Long dishId;

    /** 角色: 主荤/素菜/汤/凉菜 */
    private String role;

    private Integer rating;
}