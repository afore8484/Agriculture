package com.agriculture.nongjingmap.module.resource.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import lombok.Data;

@TableName("fact_resource_item")
@Data
public class FactResourceItemDO {

    @TableId(type = IdType.AUTO)
    private Long resourceId;
    private String regionCode;
    private String orgCode;
    private String resourceCode;
    private String resourceName;
    private String resourceType;
    private String resourceSubtype;
    private String ownershipType;
    private String locationDesc;
    private BigDecimal area;
    private BigDecimal quantity;
    private String unit;
    private BigDecimal estimatedValue;
    private String usableStatus;
    private String periodMonth;
    private String remark;
}