package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import cn.iocoder.yudao.framework.tenant.core.aop.TenantIgnore;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TenantIgnore
@TableName("fin_approve_task")
public class FinApproveTaskDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long instanceId;
    private String taskNo;
    private String nodeName;
    private Long approverId;
    private String taskStatus;
    private String actionType;
    private LocalDateTime actionTime;
    private String actionRemark;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}

