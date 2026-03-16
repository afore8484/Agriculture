package com.agriculture.nongjingmap.module.asset.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import lombok.Data;

@TableName("fact_asset_summary_monthly")
@Data
public class FactAssetSummaryMonthlyDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String periodMonth;
    private String regionCode;
    private String orgCode;
    private BigDecimal assetTotalValue;
    private BigDecimal operatingAssetValue;
    private BigDecimal nonOperatingAssetValue;
    private Integer assetCount;
    private Integer operatingAssetCount;
    private Integer nonOperatingAssetCount;
}