package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class AssetDepreciationRespVO {

    private Long depreciationId;
    private Long assetId;
    private String periodLabel;
    private BigDecimal depreciationAmount;
    private BigDecimal accumulatedAmount;
    private BigDecimal netValueAfter;
    private Long voucherId;
    private LocalDateTime createdAt;
}
