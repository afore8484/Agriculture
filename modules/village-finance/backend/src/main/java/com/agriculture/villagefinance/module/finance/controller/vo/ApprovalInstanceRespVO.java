package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ApprovalInstanceRespVO {

    private Long instanceId;
    private Long processId;
    private String bizType;
    private Long bizId;
    private String instanceNo;
    private Long applicantId;
    private String currentNode;
    private String approveStatus;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private String remark;
}
