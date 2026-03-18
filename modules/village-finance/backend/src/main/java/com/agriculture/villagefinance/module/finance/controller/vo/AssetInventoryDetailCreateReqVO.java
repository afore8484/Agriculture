package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class AssetInventoryDetailCreateReqVO {

    @NotNull(message = "inventoryId不能为空")
    private Long inventoryId;

    @NotNull(message = "assetId不能为空")
    private Long assetId;

    @NotNull(message = "actualValue不能为空")
    private BigDecimal actualValue;

    private String remark;
}
