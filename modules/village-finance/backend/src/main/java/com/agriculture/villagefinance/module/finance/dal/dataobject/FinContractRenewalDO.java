package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("fin_contract_renewal")
public class FinContractRenewalDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long contractId;
    private String renewalNo;
    private LocalDate renewalDate;
    private LocalDate renewalStartDate;
    private LocalDate renewalEndDate;
    private BigDecimal renewalAmount;
    private String renewalContent;
    private String status;
    private Long createdBy;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String remark;
}
