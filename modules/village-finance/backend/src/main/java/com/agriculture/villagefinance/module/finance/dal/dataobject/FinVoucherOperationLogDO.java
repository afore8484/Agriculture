package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("fin_voucher_operation_log")
public class FinVoucherOperationLogDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long voucherId;
    private String operationType;
    private Long operatorId;
    private LocalDateTime operationTime;
    private String operationDesc;
    private String beforeJson;
    private String afterJson;
    private String remark;
}
