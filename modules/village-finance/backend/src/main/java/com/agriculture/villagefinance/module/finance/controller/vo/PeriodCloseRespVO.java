package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class PeriodCloseRespVO {

    private Long closeId;
    private String closeStatus;
    private LocalDateTime closeTime;
}
