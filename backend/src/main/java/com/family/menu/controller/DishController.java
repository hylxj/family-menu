package com.family.menu.controller;

import com.family.menu.common.Result;
import com.family.menu.entity.Dish;
import com.family.menu.entity.DishIngredient;
import com.family.menu.service.DishService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 菜谱 Controller
 */
@RestController
@RequestMapping("/dishes")
@RequiredArgsConstructor
public class DishController {

    private final DishService dishService;

    @GetMapping
    public Result<List<Dish>> list(@RequestParam(required = false) String category,
                                   @RequestParam(required = false) String keyword) {
        return Result.success(dishService.list(category, keyword));
    }

    @GetMapping("/{id}")
    public Result<Object> detail(@PathVariable Long id) {
        return Result.success(dishService.getDetail(id));
    }

    @PostMapping
    public Result<Long> save(@RequestBody DishService.DishRequest request) {
        return Result.success(dishService.save(request));
    }

    @PutMapping("/{id}")
    public Result<Long> update(@PathVariable Long id, @RequestBody DishService.DishRequest request) {
        if (request.dish() != null) {
            request.dish().setId(id);
        }
        return Result.success(dishService.save(request));
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        dishService.delete(id);
        return Result.success();
    }

    @PostMapping("/batch")
    public Result<Integer> batch(@RequestBody List<com.family.menu.dto.DishSaveRequest> requests) {
        return Result.success(dishService.batchSave(requests));
    }

    @GetMapping("/ingredients")
    public Result<List<String>> ingredients() {
        return Result.success(dishService.allIngredientNames());
    }

    /**
     * 只更新某道菜的食材（不修改菜品本身）
     * 用途：菜谱库/本周菜单点开后增删改食材
     */
    @PutMapping("/{id}/ingredients")
    public Result<Integer> updateIngredients(@PathVariable Long id,
                                             @RequestBody List<DishIngredient> ingredients) {
        return Result.success(dishService.updateIngredients(id, ingredients));
    }
}
