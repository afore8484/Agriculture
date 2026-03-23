package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class HomeAssetDistributionRespVO {

    private String categoryName;
    private BigDecimal amount;
}
