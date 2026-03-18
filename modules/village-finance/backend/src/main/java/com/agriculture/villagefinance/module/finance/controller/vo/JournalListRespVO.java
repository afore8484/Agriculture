package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class JournalListRespVO {

    private Long journalId;
    private LocalDate txnDate;
    private String summary;
    private BigDecimal incomeAmount;
    private BigDecimal expenseAmount;
    private BigDecimal balance;
    private String status;
}
