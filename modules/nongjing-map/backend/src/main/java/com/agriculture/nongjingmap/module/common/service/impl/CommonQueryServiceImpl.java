package com.agriculture.nongjingmap.module.common.service.impl;

import com.agriculture.nongjingmap.module.common.controller.vo.DictItemRespVO;
import com.agriculture.nongjingmap.module.common.controller.vo.MetricRespVO;
import com.agriculture.nongjingmap.module.common.controller.vo.RegionRespVO;
import com.agriculture.nongjingmap.module.common.controller.vo.TimeDimensionRespVO;
import com.agriculture.nongjingmap.module.common.dal.dataobject.DimDictItemDO;
import com.agriculture.nongjingmap.module.common.dal.dataobject.DimMetricDO;
import com.agriculture.nongjingmap.module.common.dal.dataobject.DimRegionDO;
import com.agriculture.nongjingmap.module.common.dal.dataobject.DimTimeDO;
import com.agriculture.nongjingmap.module.common.dal.mysql.DimDictItemMapper;
import com.agriculture.nongjingmap.module.common.dal.mysql.DimMetricMapper;
import com.agriculture.nongjingmap.module.common.dal.mysql.DimRegionMapper;
import com.agriculture.nongjingmap.module.common.dal.mysql.DimTimeMapper;
import com.agriculture.nongjingmap.module.common.service.CommonQueryService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class CommonQueryServiceImpl implements CommonQueryService {

    private final DimRegionMapper dimRegionMapper;
    private final DimTimeMapper dimTimeMapper;
    private final DimMetricMapper dimMetricMapper;
    private final DimDictItemMapper dimDictItemMapper;

    public CommonQueryServiceImpl(
            DimRegionMapper dimRegionMapper,
            DimTimeMapper dimTimeMapper,
            DimMetricMapper dimMetricMapper,
            DimDictItemMapper dimDictItemMapper) {
        this.dimRegionMapper = dimRegionMapper;
        this.dimTimeMapper = dimTimeMapper;
        this.dimMetricMapper = dimMetricMapper;
        this.dimDictItemMapper = dimDictItemMapper;
    }

    @Override
    public List<RegionRespVO> listRegions(String parentCode, String regionLevel) {
        LambdaQueryWrapper<DimRegionDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(StringUtils.hasText(parentCode), DimRegionDO::getParentCode, parentCode)
                .eq(StringUtils.hasText(regionLevel), DimRegionDO::getRegionLevel, regionLevel)
                .orderByAsc(DimRegionDO::getSortNo)
                .orderByAsc(DimRegionDO::getRegionCode);
        return dimRegionMapper.selectList(wrapper).stream().map(this::buildRegionResp).collect(Collectors.toList());
    }

    @Override
    public RegionRespVO getRegionDetail(String regionCode) {
        LambdaQueryWrapper<DimRegionDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(DimRegionDO::getRegionCode, regionCode).last("LIMIT 1");
        DimRegionDO record = dimRegionMapper.selectOne(wrapper);
        return record == null ? null : buildRegionResp(record);
    }

    @Override
    public List<TimeDimensionRespVO> listTimeDimensions(Integer yearNo) {
        LambdaQueryWrapper<DimTimeDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(yearNo != null, DimTimeDO::getYearNo, yearNo)
                .orderByDesc(DimTimeDO::getDateValue);
        return dimTimeMapper.selectList(wrapper).stream().map(item -> TimeDimensionRespVO.builder()
                .timeCode(item.getTimeCode())
                .dateValue(item.getDateValue())
                .yearNo(item.getYearNo())
                .quarterNo(item.getQuarterNo())
                .monthNo(item.getMonthNo())
                .monthLabel(item.getMonthLabel())
                .build()).collect(Collectors.toList());
    }

    @Override
    public List<MetricRespVO> listMetrics(String metricCategory) {
        LambdaQueryWrapper<DimMetricDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(StringUtils.hasText(metricCategory), DimMetricDO::getMetricCategory, metricCategory)
                .orderByAsc(DimMetricDO::getMetricCategory)
                .orderByAsc(DimMetricDO::getMetricCode);
        return dimMetricMapper.selectList(wrapper).stream().map(item -> MetricRespVO.builder()
                .metricCode(item.getMetricCode())
                .metricName(item.getMetricName())
                .metricCategory(item.getMetricCategory())
                .unitName(item.getUnitName())
                .remark(item.getRemark())
                .build()).collect(Collectors.toList());
    }

    @Override
    public List<DictItemRespVO> listDictItems(String dictType) {
        LambdaQueryWrapper<DimDictItemDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(StringUtils.hasText(dictType), DimDictItemDO::getDictType, dictType)
                .orderByAsc(DimDictItemDO::getDictType)
                .orderByAsc(DimDictItemDO::getSortNo);
        return dimDictItemMapper.selectList(wrapper).stream().map(item -> DictItemRespVO.builder()
                .dictType(item.getDictType())
                .itemCode(item.getItemCode())
                .itemName(item.getItemName())
                .sortNo(item.getSortNo())
                .remark(item.getRemark())
                .build()).collect(Collectors.toList());
    }

    private RegionRespVO buildRegionResp(DimRegionDO item) {
        return RegionRespVO.builder()
                .regionCode(item.getRegionCode())
                .regionName(item.getRegionName())
                .parentCode(item.getParentCode())
                .regionLevel(item.getRegionLevel())
                .sortNo(item.getSortNo())
                .centroidWkt(item.getCentroidWkt())
                .build();
    }
}