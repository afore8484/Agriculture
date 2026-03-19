package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ContractOperationLogRespVO {

    private Long logId;
    private Long contractId;
    private String operationType;
    private String operationDesc;
    private Long operatorId;
    private LocalDateTime operationTime;
    private String beforeJson;
    private String afterJson;
    private String remark;
}
