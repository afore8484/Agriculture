package com.agriculture.nongjingmap.module.finance.controller.vo;

import java.math.BigDecimal;
import java.time.LocalDate;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class FinancePayableRespVO {
    String orgName;
    String creditorName;
    String contractNo;
    BigDecimal amount;
    BigDecimal paidAmount;
    BigDecimal unpaidAmount;
    LocalDate dueDate;
    Integer agingDays;
    String status;
}