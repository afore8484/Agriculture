package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class ReconciliationRespVO {

    private String accountName;
    private BigDecimal bookBalance;
    private BigDecimal bankBalance;
    private BigDecimal diffAmount;
}
