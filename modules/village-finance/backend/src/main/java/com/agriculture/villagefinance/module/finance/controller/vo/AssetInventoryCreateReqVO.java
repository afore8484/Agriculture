package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDate;

@Data
public class AssetInventoryCreateReqVO {

    @NotNull(message = "ledgerId不能为空")
    private Long ledgerId;

    @NotNull(message = "orgId不能为空")
    private Long orgId;

    @NotNull(message = "inventoryDate不能为空")
    private LocalDate inventoryDate;

    private Long operatorId;
    private String remark;
}
