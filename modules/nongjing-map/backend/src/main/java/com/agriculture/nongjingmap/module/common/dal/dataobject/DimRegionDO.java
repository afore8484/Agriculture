package com.agriculture.nongjingmap.module.common.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@TableName("dim_region")
@Data
public class DimRegionDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String regionCode;
    private String regionName;
    private String parentCode;
    private String regionLevel;
    private Integer sortNo;
    private String geomWkt;
    private String centroidWkt;
}