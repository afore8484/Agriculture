package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class DetailLedgerRespVO {

    private String voucherNo;
    private LocalDate voucherDate;
    private String summary;
    private BigDecimal debitAmount;
    private BigDecimal creditAmount;
    private BigDecimal balance;
}

