package com.agriculture.nongjingmap.module.asset.controller.vo;

import java.math.BigDecimal;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class AssetListRespVO {
    String assetCode;
    String assetName;
    String assetType;
    String regionName;
    BigDecimal bookValue;
    String operatorState;
}