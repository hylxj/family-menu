package com.family.menu.dto;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

/**
 * 历史菜单分组 VO
 */
@Data
public class MealHistoryVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /** 主键（用于删除） */
    private Long id;

    private LocalDate date;

    private String weekday;

    private String mealType;

    private String notes;

    private List<DishItem> dishes;

    @Data
    public static class DishItem implements Serializable {
        @Serial
        private static final long serialVersionUID = 1L;

        private Long id;
        private String name;
        private String category;
        private Integer spicyLevel;
        private Integer cookTime;
        private String role;
    }
}