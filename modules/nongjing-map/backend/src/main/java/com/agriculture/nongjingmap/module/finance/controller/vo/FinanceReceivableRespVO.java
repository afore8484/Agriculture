package com.agriculture.nongjingmap.module.finance.controller.vo;

import java.math.BigDecimal;
import java.time.LocalDate;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class FinanceReceivableRespVO {
    String orgName;
    String debtorName;
    String contractNo;
    BigDecimal amount;
    BigDecimal receivedAmount;
    BigDecimal unreceivedAmount;
    LocalDate dueDate;
    Integer agingDays;
    String status;
}