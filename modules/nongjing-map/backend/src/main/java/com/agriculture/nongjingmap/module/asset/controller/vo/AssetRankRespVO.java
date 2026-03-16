package com.agriculture.nongjingmap.module.asset.controller.vo;

import java.math.BigDecimal;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class AssetRankRespVO {
    Integer rankNo;
    String regionCode;
    String regionName;
    BigDecimal assetValue;
    String topAsset;
    String status;
}