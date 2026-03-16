package com.agriculture.nongjingmap.framework.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI nongjingMapOpenApi(
            @Value("${OPENAPI_TITLE:农经一张图后端接口}") String title,
            @Value("${OPENAPI_DESC:农经一张图后端接口文档}") String description) {
        return new OpenAPI()
                .info(new Info()
                        .title(title)
                        .description(description)
                        .version("0.1.0"));
    }
}