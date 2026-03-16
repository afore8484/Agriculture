package com.agriculture.nongjingmap.module.finance.controller.vo;

import java.math.BigDecimal;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class FinanceIncomeBandStatsRespVO {
    String bandCode;
    String bandName;
    Integer highCount;
    Integer lowCount;
    BigDecimal highRate;
    BigDecimal lowRate;
}