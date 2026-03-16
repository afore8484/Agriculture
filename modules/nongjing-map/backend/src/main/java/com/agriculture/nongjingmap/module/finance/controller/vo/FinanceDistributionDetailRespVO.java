package com.agriculture.nongjingmap.module.finance.controller.vo;

import java.math.BigDecimal;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class FinanceDistributionDetailRespVO {
    Integer lineNo;
    String itemCode;
    String itemName;
    BigDecimal amount;
    String remark;
}