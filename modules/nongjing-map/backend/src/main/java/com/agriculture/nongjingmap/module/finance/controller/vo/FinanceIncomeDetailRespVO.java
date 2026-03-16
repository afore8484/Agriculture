package com.agriculture.nongjingmap.module.finance.controller.vo;

import java.math.BigDecimal;
import java.time.LocalDate;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class FinanceIncomeDetailRespVO {
    LocalDate bizDate;
    String orgName;
    String incomeType;
    String incomeItemName;
    String counterpartyName;
    BigDecimal amount;
    String sourceDocNo;
}