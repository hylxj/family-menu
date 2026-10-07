package com.family.menu.dto;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

/**
 * 保存某天菜单的请求
 */
@Data
public class MealRecordSaveRequest implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /** 用餐日期 */
    private LocalDate mealDate;

    /** 类型，默认 dinner */
    private String mealType;

    /** 备注 */
    private String notes;

    /** 当天菜品（主荤+素菜+汤+凉菜） */
    private List<DishItem> dishes;

    @Data
    public static class DishItem implements Serializable {
        @Serial
        private static final long serialVersionUID = 1L;

        private Long dishId;

        /** 角色: 主荤/素菜/汤/凉菜 */
        private String role;
    }
}
