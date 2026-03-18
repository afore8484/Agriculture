package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class AssetDisposalRespVO {

    private Long disposalId;
    private Long assetId;
    private String disposalType;
    private LocalDate disposalDate;
    private BigDecimal disposalIncome;
    private BigDecimal disposalLoss;
    private BigDecimal netValue;
    private Long voucherId;
    private String status;
    private LocalDateTime createdAt;
}
