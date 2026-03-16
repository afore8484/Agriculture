package com.agriculture.nongjingmap.module.finance.controller.vo;

import java.math.BigDecimal;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class FinanceTrendPointRespVO {
    String label;
    BigDecimal value;
    BigDecimal value2;
    BigDecimal value3;
}