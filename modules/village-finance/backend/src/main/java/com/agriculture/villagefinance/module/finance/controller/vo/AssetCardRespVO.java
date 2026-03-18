package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class AssetCardRespVO {

    private Long assetId;
    private String assetCode;
    private String assetName;
    private Long categoryId;
    private String categoryName;
    private Long ledgerId;
    private Long orgId;
    private LocalDate purchaseDate;
    private BigDecimal originalValue;
    private BigDecimal netValue;
    private BigDecimal accumulatedDepreciation;
    private Integer depreciationYears;
    private String depreciationMethod;
    private BigDecimal residualRate;
    private String location;
    private String keeperName;
    private String status;
    private Integer enableFlag;
    private String remark;
}
