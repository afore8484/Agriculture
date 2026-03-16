package com.agriculture.nongjingmap.module.finance.controller.vo;

import java.math.BigDecimal;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class FinanceIncomeBandTrendRespVO {
    String yearMonth;
    String bandCode;
    Integer highCount;
    Integer lowCount;
    BigDecimal highRate;
    BigDecimal lowRate;
}