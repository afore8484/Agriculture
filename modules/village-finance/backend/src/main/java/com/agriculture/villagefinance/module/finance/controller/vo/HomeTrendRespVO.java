package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class HomeTrendRespVO {

    private String periodLabel;
    private BigDecimal incomeAmount;
    private BigDecimal expenseAmount;
}
