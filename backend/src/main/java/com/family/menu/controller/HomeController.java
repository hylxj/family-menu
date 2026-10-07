package com.family.menu.controller;

import com.family.menu.common.Result;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

/**
 * 健康检查 + 首页
 */
@RestController
@RequestMapping("/")
public class HomeController {

    @GetMapping("/health")
    public Result<Map<String, Object>> health() {
        Map<String, Object> data = new HashMap<>();
        data.put("status", "UP");
        data.put("service", "family-menu-backend");
        data.put("timestamp", LocalDateTime.now());
        return Result.success(data);
    }
}