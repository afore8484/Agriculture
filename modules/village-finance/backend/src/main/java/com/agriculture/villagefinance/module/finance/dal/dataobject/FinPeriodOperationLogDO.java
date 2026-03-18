package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("fin_period_operation_log")
public class FinPeriodOperationLogDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long periodId;
    private String operationType;
    private Long operatorId;
    private LocalDateTime operationTime;
    private String beforeStatus;
    private String afterStatus;
    private String operationDesc;
}
