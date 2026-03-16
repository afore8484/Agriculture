package com.agriculture.nongjingmap.module.common.controller.vo;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class DictItemRespVO {
    String dictType;
    String itemCode;
    String itemName;
    Integer sortNo;
    String remark;
}