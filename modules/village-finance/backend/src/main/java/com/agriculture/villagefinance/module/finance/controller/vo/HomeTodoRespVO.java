package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class HomeTodoRespVO {

    private Long todoId;
    private String todoType;
    private String title;
    private LocalDateTime createTime;

    private Long taskId;
    private Long instanceId;
    private String bizType;
    private Long bizId;
    private String nodeName;
    private String taskStatus;
    private String urgency;
}
