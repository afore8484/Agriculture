package com.agriculture.nongjingmap.module.asset.controller.vo;

import java.math.BigDecimal;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class AssetTrendRespVO {
    String yearMonth;
    BigDecimal assetTotalValue;
    BigDecimal businessAssetTotal;
    BigDecimal nonBusinessAssetTotal;
}