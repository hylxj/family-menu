package com.family.menu.dto;

import com.family.menu.entity.Dish;
import com.family.menu.entity.DishIngredient;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

/**
 * 生成的周菜单 VO
 */
@Data
public class WeekMenuVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /** 起始日期 */
    private LocalDate startDate;

    /** 结束日期 */
    private LocalDate endDate;

    /** 每日菜单 */
    private List<DayMenu> dayMenus;

    /** 购物清单 */
    private ShoppingListVO shoppingList;

    @Data
    public static class DayMenu implements Serializable {
        @Serial
        private static final long serialVersionUID = 1L;

        private LocalDate date;

        /** 星期几 (周一/周二/...) */
        private String weekday;

        private Dish mainDish;

        private Dish sideDish;

        private Dish soupDish;

        /** 凉拌菜（每天必有一道） */
        private Dish coldDish;

        private List<Dish> allDishes;
    }
}