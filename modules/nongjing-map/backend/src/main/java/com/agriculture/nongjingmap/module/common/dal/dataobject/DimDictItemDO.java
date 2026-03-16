package com.agriculture.nongjingmap.module.common.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@TableName("dim_dict_item")
@Data
public class DimDictItemDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String dictType;
    private String itemCode;
    private String itemName;
    private Integer sortNo;
    private String remark;
}