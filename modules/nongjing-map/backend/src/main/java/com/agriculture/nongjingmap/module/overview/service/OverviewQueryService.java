package com.agriculture.nongjingmap.module.overview.service;

import com.agriculture.nongjingmap.module.overview.controller.vo.MapStatRespVO;
import com.agriculture.nongjingmap.module.overview.controller.vo.OverviewCardsRespVO;
import com.agriculture.nongjingmap.module.overview.controller.vo.WeatherRespVO;
import java.util.List;

public interface OverviewQueryService {

    WeatherRespVO getWeather(String regionCode);

    OverviewCardsRespVO getOverviewCards(String regionCode, String statMonth);

    List<MapStatRespVO> listMapStats(String metricCode, String statMonth, Integer limit);
}