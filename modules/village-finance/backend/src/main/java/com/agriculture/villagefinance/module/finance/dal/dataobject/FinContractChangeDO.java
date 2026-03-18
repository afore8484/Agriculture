package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("fin_contract_change")
public class FinContractChangeDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long contractId;
    private String changeType;
    private LocalDate changeDate;
    private BigDecimal beforeAmount;
    private BigDecimal afterAmount;
    private LocalDate beforeEndDate;
    private LocalDate afterEndDate;
    private String changeContent;
    private Long voucherId;
    private Long createdBy;
    private LocalDateTime createdAt;
    private String remark;
}
