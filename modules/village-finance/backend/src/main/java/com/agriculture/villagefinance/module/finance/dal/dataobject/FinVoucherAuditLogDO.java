package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("fin_voucher_audit_log")
public class FinVoucherAuditLogDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long voucherId;
    private String auditAction;
    private Long auditorId;
    private LocalDateTime auditTime;
    private String remark;
}
