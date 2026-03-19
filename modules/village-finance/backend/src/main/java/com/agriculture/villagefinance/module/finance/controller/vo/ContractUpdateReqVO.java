package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class ContractUpdateReqVO {

    @NotNull(message = "contractId不能为空")
    private Long contractId;

    @NotBlank(message = "contractName不能为空")
    private String contractName;

    @NotBlank(message = "contractType不能为空")
    private String contractType;

    @NotNull(message = "contractAmount不能为空")
    private BigDecimal contractAmount;

    @NotNull(message = "signDate不能为空")
    private LocalDate signDate;

    private LocalDate startDate;
    private LocalDate endDate;
    private String counterpartyUnit;
    private String counterpartyPerson;
    private String status;
    private Integer enableFlag;
    private Long operatorId;
    private String remark;
}
