package com.agriculture.nongjingmap.module.finance.controller.vo;

import java.math.BigDecimal;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class FinanceDistributionAnalysisRespVO {
    String itemCode;
    String itemName;
    BigDecimal amount;
    BigDecimal rate;
}