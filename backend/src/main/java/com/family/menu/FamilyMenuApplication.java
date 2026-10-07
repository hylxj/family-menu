package com.family.menu;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;

/**
 * 家庭饭桌决策系统 - 启动入口
 *
 * @author family-menu
 */
@EnableAsync
@SpringBootApplication
@MapperScan("com.family.menu.mapper")
public class FamilyMenuApplication {

    public static void main(String[] args) {
        SpringApplication.run(FamilyMenuApplication.class, args);
        System.out.println("""
                
                ==================================================
                   🍽️  家庭饭桌决策系统 - 启动成功
                   📖  API 文档: http://localhost:8080/api/doc.html
                ==================================================
                """);
    }
}