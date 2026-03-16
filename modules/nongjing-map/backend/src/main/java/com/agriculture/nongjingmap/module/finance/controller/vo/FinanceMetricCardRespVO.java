package com.agriculture.nongjingmap.module.finance.controller.vo;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class FinanceMetricCardRespVO {
    String label;
    String value;
    String hint;
    String status;
}