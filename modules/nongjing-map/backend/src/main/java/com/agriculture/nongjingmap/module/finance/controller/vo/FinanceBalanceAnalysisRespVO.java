package com.agriculture.nongjingmap.module.finance.controller.vo;

import java.math.BigDecimal;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class FinanceBalanceAnalysisRespVO {
    String itemName;
    BigDecimal beginValue;
    BigDecimal endValue;
    BigDecimal changeValue;
    BigDecimal changeRate;
}