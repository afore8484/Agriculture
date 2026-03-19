package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("fin_asset_depreciation")
public class FinAssetDepreciationDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long assetId;
    private Long bookId;
    private String periodLabel;
    private BigDecimal depreciationAmount;
    private BigDecimal accumulatedAmount;
    private BigDecimal netValueAfter;
    private Long voucherId;
    private Long createdBy;
    private LocalDateTime createdAt;
    private String remark;
}
