package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class AssetInventoryDetailRespVO {

    private Long detailId;
    private Long inventoryId;
    private Long assetId;
    private String assetCode;
    private String assetName;
    private BigDecimal bookValue;
    private BigDecimal actualValue;
    private BigDecimal diffValue;
    private String resultType;
    private String remark;
}
