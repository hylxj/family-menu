package com.family.menu.dto;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

/**
 * 购物清单 VO
 */
@Data
public class ShoppingListVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /** 开始日期 */
    private String startDate;

    /** 结束日期 */
    private String endDate;

    /** 食材分组（蔬菜/肉类/水产/调料/其他） */
    private List<IngredientGroup> groups;

    /** 总食材数 */
    private Integer totalCount;

    @Data
    public static class IngredientGroup implements Serializable {
        @Serial
        private static final long serialVersionUID = 1L;

        /** 分类名 */
        private String category;

        /** 分类图标 */
        private String icon;

        private List<Item> items;
    }

    @Data
    public static class Item implements Serializable {
        @Serial
        private static final long serialVersionUID = 1L;

        private String name;

        private BigDecimal amount;

        private String unit;

        /** 涉及哪些菜（逗号分隔） */
        private String usedIn;
    }
}