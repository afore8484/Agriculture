package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("fin_asset_inventory")
public class FinAssetInventoryDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String inventoryNo;
    private Long bookId;
    private Long orgId;
    private LocalDate inventoryDate;
    private Integer totalAssetCount;
    private Integer actualAssetCount;
    private Integer diffCount;
    private String status;
    private Long createdBy;
    private LocalDateTime createdAt;
    private String remark;
}
