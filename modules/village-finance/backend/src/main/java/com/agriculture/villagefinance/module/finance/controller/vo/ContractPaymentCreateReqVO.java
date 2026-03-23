package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class ContractPaymentCreateReqVO {

    @NotNull(message = "contractId不能为空")
    private Long contractId;

    @NotNull(message = "paymentDate不能为空")
    private LocalDate paymentDate;

    @NotNull(message = "amount不能为空")
    private BigDecimal amount;

    private Long bankAccountId;
    private Long cashAccountId;

    @NotNull(message = "counterpartySubjectId不能为空")
    private Long counterpartySubjectId;

    private String summary;
    private Long operatorId;
    private String remark;
}
