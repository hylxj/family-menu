package com.family.menu.service;

import com.family.menu.dto.DishDetailVO;
import com.family.menu.dto.DishSaveRequest;
import com.family.menu.entity.Dish;
import com.family.menu.entity.DishIngredient;

import java.util.List;

/**
 * 菜谱 Service
 */
public interface DishService {

    /**
     * 分页查询
     */
    List<Dish> list(String category, String keyword);

    /**
     * 获取详情（含食材）
     */
    DishDetailVO getDetail(Long id);

    /**
     * 新增/修改
     */
    Long save(DishRequest request);

    /**
     * 删除
     */
    void delete(Long id);

    /**
     * 批量新增
     */
    int batchSave(List<DishSaveRequest> requests);

    /**
     * 取出所有不重复的食材名（用于自动联想）
     */
    List<String> allIngredientNames();

    /**
     * 只更新某道菜的食材（不修改菜品本身）
     * @return 受影响行数（通常 = 食材条数）
     */
    int updateIngredients(Long dishId, List<DishIngredient> ingredients);

    /** 内部数据传输 */
    record DishRequest(Dish dish, List<DishIngredient> ingredients) {}
}