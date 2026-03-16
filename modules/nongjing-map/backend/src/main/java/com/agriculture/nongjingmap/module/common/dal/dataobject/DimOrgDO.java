package com.agriculture.nongjingmap.module.common.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@TableName("dim_org")
@Data
public class DimOrgDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String orgCode;
    private String orgName;
    private String regionCode;
    private String orgLevel;
    private String parentOrgCode;
}