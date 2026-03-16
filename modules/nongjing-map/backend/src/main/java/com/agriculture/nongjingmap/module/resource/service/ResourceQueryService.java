package com.agriculture.nongjingmap.module.resource.service;

import com.agriculture.nongjingmap.module.resource.controller.vo.*;
import java.util.List;

public interface ResourceQueryService {

    ResourceSummaryRespVO getSummary(String regionCode, String yearMonth);

    List<ResourceNamedValueRespVO> listTypeDistribution(String regionCode, String yearMonth);

    List<ResourceTrendRespVO> listTrend(String regionCode, String startMonth, String endMonth);

    List<ResourceDistrictRespVO> listDistrictStats(String regionCode, String yearMonth);

    List<ResourceListRespVO> listResources(String regionCode, String yearMonth, String resourceType);

    List<ResourceFetchJobRespVO> listFetchJobs(String regionCode, String status);
}