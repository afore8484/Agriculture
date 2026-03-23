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
@TableName("fin_asset_card")
public class FinAssetCardDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String assetCode;
    private String assetName;
    private Long categoryId;
    private Long bookId;
    private Long orgId;
    private LocalDate purchaseDate;
    private BigDecimal originalValue;
    private BigDecimal netValue;
    private BigDecimal accumulatedDepreciation;
    private String depreciationMethod;
    private Integer depreciationYears;
    private BigDecimal residualRate;
    private String location;
    private String keeperName;
    private String status;
    private Integer enableFlag;
    private Long createdBy;
    private LocalDateTime createdAt;
    private Long updatedBy;
    private LocalDateTime updatedAt;
    private String remark;
}

