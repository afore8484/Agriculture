package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ApprovalTaskRespVO {

    private Long taskId;
    private Long instanceId;
    private String taskNo;
    private String nodeName;
    private Long approverId;
    private String taskStatus;
    private String actionType;
    private LocalDateTime actionTime;
    private String actionRemark;
}
