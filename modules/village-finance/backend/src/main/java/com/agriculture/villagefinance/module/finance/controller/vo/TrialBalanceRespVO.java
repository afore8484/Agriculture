package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

@Data
public class TrialBalanceRespVO {

    private Long trialId;
    private String checkResult;
    private Integer errorCount;
}
