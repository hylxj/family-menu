package com.family.menu.service;

import com.family.menu.dto.WeekMenuVO;
import com.family.menu.entity.Dish;

import java.util.List;

/**
 * 菜单生成 Service
 */
public interface MenuService {

    /**
     * 生成 N 天的晚餐菜单
     *
     * @param startDate 起始日期
     * @param days 天数（一般 7）
     * @param historyDays 历史去重天数（默认 14）
     * @return 周菜单 + 购物清单
     */
    WeekMenuVO generateWeekMenu(java.time.LocalDate startDate, int days, int historyDays);

    /**
     * 换一道菜：从指定分类中选一道新的（排除已选 + 近期吃过）
     *
     * @param category 分类
     * @param excludeDishIds 当前已选的菜 id 列表
     * @param spicyLevel 上限（家庭偏好最严）
     */
    Dish swapDish(String category, List<Long> excludeDishIds, Integer spicyLevel);
}