package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class AssetCategoryCreateReqVO {

    @NotBlank(message = "categoryCode不能为空")
    private String categoryCode;

    @NotBlank(message = "categoryName不能为空")
    private String categoryName;

    private Long parentId;
    private Integer depreciationYears;
    private String depreciationMethod;
    private BigDecimal residualRate;
    private Integer enableFlag;
    private Long operatorId;
    private String remark;
}
