package com.family.menu.controller;

import com.family.menu.common.Result;
import com.family.menu.dto.WeekMenuVO;
import com.family.menu.entity.Dish;
import com.family.menu.service.MenuService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

/**
 * 菜单生成 Controller
 */
@RestController
@RequestMapping("/menu")
@RequiredArgsConstructor
public class MenuController {

    private final MenuService menuService;

    /**
     * 生成菜单
     *
     * @param startDate 起始日期 (yyyy-MM-dd)，默认今天
     * @param days 天数，默认 7
     * @param historyDays 历史去重天数，默认 14
     */
    @PostMapping("/generate")
    public Result<WeekMenuVO> generate(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(defaultValue = "7") Integer days,
            @RequestParam(defaultValue = "14") Integer historyDays) {
        if (startDate == null) startDate = LocalDate.now();
        return Result.success(menuService.generateWeekMenu(startDate, days, historyDays));
    }

    /**
     * GET 方式（方便测试）
     */
    @GetMapping("/generate")
    public Result<WeekMenuVO> generateGet(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(defaultValue = "7") Integer days,
            @RequestParam(defaultValue = "14") Integer historyDays) {
        if (startDate == null) startDate = LocalDate.now();
        return Result.success(menuService.generateWeekMenu(startDate, days, historyDays));
    }

    /**
     * 换一道菜（基于当前已选 + 历史去重）
     */
    @PostMapping("/swap")
    public Result<Dish> swap(@RequestParam String category,
                             @RequestBody(required = false) List<Long> excludeDishIds,
                             @RequestParam(required = false, defaultValue = "3") Integer spicyLevel) {
        return Result.success(menuService.swapDish(category, excludeDishIds, spicyLevel));
    }
}