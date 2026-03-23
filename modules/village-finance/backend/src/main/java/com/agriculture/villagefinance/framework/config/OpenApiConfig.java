package com.agriculture.villagefinance.framework.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConditionalOnProperty(prefix = "village-finance.openapi", name = "enabled", havingValue = "true")
public class OpenApiConfig {

    @Bean
    public OpenAPI villageFinanceOpenApi() {
        return new OpenAPI()
                .info(new Info()
                        .title("Village Finance Backend API")
                        .description("Village finance backend interfaces for ledger, period and subject foundation data")
                        .version("0.1.0"));
    }
}
