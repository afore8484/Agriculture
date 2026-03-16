package com.agriculture.nongjingmap.module.finance.controller.vo;

import java.math.BigDecimal;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class FinanceOverviewSummaryRespVO {
    BigDecimal totalIncome;
    BigDecimal totalExpense;
    BigDecimal yearProfit;
    BigDecimal undistributedProfit;
    Integer unclosedCount;
    Integer noLedgerCount;
}