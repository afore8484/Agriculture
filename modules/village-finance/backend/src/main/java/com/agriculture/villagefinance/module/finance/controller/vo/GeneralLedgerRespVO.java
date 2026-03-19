package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class GeneralLedgerRespVO {

    private String subjectCode;
    private String subjectName;
    private BigDecimal openingBalance;
    private BigDecimal debitAmount;
    private BigDecimal creditAmount;
    private BigDecimal closingBalance;
}

