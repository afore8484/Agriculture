package com.agriculture.nongjingmap.module.common.controller;

import com.agriculture.nongjingmap.common.pojo.CommonResult;
import com.agriculture.nongjingmap.module.common.controller.vo.DictItemRespVO;
import com.agriculture.nongjingmap.module.common.controller.vo.MetricRespVO;
import com.agriculture.nongjingmap.module.common.controller.vo.RegionRespVO;
import com.agriculture.nongjingmap.module.common.controller.vo.TimeDimensionRespVO;
import com.agriculture.nongjingmap.module.common.service.CommonQueryService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Tag(name = "农经一张图-公共接口")
@RestController
@RequestMapping("/api/nongjing/common")
public class CommonController {

    private final CommonQueryService commonQueryService;

    public CommonController(CommonQueryService commonQueryService) {
        this.commonQueryService = commonQueryService;
    }

    @Operation(summary = "查询区划列表")
    @GetMapping("/regions")
    public CommonResult<List<RegionRespVO>> listRegions(
            @RequestParam(required = false) String parentCode,
            @RequestParam(required = false) String regionLevel) {
        return CommonResult.success(commonQueryService.listRegions(parentCode, regionLevel));
    }

    @Operation(summary = "查询区划详情")
    @GetMapping("/region-detail")
    public CommonResult<RegionRespVO> getRegionDetail(@RequestParam String regionCode) {
        return CommonResult.success(commonQueryService.getRegionDetail(regionCode));
    }

    @Operation(summary = "查询时间维度")
    @GetMapping("/time-dimensions")
    public CommonResult<List<TimeDimensionRespVO>> listTimeDimensions(@RequestParam(required = false) Integer yearNo) {
        return CommonResult.success(commonQueryService.listTimeDimensions(yearNo));
    }

    @Operation(summary = "查询指标字典")
    @GetMapping("/metrics")
    public CommonResult<List<MetricRespVO>> listMetrics(@RequestParam(required = false) String metricCategory) {
        return CommonResult.success(commonQueryService.listMetrics(metricCategory));
    }

    @Operation(summary = "查询通用字典项")
    @GetMapping("/dict-items")
    public CommonResult<List<DictItemRespVO>> listDictItems(@RequestParam(required = false) String dictType) {
        return CommonResult.success(commonQueryService.listDictItems(dictType));
    }
}