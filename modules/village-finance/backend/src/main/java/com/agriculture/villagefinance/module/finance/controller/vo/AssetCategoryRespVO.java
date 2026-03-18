package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class AssetCategoryRespVO {

    private Long categoryId;
    private String categoryCode;
    private String categoryName;
    private Long parentId;
    private Integer depreciationYears;
    private String depreciationMethod;
    private BigDecimal residualRate;
    private Integer enableFlag;
    private String remark;
}
