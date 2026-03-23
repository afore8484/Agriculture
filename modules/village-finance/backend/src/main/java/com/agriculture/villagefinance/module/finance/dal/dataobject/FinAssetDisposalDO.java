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
@TableName("fin_asset_disposal")
public class FinAssetDisposalDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long assetId;
    private String disposalType;
    private LocalDate disposalDate;
    private BigDecimal disposalIncome;
    private BigDecimal disposalLoss;
    private BigDecimal netValue;
    private Long voucherId;
    private String status;
    private Long createdBy;
    private LocalDateTime createdAt;
    private String remark;
}

