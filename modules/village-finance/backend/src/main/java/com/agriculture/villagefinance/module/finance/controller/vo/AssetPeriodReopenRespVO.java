package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class AssetPeriodReopenRespVO {

    private Long reopenId;
    private String reopenNo;
    private String periodStatus;
    private LocalDateTime operateTime;
}
