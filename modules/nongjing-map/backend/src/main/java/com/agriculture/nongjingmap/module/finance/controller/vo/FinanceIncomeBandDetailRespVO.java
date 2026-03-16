package com.agriculture.nongjingmap.module.finance.controller.vo;

import java.math.BigDecimal;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class FinanceIncomeBandDetailRespVO {
    String orgCode;
    String orgName;
    BigDecimal totalIncome;
    BigDecimal operatingIncome;
    BigDecimal subsidyIncome;
    BigDecimal investmentIncome;
    BigDecimal otherIncome;
}