package com.agriculture.nongjingmap.module.resource.service.impl;

import com.agriculture.nongjingmap.module.common.dal.dataobject.DimRegionDO;
import com.agriculture.nongjingmap.module.common.dal.mysql.DimRegionMapper;
import com.agriculture.nongjingmap.module.resource.controller.vo.*;
import com.agriculture.nongjingmap.module.resource.dal.dataobject.FactResourceItemDO;
import com.agriculture.nongjingmap.module.resource.dal.dataobject.FactResourceSummaryMonthlyDO;
import com.agriculture.nongjingmap.module.resource.dal.dataobject.ResourceFetchJobDO;
import com.agriculture.nongjingmap.module.resource.dal.mysql.FactResourceItemMapper;
import com.agriculture.nongjingmap.module.resource.dal.mysql.FactResourceSummaryMonthlyMapper;
import com.agriculture.nongjingmap.module.resource.dal.mysql.ResourceFetchJobMapper;
import com.agriculture.nongjingmap.module.resource.service.ResourceQueryService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class ResourceQueryServiceImpl implements ResourceQueryService {

    private final FactResourceItemMapper factResourceItemMapper;
    private final FactResourceSummaryMonthlyMapper factResourceSummaryMonthlyMapper;
    private final ResourceFetchJobMapper resourceFetchJobMapper;
    private final DimRegionMapper dimRegionMapper;

    public ResourceQueryServiceImpl(
            FactResourceItemMapper factResourceItemMapper,
            FactResourceSummaryMonthlyMapper factResourceSummaryMonthlyMapper,
            ResourceFetchJobMapper resourceFetchJobMapper,
            DimRegionMapper dimRegionMapper) {
        this.factResourceItemMapper = factResourceItemMapper;
        this.factResourceSummaryMonthlyMapper = factResourceSummaryMonthlyMapper;
        this.resourceFetchJobMapper = resourceFetchJobMapper;
        this.dimRegionMapper = dimRegionMapper;
    }

    @Override
    public ResourceSummaryRespVO getSummary(String regionCode, String yearMonth) {
        String finalRegionCode = defaultRegionCode(regionCode);
        String finalYearMonth = defaultYearMonth(yearMonth);
        Map<String, BigDecimal> areaMap = buildAreaMap(finalRegionCode, finalYearMonth);
        BigDecimal farmland = areaMap.getOrDefault("农用地", BigDecimal.ZERO);
        BigDecimal construction = areaMap.getOrDefault("建设用地", BigDecimal.ZERO);
        BigDecimal unused = areaMap.getOrDefault("未利用地", BigDecimal.ZERO);
        BigDecimal totalArea = areaMap.values().stream().filter(Objects::nonNull).reduce(BigDecimal.ZERO, BigDecimal::add);
        return ResourceSummaryRespVO.builder()
                .farmLandArea(farmland)
                .constructLandArea(construction)
                .unusedLandArea(unused)
                .totalArea(totalArea)
                .kpis(buildKpis(farmland, construction, unused, totalArea, finalRegionCode))
                .typeStats(listTypeDistribution(finalRegionCode, finalYearMonth))
                .districtStats(buildDistrictTable(listDistrictStats(finalRegionCode, finalYearMonth)))
                .dispatchTable(buildDispatchTable(listFetchJobs(finalRegionCode, null)))
                .layerTips(List.of("图层一：区划边界与资源面积热区。", "图层二：资源类型分布与地块标签。", "图层三：资源调取任务覆盖范围与状态。"))
                .build();
    }

    @Override
    public List<ResourceNamedValueRespVO> listTypeDistribution(String regionCode, String yearMonth) {
        List<FactResourceSummaryMonthlyDO> rows = listSummaryRows(defaultRegionCode(regionCode), defaultYearMonth(yearMonth));
        BigDecimal total = rows.stream().map(FactResourceSummaryMonthlyDO::getResourceTotalArea).filter(Objects::nonNull).reduce(BigDecimal.ZERO, BigDecimal::add);
        return rows.stream().map(item -> ResourceNamedValueRespVO.builder()
                .name(item.getResourceType())
                .value(item.getResourceTotalArea().setScale(0, RoundingMode.HALF_UP).intValue())
                .share(total.compareTo(BigDecimal.ZERO) == 0 ? BigDecimal.ZERO : item.getResourceTotalArea().multiply(new BigDecimal("100")).divide(total, 1, RoundingMode.HALF_UP))
                .build()).toList();
    }

    @Override
    public List<ResourceTrendRespVO> listTrend(String regionCode, String startMonth, String endMonth) {
        String finalRegionCode = defaultRegionCode(regionCode);
        String finalStartMonth = StringUtils.hasText(startMonth) ? normalizeMonth(startMonth) : defaultYearMonth(null);
        String finalEndMonth = StringUtils.hasText(endMonth) ? normalizeMonth(endMonth) : defaultYearMonth(null);
        LambdaQueryWrapper<FactResourceSummaryMonthlyDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(FactResourceSummaryMonthlyDO::getRegionCode, collectRegionCodes(finalRegionCode))
                .ge(FactResourceSummaryMonthlyDO::getPeriodMonth, finalStartMonth)
                .le(FactResourceSummaryMonthlyDO::getPeriodMonth, finalEndMonth)
                .orderByAsc(FactResourceSummaryMonthlyDO::getPeriodMonth);
        Map<String, List<FactResourceSummaryMonthlyDO>> grouped = factResourceSummaryMonthlyMapper.selectList(wrapper).stream()
                .collect(Collectors.groupingBy(FactResourceSummaryMonthlyDO::getPeriodMonth, LinkedHashMap::new, Collectors.toList()));
        return grouped.entrySet().stream().map(entry -> {
            Map<String, BigDecimal> monthArea = buildAreaMap(entry.getValue());
            return ResourceTrendRespVO.builder()
                    .yearMonth(entry.getKey())
                    .farmLandArea(monthArea.getOrDefault("农用地", BigDecimal.ZERO))
                    .constructLandArea(monthArea.getOrDefault("建设用地", BigDecimal.ZERO))
                    .unusedLandArea(monthArea.getOrDefault("未利用地", BigDecimal.ZERO))
                    .build();
        }).toList();
    }

    @Override
    public List<ResourceDistrictRespVO> listDistrictStats(String regionCode, String yearMonth) {
        String finalYearMonth = defaultYearMonth(yearMonth);
        Map<String, String> regionNameMap = buildRegionNameMap();
        LambdaQueryWrapper<FactResourceSummaryMonthlyDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FactResourceSummaryMonthlyDO::getPeriodMonth, finalYearMonth)
                .ne(FactResourceSummaryMonthlyDO::getRegionCode, "460000");
        Map<String, List<FactResourceSummaryMonthlyDO>> grouped = factResourceSummaryMonthlyMapper.selectList(wrapper).stream()
                .collect(Collectors.groupingBy(FactResourceSummaryMonthlyDO::getRegionCode, LinkedHashMap::new, Collectors.toList()));
        return grouped.entrySet().stream().map(entry -> {
            Map<String, BigDecimal> areaMap = buildAreaMap(entry.getValue());
            return ResourceDistrictRespVO.builder()
                    .regionCode(entry.getKey())
                    .regionName(regionNameMap.getOrDefault(entry.getKey(), entry.getKey()))
                    .farmland(areaMap.getOrDefault("农用地", BigDecimal.ZERO))
                    .construction(areaMap.getOrDefault("建设用地", BigDecimal.ZERO))
                    .unused(areaMap.getOrDefault("未利用地", BigDecimal.ZERO))
                    .build();
        }).toList();
    }

    @Override
    public List<ResourceListRespVO> listResources(String regionCode, String yearMonth, String resourceType) {
        Map<String, String> regionNameMap = buildRegionNameMap();
        return listResourceItems(defaultRegionCode(regionCode), defaultYearMonth(yearMonth), resourceType).stream().map(item -> ResourceListRespVO.builder()
                .resourceCode(item.getResourceCode())
                .resourceName(item.getResourceName())
                .resourceType(item.getResourceType())
                .locationDesc(regionNameMap.getOrDefault(item.getRegionCode(), item.getRegionCode()) + " / " + item.getLocationDesc())
                .area(item.getArea())
                .estimatedValue(item.getEstimatedValue())
                .usableStatus(item.getUsableStatus())
                .build()).toList();
    }

    @Override
    public List<ResourceFetchJobRespVO> listFetchJobs(String regionCode, String status) {
        LambdaQueryWrapper<ResourceFetchJobDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(StringUtils.hasText(regionCode), ResourceFetchJobDO::getScopeRegionCode, regionCode)
                .eq(StringUtils.hasText(status), ResourceFetchJobDO::getStatus, status)
                .orderByDesc(ResourceFetchJobDO::getLastRunTime);
        Map<String, String> regionNameMap = buildRegionNameMap();
        return resourceFetchJobMapper.selectList(wrapper).stream().map(item -> ResourceFetchJobRespVO.builder()
                .taskName(item.getTaskName())
                .source(item.getSourceSystem())
                .scope(regionNameMap.getOrDefault(item.getScopeRegionCode(), item.getScopeDesc()))
                .status(item.getStatus())
                .lastRunTime(item.getLastRunTime())
                .build()).toList();
    }
    private List<FactResourceSummaryMonthlyDO> listSummaryRows(String regionCode, String yearMonth) {
        LambdaQueryWrapper<FactResourceSummaryMonthlyDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(FactResourceSummaryMonthlyDO::getRegionCode, collectRegionCodes(regionCode))
                .eq(FactResourceSummaryMonthlyDO::getPeriodMonth, yearMonth);
        return factResourceSummaryMonthlyMapper.selectList(wrapper);
    }

    private List<FactResourceItemDO> listResourceItems(String regionCode, String yearMonth, String resourceType) {
        LambdaQueryWrapper<FactResourceItemDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(FactResourceItemDO::getRegionCode, collectRegionCodes(regionCode))
                .eq(FactResourceItemDO::getPeriodMonth, yearMonth)
                .eq(StringUtils.hasText(resourceType), FactResourceItemDO::getResourceType, resourceType)
                .orderByDesc(FactResourceItemDO::getArea);
        return factResourceItemMapper.selectList(wrapper);
    }

    private Map<String, BigDecimal> buildAreaMap(String regionCode, String yearMonth) {
        return buildAreaMap(listSummaryRows(regionCode, yearMonth));
    }

    private Map<String, BigDecimal> buildAreaMap(List<FactResourceSummaryMonthlyDO> rows) {
        return rows.stream().collect(Collectors.toMap(FactResourceSummaryMonthlyDO::getResourceType, FactResourceSummaryMonthlyDO::getResourceTotalArea, BigDecimal::add, LinkedHashMap::new));
    }

    private List<ResourceMetricCardRespVO> buildKpis(BigDecimal farmland, BigDecimal construction, BigDecimal unused, BigDecimal totalArea, String regionCode) {
        int jobCount = listFetchJobs(regionCode, null).size();
        return List.of(
                metricCard("资源总面积", totalArea.setScale(0, RoundingMode.HALF_UP).toPlainString() + "亩", "含农用地、建设用地、未利用地", "positive"),
                metricCard("农用地面积", farmland.setScale(0, RoundingMode.HALF_UP).toPlainString() + "亩", "耕地、林地、园地", "positive"),
                metricCard("建设用地面积", construction.setScale(0, RoundingMode.HALF_UP).toPlainString() + "亩", "厂房、仓储、公共设施", "neutral"),
                metricCard("资源调取任务", String.valueOf(jobCount), "资源信息接口调取批次", "warning"));
    }

    private ResourceTableDataRespVO buildDistrictTable(List<ResourceDistrictRespVO> rows) {
        return ResourceTableDataRespVO.builder()
                .columns(List.of(column("regionName", "区划"), column("farmland", "农用地"), column("construction", "建设用地"), column("unused", "未利用地")))
                .rows(rows.stream().map(item -> rowOf(
                        "regionName", item.getRegionName(),
                        "farmland", item.getFarmland().setScale(0, RoundingMode.HALF_UP).toPlainString() + "亩",
                        "construction", item.getConstruction().setScale(0, RoundingMode.HALF_UP).toPlainString() + "亩",
                        "unused", item.getUnused().setScale(0, RoundingMode.HALF_UP).toPlainString() + "亩")).toList())
                .build();
    }

    private ResourceTableDataRespVO buildDispatchTable(List<ResourceFetchJobRespVO> rows) {
        return ResourceTableDataRespVO.builder()
                .columns(List.of(column("taskName", "调取任务"), column("source", "数据源"), column("scope", "覆盖范围"), column("status", "状态")))
                .rows(rows.stream().map(item -> rowOf("taskName", item.getTaskName(), "source", item.getSource(), "scope", item.getScope(), "status", item.getStatus())).toList())
                .build();
    }

    private Map<String, String> buildRegionNameMap() {
        LambdaQueryWrapper<DimRegionDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.select(DimRegionDO::getRegionCode, DimRegionDO::getRegionName);
        return dimRegionMapper.selectList(wrapper).stream().collect(Collectors.toMap(DimRegionDO::getRegionCode, DimRegionDO::getRegionName, (a, b) -> a));
    }

    private Set<String> collectRegionCodes(String regionCode) {
        LambdaQueryWrapper<DimRegionDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(DimRegionDO::getRegionCode, regionCode).or().eq(DimRegionDO::getParentCode, regionCode);
        Set<String> codes = dimRegionMapper.selectList(wrapper).stream().map(DimRegionDO::getRegionCode).collect(Collectors.toSet());
        codes.add(regionCode);
        return codes;
    }

    private String defaultRegionCode(String regionCode) {
        return StringUtils.hasText(regionCode) ? regionCode : "460000";
    }

    private String defaultYearMonth(String yearMonth) {
        if (StringUtils.hasText(yearMonth)) {
            return yearMonth.replace("-", "");
        }
        LambdaQueryWrapper<FactResourceSummaryMonthlyDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.select(FactResourceSummaryMonthlyDO::getPeriodMonth)
                .orderByDesc(FactResourceSummaryMonthlyDO::getPeriodMonth)
                .last("LIMIT 1");
        FactResourceSummaryMonthlyDO record = factResourceSummaryMonthlyMapper.selectOne(wrapper);
        return record == null ? "202603" : record.getPeriodMonth();
    }

    private String normalizeMonth(String month) {
        return month.replace("-", "");
    }

    private ResourceMetricCardRespVO metricCard(String label, String value, String hint, String status) {
        return ResourceMetricCardRespVO.builder().label(label).value(value).hint(hint).status(status).build();
    }

    private ResourceTableColumnRespVO column(String key, String label) {
        return ResourceTableColumnRespVO.builder().key(key).label(label).build();
    }

    private Map<String, Object> rowOf(Object... pairs) {
        Map<String, Object> row = new LinkedHashMap<>();
        for (int i = 0; i < pairs.length; i += 2) {
            row.put(String.valueOf(pairs[i]), pairs[i + 1]);
        }
        return row;
    }
}