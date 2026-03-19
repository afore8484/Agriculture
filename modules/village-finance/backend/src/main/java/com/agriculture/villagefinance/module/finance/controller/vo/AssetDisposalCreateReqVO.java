package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class AssetDisposalCreateReqVO {

    @NotNull(message = "assetId不能为空")
    private Long assetId;

    @NotBlank(message = "disposalType不能为空")
    private String disposalType;

    @NotNull(message = "disposalDate不能为空")
    private LocalDate disposalDate;

    @NotNull(message = "voucherAmount不能为空")
    private BigDecimal voucherAmount;

    @NotNull(message = "debitSubjectId不能为空")
    private Long debitSubjectId;

    @NotNull(message = "creditSubjectId不能为空")
    private Long creditSubjectId;

    private BigDecimal disposalIncome;
    private BigDecimal disposalLoss;
    private Long operatorId;
    private String remark;
}
