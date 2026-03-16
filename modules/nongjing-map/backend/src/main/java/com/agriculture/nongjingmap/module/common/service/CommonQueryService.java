package com.agriculture.nongjingmap.module.common.service;

import com.agriculture.nongjingmap.module.common.controller.vo.DictItemRespVO;
import com.agriculture.nongjingmap.module.common.controller.vo.MetricRespVO;
import com.agriculture.nongjingmap.module.common.controller.vo.RegionRespVO;
import com.agriculture.nongjingmap.module.common.controller.vo.TimeDimensionRespVO;
import java.util.List;

public interface CommonQueryService {

    List<RegionRespVO> listRegions(String parentCode, String regionLevel);

    RegionRespVO getRegionDetail(String regionCode);

    List<TimeDimensionRespVO> listTimeDimensions(Integer yearNo);

    List<MetricRespVO> listMetrics(String metricCategory);

    List<DictItemRespVO> listDictItems(String dictType);
}