package com.family.menu.controller;

import com.family.menu.common.Result;
import com.family.menu.dto.MealHistoryVO;
import com.family.menu.dto.MealRecordSaveRequest;
import com.family.menu.service.MealRecordService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

/**
 * 用餐记录 Controller
 */
@RestController
@RequestMapping("/meal-records")
@RequiredArgsConstructor
public class MealRecordController {

    private final MealRecordService mealRecordService;

    /**
     * 保存某天菜单（已存在则覆盖）
     */
    @PostMapping
    public Result<Long> save(@RequestBody MealRecordSaveRequest request) {
        return Result.success(mealRecordService.save(request));
    }

    /**
     * 查询某天菜单
     */
    @GetMapping
    public Result<MealRecordSaveRequest> getByDate(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            @RequestParam(required = false, defaultValue = "dinner") String mealType) {
        return Result.success(mealRecordService.getByDate(date, mealType));
    }

    /**
     * 历史菜单（按日期倒序）
     *
     * @param startDate 起始（可空）
     * @param endDate   结束（可空）
     */
    @GetMapping("/history")
    public Result<List<MealHistoryVO>> history(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        return Result.success(mealRecordService.listHistory(startDate, endDate));
    }

    /**
     * 删除某条记录
     */
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        mealRecordService.delete(id);
        return Result.success();
    }
}
