package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("fin_contract_acceptance")
public class FinContractAcceptanceDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long contractId;
    private LocalDate acceptanceDate;
    private String acceptanceResult;
    private BigDecimal acceptanceAmount;
    private String acceptanceDesc;
    private Long operatorId;
    private LocalDateTime createdAt;
    private String remark;
}
