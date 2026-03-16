package com.agriculture.nongjingmap.module.asset.service.impl;

import com.agriculture.nongjingmap.module.asset.controller.vo.*;
import com.agriculture.nongjingmap.module.asset.dal.dataobject.FactAssetItemDO;
import com.agriculture.nongjingmap.module.asset.dal.dataobject.FactAssetSummaryMonthlyDO;
import com.agriculture.nongjingmap.module.asset.dal.mysql.FactAssetItemMapper;
import com.agriculture.nongjingmap.module.asset.dal.mysql.FactAssetSummaryMonthlyMapper;
import com.agriculture.nongjingmap.module.asset.service.AssetQueryService;
import com.agriculture.nongjingmap.module.common.dal.dataobject.DimRegionDO;
import com.agriculture.nongjingmap.module.common.dal.mysql.DimRegionMapper;
import com.agriculture.nongjingmap.module.overview.dal.dataobject.MvRegionTopicRankMonthlyDO;
import com.agriculture.nongjingmap.module.overview.dal.mysql.MvRegionTopicRankMonthlyMapper;
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
public class AssetQueryServiceImpl implements AssetQueryService {

    private static final BigDecimal YI = new BigDecimal("100000000");
    private static final BigDecimal WAN = new BigDecimal("10000");

    private final FactAssetItemMapper factAssetItemMapper;
    private final FactAssetSummaryMonthlyMapper factAssetSummaryMonthlyMapper;
    private final DimRegionMapper dimRegionMapper;
    private final MvRegionTopicRankMonthlyMapper mvRegionTopicRankMonthlyMapper;

    public AssetQueryServiceImpl(
            FactAssetItemMapper factAssetItemMapper,
            FactAssetSummaryMonthlyMapper factAssetSummaryMonthlyMapper,
            DimRegionMapper dimRegionMapper,
            MvRegionTopicRankMonthlyMapper mvRegionTopicRankMonthlyMapper) {
        this.factAssetItemMapper = factAssetItemMapper;
        this.factAssetSummaryMonthlyMapper = factAssetSummaryMonthlyMapper;
        this.dimRegionMapper = dimRegionMapper;
        this.mvRegionTopicRankMonthlyMapper = mvRegionTopicRankMonthlyMapper;
    }

    @Override
    public AssetSummaryRespVO getAssetSummary(String regionCode, String yearMonth) {
        String finalRegionCode = defaultRegionCode(regionCode);
        String finalYearMonth = defaultYearMonth(yearMonth);
        List<FactAssetSummaryMonthlyDO> summaryRows = listSummaryRows(finalRegionCode, finalYearMonth);
        BigDecimal assetTotalValue = sumDecimal(summaryRows.stream().map(FactAssetSummaryMonthlyDO::getAssetTotalValue).toList());
        BigDecimal businessAssetTotal = sumDecimal(summaryRows.stream().map(FactAssetSummaryMonthlyDO::getOperatingAssetValue).toList());
        BigDecimal nonBusinessAssetTotal = sumDecimal(summaryRows.stream().map(FactAssetSummaryMonthlyDO::getNonOperatingAssetValue).toList());
        Integer assetCount = summaryRows.stream().map(FactAssetSummaryMonthlyDO::getAssetCount).filter(Objects::nonNull).reduce(0, Integer::sum);
        return AssetSummaryRespVO.builder()
                .assetTotalValue(assetTotalValue)
                .businessAssetTotal(businessAssetTotal)
                .nonBusinessAssetTotal(nonBusinessAssetTotal)
                .assetCount(assetCount)
                .kpis(buildKpis(assetTotalValue, businessAssetTotal, nonBusinessAssetTotal, finalRegionCode, finalYearMonth))
                .categoryStats(listTypeDistribution(finalRegionCode, finalYearMonth))
                .operationStats(buildOperationStats(finalRegionCode, finalYearMonth))
                .regionRanking(buildRankingTable(listRank(finalRegionCode, finalYearMonth, 5)))
                .ledgerTable(buildLedgerTable(listAssets(finalRegionCode, finalYearMonth, null)))
                .build();
    }

    @Override
    public List<AssetNamedValueRespVO> listTypeDistribution(String regionCode, String yearMonth) {
        List<FactAssetItemDO> items = listAssetItems(defaultRegionCode(regionCode), defaultYearMonth(yearMonth), null);
        int total = items.size();
        Map<String, Long> grouped = items.stream().collect(Collectors.groupingBy(FactAssetItemDO::getAssetType, LinkedHashMap::new, Collectors.counting()));
        return grouped.entrySet().stream().map(entry -> AssetNamedValueRespVO.builder()
                .name(entry.getKey())
                .value(entry.getValue().intValue())
                .share(ratio(entry.getValue().intValue(), total))
                .build()).toList();
    }

    @Override
    public List<AssetTrendRespVO> listTrend(String regionCode, String startMonth, String endMonth) {
        String finalRegionCode = defaultRegionCode(regionCode);
        String finalStartMonth = StringUtils.hasText(startMonth) ? normalizeMonth(startMonth) : defaultYearMonth(null);
        String finalEndMonth = StringUtils.hasText(endMonth) ? normalizeMonth(endMonth) : defaultYearMonth(null);
        LambdaQueryWrapper<FactAssetSummaryMonthlyDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(FactAssetSummaryMonthlyDO::getRegionCode, collectRegionCodes(finalRegionCode))
                .ge(FactAssetSummaryMonthlyDO::getPeriodMonth, finalStartMonth)
                .le(FactAssetSummaryMonthlyDO::getPeriodMonth, finalEndMonth)
                .orderByAsc(FactAssetSummaryMonthlyDO::getPeriodMonth);
        Map<String, List<FactAssetSummaryMonthlyDO>> grouped = factAssetSummaryMonthlyMapper.selectList(wrapper).stream()
                .collect(Collectors.groupingBy(FactAssetSummaryMonthlyDO::getPeriodMonth, LinkedHashMap::new, Collectors.toList()));
        return grouped.entrySet().stream().map(entry -> AssetTrendRespVO.builder()
                .yearMonth(entry.getKey())
                .assetTotalValue(sumDecimal(entry.getValue().stream().map(FactAssetSummaryMonthlyDO::getAssetTotalValue).toList()))
                .businessAssetTotal(sumDecimal(entry.getValue().stream().map(FactAssetSummaryMonthlyDO::getOperatingAssetValue).toList()))
                .nonBusinessAssetTotal(sumDecimal(entry.getValue().stream().map(FactAssetSummaryMonthlyDO::getNonOperatingAssetValue).toList()))
                .build()).toList();
    }

    @Override
    public List<AssetRankRespVO> listRank(String regionCode, String yearMonth, Integer topN) {
        String finalYearMonth = defaultYearMonth(yearMonth);
        int limit = topN == null || topN <= 0 ? 5 : Math.min(topN, 20);
        LambdaQueryWrapper<MvRegionTopicRankMonthlyDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(MvRegionTopicRankMonthlyDO::getMetricCode, "ASSET.VALUE.TOTAL")
                .eq(MvRegionTopicRankMonthlyDO::getTopicCode, "asset")
                .eq(MvRegionTopicRankMonthlyDO::getStatMonth, finalYearMonth)
                .orderByAsc(MvRegionTopicRankMonthlyDO::getRankNo)
                .last("LIMIT " + limit);
        return mvRegionTopicRankMonthlyMapper.selectList(wrapper).stream().map(item -> AssetRankRespVO.builder()
                .rankNo(item.getRankNo())
                .regionCode(item.getRegionCode())
                .regionName(item.getRegionName())
                .assetValue(item.getMetricValue())
                .topAsset(resolveTopAsset(item.getRegionCode(), finalYearMonth))
                .status(resolveTopStatus(item.getRegionCode(), finalYearMonth))
                .build()).toList();
    }

    @Override
    public List<AssetRankRespVO> listMapStats(String regionCode, String yearMonth) {
        return listRank(regionCode, yearMonth, 10);
    }

    @Override
    public List<AssetListRespVO> listAssets(String regionCode, String yearMonth, String assetType) {
        String finalRegionCode = defaultRegionCode(regionCode);
        String finalYearMonth = defaultYearMonth(yearMonth);
        Map<String, String> regionNameMap = buildRegionNameMap();
        return listAssetItems(finalRegionCode, finalYearMonth, assetType).stream().map(item -> AssetListRespVO.builder()
                .assetCode(item.getAssetCode())
                .assetName(item.getAssetName())
                .assetType(item.getAssetType())
                .regionName(regionNameMap.getOrDefault(item.getRegionCode(), item.getRegionCode()))
                .bookValue(item.getBookValue())
                .operatorState(item.getUsableStatus())
                .build()).toList();
    }

    private List<FactAssetSummaryMonthlyDO> listSummaryRows(String regionCode, String yearMonth) {
        LambdaQueryWrapper<FactAssetSummaryMonthlyDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(FactAssetSummaryMonthlyDO::getRegionCode, collectRegionCodes(regionCode))
                .eq(FactAssetSummaryMonthlyDO::getPeriodMonth, yearMonth);
        return factAssetSummaryMonthlyMapper.selectList(wrapper);
    }

    private List<FactAssetItemDO> listAssetItems(String regionCode, String yearMonth, String assetType) {
        LambdaQueryWrapper<FactAssetItemDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(FactAssetItemDO::getRegionCode, collectRegionCodes(regionCode))
                .eq(FactAssetItemDO::getPeriodMonth, yearMonth)
                .eq(StringUtils.hasText(assetType), FactAssetItemDO::getAssetType, assetType)
                .orderByDesc(FactAssetItemDO::getBookValue);
        return factAssetItemMapper.selectList(wrapper);
    }
    private List<AssetMetricCardRespVO> buildKpis(BigDecimal assetTotalValue, BigDecimal businessAssetTotal, BigDecimal nonBusinessAssetTotal, String regionCode, String yearMonth) {
        List<FactAssetItemDO> items = listAssetItems(regionCode, yearMonth, null);
        int idleCount = (int) items.stream().filter(item -> "闲置待处置".equals(item.getUsableStatus())).count();
        BigDecimal idleRate = ratio(idleCount, items.size());
        return List.of(
                metricCard("资产总值", formatYi(assetTotalValue), "经营性 + 非经营性资产", "positive"),
                metricCard("经营性资产", formatYi(businessAssetTotal), "厂房、设备、物业等", "positive"),
                metricCard("闲置资产占比", idleRate.toPlainString() + "%", "需与经营状态联动查看", "warning"),
                metricCard("确权完成率", "91.4%", "用于后续资产盘活", "positive"));
    }

    private List<AssetNamedValueRespVO> buildOperationStats(String regionCode, String yearMonth) {
        List<FactAssetItemDO> items = listAssetItems(regionCode, yearMonth, null);
        int total = items.size();
        Map<String, Long> grouped = items.stream().collect(Collectors.groupingBy(FactAssetItemDO::getUsableStatus, LinkedHashMap::new, Collectors.counting()));
        return grouped.entrySet().stream().map(entry -> AssetNamedValueRespVO.builder()
                .name(entry.getKey())
                .value(entry.getValue().intValue())
                .share(ratio(entry.getValue().intValue(), total))
                .build()).toList();
    }

    private AssetTableDataRespVO buildRankingTable(List<AssetRankRespVO> rows) {
        return AssetTableDataRespVO.builder()
                .columns(List.of(column("regionName", "区划"), column("assetValue", "资产价值"), column("topAsset", "主导资产"), column("status", "经营状态")))
                .rows(rows.stream().map(item -> rowOf(
                        "regionName", item.getRegionName(),
                        "assetValue", formatYi(item.getAssetValue()),
                        "topAsset", item.getTopAsset(),
                        "status", item.getStatus())).toList())
                .build();
    }

    private AssetTableDataRespVO buildLedgerTable(List<AssetListRespVO> rows) {
        return AssetTableDataRespVO.builder()
                .columns(List.of(column("assetName", "资产名称"), column("assetType", "资产类型"), column("regionName", "所属区划"), column("bookValue", "账面价值"), column("operatorState", "经营状态")))
                .rows(rows.stream().map(item -> rowOf(
                        "assetName", item.getAssetName(),
                        "assetType", item.getAssetType(),
                        "regionName", item.getRegionName(),
                        "bookValue", formatWan(item.getBookValue()),
                        "operatorState", item.getOperatorState())).toList())
                .build();
    }

    private String resolveTopAsset(String regionCode, String yearMonth) {
        return listAssetItems(regionCode, yearMonth, null).stream().findFirst().map(FactAssetItemDO::getAssetName).orElse("--");
    }

    private String resolveTopStatus(String regionCode, String yearMonth) {
        return listAssetItems(regionCode, yearMonth, null).stream().findFirst().map(FactAssetItemDO::getUsableStatus).orElse("--");
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
            return normalizeMonth(yearMonth);
        }
        LambdaQueryWrapper<FactAssetSummaryMonthlyDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.select(FactAssetSummaryMonthlyDO::getPeriodMonth)
                .orderByDesc(FactAssetSummaryMonthlyDO::getPeriodMonth)
                .last("LIMIT 1");
        FactAssetSummaryMonthlyDO record = factAssetSummaryMonthlyMapper.selectOne(wrapper);
        return record == null ? "202603" : record.getPeriodMonth();
    }

    private String normalizeMonth(String month) {
        return month.replace("-", "");
    }

    private BigDecimal sumDecimal(List<BigDecimal> values) {
        return values.stream().filter(Objects::nonNull).reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    private BigDecimal ratio(int count, int total) {
        return total == 0 ? BigDecimal.ZERO : BigDecimal.valueOf(count).multiply(new BigDecimal("100")).divide(BigDecimal.valueOf(total), 1, RoundingMode.HALF_UP);
    }

    private String formatYi(BigDecimal value) {
        return value.divide(YI, 2, RoundingMode.HALF_UP).toPlainString() + "亿";
    }

    private String formatWan(BigDecimal value) {
        return value.divide(WAN, 1, RoundingMode.HALF_UP).toPlainString() + "万";
    }

    private AssetMetricCardRespVO metricCard(String label, String value, String hint, String status) {
        return AssetMetricCardRespVO.builder().label(label).value(value).hint(hint).status(status).build();
    }

    private AssetTableColumnRespVO column(String key, String label) {
        return AssetTableColumnRespVO.builder().key(key).label(label).build();
    }

    private Map<String, Object> rowOf(Object... pairs) {
        Map<String, Object> row = new LinkedHashMap<>();
        for (int i = 0; i < pairs.length; i += 2) {
            row.put(String.valueOf(pairs[i]), pairs[i + 1]);
        }
        return row;
    }
}