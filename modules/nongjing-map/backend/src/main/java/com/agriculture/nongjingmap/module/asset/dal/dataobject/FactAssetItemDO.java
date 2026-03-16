package com.agriculture.nongjingmap.module.asset.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import java.time.LocalDate;
import lombok.Data;

@TableName("fact_asset_item")
@Data
public class FactAssetItemDO {

    @TableId(type = IdType.AUTO)
    private Long assetId;
    private String regionCode;
    private String orgCode;
    private String assetCode;
    private String assetName;
    private String assetType;
    private String assetNature;
    private String assetSource;
    private String locationDesc;
    private BigDecimal quantity;
    private String unit;
    private BigDecimal originalValue;
    private BigDecimal assessedValue;
    private BigDecimal bookValue;
    private String usableStatus;
    private LocalDate acquireDate;
    private LocalDate disposeDate;
    private String periodMonth;
    private String remark;
}