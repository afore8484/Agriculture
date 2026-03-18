package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class AssetDepreciationCreateReqVO {

    @NotNull(message = "assetId不能为空")
    private Long assetId;

    @NotBlank(message = "periodLabel不能为空")
    private String periodLabel;

    @NotNull(message = "depreciationAmount不能为空")
    private BigDecimal depreciationAmount;

    @NotNull(message = "debitSubjectId不能为空")
    private Long debitSubjectId;

    @NotNull(message = "creditSubjectId不能为空")
    private Long creditSubjectId;

    private BigDecimal netValueAfter;
    private Long operatorId;
    private String remark;
}
