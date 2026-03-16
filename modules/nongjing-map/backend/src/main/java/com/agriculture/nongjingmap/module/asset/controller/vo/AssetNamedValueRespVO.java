package com.agriculture.nongjingmap.module.asset.controller.vo;

import java.math.BigDecimal;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class AssetNamedValueRespVO {
    String name;
    Integer value;
    BigDecimal share;
}