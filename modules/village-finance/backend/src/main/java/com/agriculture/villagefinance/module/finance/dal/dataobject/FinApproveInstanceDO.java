package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("fin_approve_instance")
public class FinApproveInstanceDO {

    @TableId(type = IdType.AUTO)
    private Long id;
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
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
