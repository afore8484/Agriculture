package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class AssetInventoryRespVO {

    private Long inventoryId;
    private String inventoryNo;
    private Long ledgerId;
    private Long orgId;
    private LocalDate inventoryDate;
    private Integer totalAssetCount;
    private Integer actualAssetCount;
    private Integer diffCount;
    private String status;
    private LocalDateTime createdAt;
    private List<AssetInventoryDetailRespVO> details;
}
