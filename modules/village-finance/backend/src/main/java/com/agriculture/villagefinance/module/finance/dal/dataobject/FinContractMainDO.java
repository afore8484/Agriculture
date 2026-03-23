package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import cn.iocoder.yudao.framework.tenant.core.aop.TenantIgnore;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TenantIgnore
@TableName("fin_contract_main")
public class FinContractMainDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String contractNo;
    private String contractName;
    private String contractType;
    private BigDecimal contractAmount;
    private LocalDate signDate;
    private LocalDate startDate;
    private LocalDate endDate;
    private String counterpartyUnit;
    private String counterpartyPerson;
    private Long orgId;
    private Long bookId;
    private String status;
    private Integer enableFlag;
    private Long createdBy;
    private LocalDateTime createdAt;
    private Long updatedBy;
    private LocalDateTime updatedAt;
    private String remark;
}

