package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class MultiLedgerRespVO {

    private String columnName;
    private BigDecimal amount;
}

