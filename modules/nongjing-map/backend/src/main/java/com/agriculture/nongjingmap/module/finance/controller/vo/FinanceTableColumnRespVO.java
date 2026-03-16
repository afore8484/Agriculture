package com.agriculture.nongjingmap.module.finance.controller.vo;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class FinanceTableColumnRespVO {
    String key;
    String label;
}