package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("fin_contract_operation_log")
public class FinContractOperationLogDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long contractId;
    private String operationType;
    private String operationDesc;
    private Long operatorId;
    private LocalDateTime operationTime;
    private String beforeJson;
    private String afterJson;
    private String remark;
}
