package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class ContractRespVO {

    private Long contractId;
    private String contractNo;
    private String contractName;
    private String contractType;
    private BigDecimal contractAmount;
    private LocalDate signDate;
    private LocalDate startDate;
    private LocalDate endDate;
    private String counterpartyUnit;
    private String counterpartyPerson;
    private Long orgId;
    private Long ledgerId;
    private String status;
    private Integer enableFlag;
    private String remark;
}
