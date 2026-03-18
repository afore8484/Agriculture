package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;

@Data
@TableName("fin_asset_inventory_detail")
public class FinAssetInventoryDetailDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long inventoryId;
    private Long assetId;
    private BigDecimal bookValue;
    private BigDecimal actualValue;
    private BigDecimal diffValue;
    private String resultType;
    private String remark;
}
