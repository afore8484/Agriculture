package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class BankAccountRespVO {

    private Long accountId;
    private String accountName;
    private String bankName;
    private String accountNo;
    private Long subjectId;
    private BigDecimal initBalance;
    private BigDecimal currentBalance;
    private String status;
}
