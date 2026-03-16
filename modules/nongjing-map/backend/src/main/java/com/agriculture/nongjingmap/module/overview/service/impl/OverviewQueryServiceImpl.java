package com.agriculture.nongjingmap.module.overview.service.impl;

import com.agriculture.nongjingmap.module.overview.controller.vo.MapStatRespVO;
import com.agriculture.nongjingmap.module.overview.controller.vo.OverviewCardsRespVO;
import com.agriculture.nongjingmap.module.overview.controller.vo.WeatherRespVO;
import com.agriculture.nongjingmap.module.overview.dal.dataobject.FactWeatherDailyDO;
import com.agriculture.nongjingmap.module.overview.dal.dataobject.MvFinanceOverviewMonthlyDO;
import com.agriculture.nongjingmap.module.overview.dal.dataobject.MvRegionTopicRankMonthlyDO;
import com.agriculture.nongjingmap.module.overview.dal.mysql.FactWeatherDailyMapper;
import com.agriculture.nongjingmap.module.overview.dal.mysql.MvFinanceOverviewMonthlyMapper;
import com.agriculture.nongjingmap.module.overview.dal.mysql.MvRegionTopicRankMonthlyMapper;
import com.agriculture.nongjingmap.module.overview.service.OverviewQueryService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class OverviewQueryServiceImpl implements OverviewQueryService {

    private final FactWeatherDailyMapper factWeatherDailyMapper;
    private final MvFinanceOverviewMonthlyMapper mvFinanceOverviewMonthlyMapper;
    private final MvRegionTopicRankMonthlyMapper mvRegionTopicRankMonthlyMapper;

    public OverviewQueryServiceImpl(
            FactWeatherDailyMapper factWeatherDailyMapper,
            MvFinanceOverviewMonthlyMapper mvFinanceOverviewMonthlyMapper,
            MvRegionTopicRankMonthlyMapper mvRegionTopicRankMonthlyMapper) {
        this.factWeatherDailyMapper = factWeatherDailyMapper;
        this.mvFinanceOverviewMonthlyMapper = mvFinanceOverviewMonthlyMapper;
        this.mvRegionTopicRankMonthlyMapper = mvRegionTopicRankMonthlyMapper;
    }

    @Override
    public WeatherRespVO getWeather(String regionCode) {
        String finalRegionCode = StringUtils.hasText(regionCode) ? regionCode : "460000";
        LambdaQueryWrapper<FactWeatherDailyDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FactWeatherDailyDO::getRegionCode, finalRegionCode)
                .le(FactWeatherDailyDO::getWeatherDate, LocalDate.now())
                .orderByDesc(FactWeatherDailyDO::getWeatherDate)
                .last("LIMIT 1");
        FactWeatherDailyDO record = factWeatherDailyMapper.selectOne(wrapper);
        if (record == null && !"460000".equals(finalRegionCode)) {
            return getWeather("460000");
        }
        if (record == null) {
            return null;
        }
        return WeatherRespVO.builder()
                .regionCode(record.getRegionCode())
                .weatherDate(record.getWeatherDate())
                .weatherType(record.getWeatherType())
                .temperatureText(record.getTemperatureText())
                .windText(record.getWindText())
                .humidityText(record.getHumidityText())
                .build();
    }

    @Override
    public OverviewCardsRespVO getOverviewCards(String regionCode, String statMonth) {
        String finalRegionCode = StringUtils.hasText(regionCode) ? regionCode : "460000";
        String finalStatMonth = StringUtils.hasText(statMonth) ? statMonth : latestStatMonth();
        LambdaQueryWrapper<MvFinanceOverviewMonthlyDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(MvFinanceOverviewMonthlyDO::getRegionCode, finalRegionCode)
                .eq(MvFinanceOverviewMonthlyDO::getStatMonth, finalStatMonth)
                .last("LIMIT 1");
        MvFinanceOverviewMonthlyDO record = mvFinanceOverviewMonthlyMapper.selectOne(wrapper);
        if (record == null && !"460000".equals(finalRegionCode)) {
            return getOverviewCards("460000", finalStatMonth);
        }
        if (record == null) {
            return null;
        }
        return OverviewCardsRespVO.builder()
                .regionCode(record.getRegionCode())
                .statMonth(record.getStatMonth())
                .orgCount(record.getOrgCount())
                .townshipCount(record.getTownshipCount())
                .villageCount(record.getVillageCount())
                .unsettledCount(record.getUnsettledCount())
                .noBookCount(record.getNoBookCount())
                .warningCount(record.getWarningCount())
                .incomeTotal(record.getIncomeTotal())
                .build();
    }

    @Override
    public List<MapStatRespVO> listMapStats(String metricCode, String statMonth, Integer limit) {
        String finalMetricCode = StringUtils.hasText(metricCode) ? metricCode : "OVR.ORG.COUNT";
        String finalStatMonth = StringUtils.hasText(statMonth) ? statMonth : latestStatMonth();
        int finalLimit = limit == null || limit <= 0 ? 10 : Math.min(limit, 50);
        LambdaQueryWrapper<MvRegionTopicRankMonthlyDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(MvRegionTopicRankMonthlyDO::getMetricCode, finalMetricCode)
                .eq(MvRegionTopicRankMonthlyDO::getStatMonth, finalStatMonth)
                .orderByAsc(MvRegionTopicRankMonthlyDO::getRankNo)
                .last("LIMIT " + finalLimit);
        List<MvRegionTopicRankMonthlyDO> records = mvRegionTopicRankMonthlyMapper.selectList(wrapper);
        if (records == null || records.isEmpty()) {
            return Collections.emptyList();
        }
        return records.stream().map(item -> MapStatRespVO.builder()
                .metricCode(item.getMetricCode())
                .topicCode(item.getTopicCode())
                .regionCode(item.getRegionCode())
                .regionName(item.getRegionName())
                .statMonth(item.getStatMonth())
                .rankNo(item.getRankNo())
                .metricValue(item.getMetricValue())
                .build()).collect(Collectors.toList());
    }

    private String latestStatMonth() {
        LambdaQueryWrapper<MvFinanceOverviewMonthlyDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.select(MvFinanceOverviewMonthlyDO::getStatMonth)
                .orderByDesc(MvFinanceOverviewMonthlyDO::getStatMonth)
                .last("LIMIT 1");
        MvFinanceOverviewMonthlyDO record = mvFinanceOverviewMonthlyMapper.selectOne(wrapper);
        return record == null ? "202603" : record.getStatMonth();
    }
}