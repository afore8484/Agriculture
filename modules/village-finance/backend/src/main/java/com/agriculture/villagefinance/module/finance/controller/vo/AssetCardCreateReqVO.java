package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class AssetCardCreateReqVO {

    @NotBlank(message = "assetCode不能为空")
    private String assetCode;

    @NotBlank(message = "assetName不能为空")
    private String assetName;

    @NotNull(message = "categoryId不能为空")
    private Long categoryId;

    @NotNull(message = "ledgerId不能为空")
    private Long ledgerId;

    @NotNull(message = "orgId不能为空")
    private Long orgId;

    private LocalDate purchaseDate;
    private BigDecimal originalValue;
    private BigDecimal netValue;
    private Integer depreciationYears;
    private String depreciationMethod;
    private BigDecimal residualRate;
    private String location;
    private String keeperName;
    private String status;
    private Integer enableFlag;
    private Long operatorId;
    private String remark;
}
