package com.agriculture.nongjingmap.module.resource.controller.vo;

import java.math.BigDecimal;
import java.util.List;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class ResourceSummaryRespVO {
    BigDecimal farmLandArea;
    BigDecimal constructLandArea;
    BigDecimal unusedLandArea;
    BigDecimal totalArea;
    List<ResourceMetricCardRespVO> kpis;
    List<ResourceNamedValueRespVO> typeStats;
    ResourceTableDataRespVO districtStats;
    ResourceTableDataRespVO dispatchTable;
    List<String> layerTips;
}