package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class PeriodReopenRespVO {

    private Long reopenId;
    private String periodStatus;
    private LocalDateTime operateTime;
}
