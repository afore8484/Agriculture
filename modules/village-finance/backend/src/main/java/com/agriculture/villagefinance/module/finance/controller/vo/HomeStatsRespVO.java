package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class HomeStatsRespVO {

    private Long ledgerId;
    private Long periodId;
    private BigDecimal incomeAmount;
    private BigDecimal expenseAmount;
    private BigDecimal assetAmount;
    private Long pendingTodoCount;
    private Long urgentTodoCount;
}
