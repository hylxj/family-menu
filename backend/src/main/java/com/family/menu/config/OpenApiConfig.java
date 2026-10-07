package com.family.menu.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * OpenAPI 配置（Swagger UI）
 */
@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI customOpenApi() {
        return new OpenAPI()
                .info(new Info()
                        .title("家庭饭桌决策系统 API")
                        .description("川菜家常菜菜单生成 + 购物清单聚合")
                        .version("1.0.0")
                        .contact(new Contact().name("family-menu")));
    }
}