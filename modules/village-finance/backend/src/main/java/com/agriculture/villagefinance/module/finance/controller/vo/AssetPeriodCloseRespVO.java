package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class AssetPeriodCloseRespVO {

    private Long closeId;
    private String closeNo;
    private String closeStatus;
    private LocalDateTime closeTime;
}
