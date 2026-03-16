package com.agriculture.nongjingmap.module.finance.controller.vo;

import java.math.BigDecimal;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class FinanceStatementLineRespVO {
    Integer lineNo;
    String lineCode;
    String lineName;
    BigDecimal beginAmount;
    BigDecimal endAmount;
    BigDecimal changeAmount;
    String lineCategory;
}