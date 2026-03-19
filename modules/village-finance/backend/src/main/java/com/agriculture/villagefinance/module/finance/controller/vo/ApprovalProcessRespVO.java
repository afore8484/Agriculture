package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

@Data
public class ApprovalProcessRespVO {

    private Long processId;
    private String processCode;
    private String processName;
    private String bizType;
    private Integer versionNo;
    private Integer enableFlag;
    private String remark;
}
