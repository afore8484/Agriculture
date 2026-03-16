package com.agriculture.nongjingmap.module.common.controller.vo;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class RegionRespVO {
    String regionCode;
    String regionName;
    String parentCode;
    String regionLevel;
    Integer sortNo;
    String centroidWkt;
}