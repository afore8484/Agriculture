package com.agriculture.nongjingmap.module.resource.controller;

import com.agriculture.nongjingmap.common.pojo.CommonResult;
import com.agriculture.nongjingmap.module.resource.controller.vo.*;
import com.agriculture.nongjingmap.module.resource.service.ResourceQueryService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Tag(name = "农经一张图-资源接口")
@RestController
@RequestMapping("/api/nongjing/resources")
public class ResourceController {

    private final ResourceQueryService resourceQueryService;

    public ResourceController(ResourceQueryService resourceQueryService) {
        this.resourceQueryService = resourceQueryService;
    }

    @Operation(summary = "获取资源一张图统计")
    @GetMapping("/summary")
    public CommonResult<ResourceSummaryRespVO> getSummary(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth) {
        return CommonResult.success(resourceQueryService.getSummary(regionCode, yearMonth));
    }

    @Operation(summary = "获取资源类型分布")
    @GetMapping("/type-distribution")
    public CommonResult<List<ResourceNamedValueRespVO>> listTypeDistribution(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth) {
        return CommonResult.success(resourceQueryService.listTypeDistribution(regionCode, yearMonth));
    }

    @Operation(summary = "获取资源趋势")
    @GetMapping("/trend")
    public CommonResult<List<ResourceTrendRespVO>> listTrend(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String startMonth,
            @RequestParam(required = false) String endMonth) {
        return CommonResult.success(resourceQueryService.listTrend(regionCode, startMonth, endMonth));
    }

    @Operation(summary = "获取资源地图统计")
    @GetMapping("/map-stats")
    public CommonResult<List<ResourceDistrictRespVO>> listMapStats(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth) {
        return CommonResult.success(resourceQueryService.listDistrictStats(regionCode, yearMonth));
    }

    @Operation(summary = "获取资源列表")
    @GetMapping("/list")
    public CommonResult<List<ResourceListRespVO>> listResources(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth,
            @RequestParam(required = false) String resourceType) {
        return CommonResult.success(resourceQueryService.listResources(regionCode, yearMonth, resourceType));
    }

    @Operation(summary = "获取资源区域统计-前端兼容")
    @GetMapping("/district-stats")
    public CommonResult<List<ResourceDistrictRespVO>> listDistrictStats(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth) {
        return CommonResult.success(resourceQueryService.listDistrictStats(regionCode, yearMonth));
    }

    @Operation(summary = "获取资源信息调取任务-前端兼容")
    @GetMapping("/fetch-jobs")
    public CommonResult<List<ResourceFetchJobRespVO>> listFetchJobs(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String status) {
        return CommonResult.success(resourceQueryService.listFetchJobs(regionCode, status));
    }

    @Operation(summary = "获取资源图层统计-前端兼容")
    @GetMapping("/layer-stats")
    public CommonResult<List<ResourceDistrictRespVO>> listLayerStats(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth) {
        return CommonResult.success(resourceQueryService.listDistrictStats(regionCode, yearMonth));
    }
}