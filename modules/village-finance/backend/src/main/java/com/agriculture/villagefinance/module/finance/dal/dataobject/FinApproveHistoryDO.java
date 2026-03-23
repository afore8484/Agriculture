package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("fin_approve_history")
public class FinApproveHistoryDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long instanceId;
    private String nodeName;
    private Long approverId;
    private String actionType;
    private String actionResult;
    private LocalDateTime actionTime;
    private String actionRemark;
    private LocalDateTime createdAt;
}
