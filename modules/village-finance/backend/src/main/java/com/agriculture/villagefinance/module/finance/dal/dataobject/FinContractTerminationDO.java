package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("fin_contract_termination")
public class FinContractTerminationDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long contractId;
    private LocalDate terminationDate;
    private String terminationType;
    private String terminationReason;
    private BigDecimal settlementAmount;
    private Long voucherId;
    private Long operatorId;
    private LocalDateTime createdAt;
    private String remark;
}
