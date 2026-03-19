package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class AssistBalanceRespVO {

    private String itemName;
    private BigDecimal openingBalance;
    private BigDecimal debitAmount;
    private BigDecimal creditAmount;
    private BigDecimal closingBalance;
}

