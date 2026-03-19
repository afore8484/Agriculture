package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ApprovalHistoryRespVO {

    private Long historyId;
    private Long instanceId;
    private String nodeName;
    private Long approverId;
    private String actionType;
    private String actionResult;
    private LocalDateTime actionTime;
    private String actionRemark;
}
