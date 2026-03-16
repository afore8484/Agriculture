package com.agriculture.nongjingmap.module.asset.controller;

import com.agriculture.nongjingmap.common.pojo.CommonResult;
import com.agriculture.nongjingmap.module.asset.controller.vo.*;
import com.agriculture.nongjingmap.module.asset.service.AssetQueryService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Tag(name = "农经一张图-资产接口")
@RestController
@RequestMapping("/api/nongjing/assets")
public class AssetController {

    private final AssetQueryService assetQueryService;

    public AssetController(AssetQueryService assetQueryService) {
        this.assetQueryService = assetQueryService;
    }

    @Operation(summary = "获取资产一张图统计")
    @GetMapping("/summary")
    public CommonResult<AssetSummaryRespVO> getAssetSummary(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth) {
        return CommonResult.success(assetQueryService.getAssetSummary(regionCode, yearMonth));
    }

    @Operation(summary = "获取资产分类分布")
    @GetMapping("/type-distribution")
    public CommonResult<List<AssetNamedValueRespVO>> listTypeDistribution(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth) {
        return CommonResult.success(assetQueryService.listTypeDistribution(regionCode, yearMonth));
    }

    @Operation(summary = "获取资产趋势")
    @GetMapping("/trend")
    public CommonResult<List<AssetTrendRespVO>> listTrend(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String startMonth,
            @RequestParam(required = false) String endMonth) {
        return CommonResult.success(assetQueryService.listTrend(regionCode, startMonth, endMonth));
    }

    @Operation(summary = "获取资产排行")
    @GetMapping("/rank")
    public CommonResult<List<AssetRankRespVO>> listRank(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth,
            @RequestParam(required = false) Integer topN) {
        return CommonResult.success(assetQueryService.listRank(regionCode, yearMonth, topN));
    }

    @Operation(summary = "获取资产地图统计")
    @GetMapping("/map-stats")
    public CommonResult<List<AssetRankRespVO>> listMapStats(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth) {
        return CommonResult.success(assetQueryService.listMapStats(regionCode, yearMonth));
    }

    @Operation(summary = "获取资产台账")
    @GetMapping("/list")
    public CommonResult<List<AssetListRespVO>> listAssets(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth,
            @RequestParam(required = false) String assetType) {
        return CommonResult.success(assetQueryService.listAssets(regionCode, yearMonth, assetType));
    }

    @Operation(summary = "获取区域资产价值排名-前端兼容")
    @GetMapping("/district-ranking")
    public CommonResult<List<AssetRankRespVO>> listDistrictRanking(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth,
            @RequestParam(required = false) Integer topN) {
        return CommonResult.success(assetQueryService.listRank(regionCode, yearMonth, topN));
    }

    @Operation(summary = "获取资产台账明细-前端兼容")
    @GetMapping("/ledger")
    public CommonResult<List<AssetListRespVO>> listLedger(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth,
            @RequestParam(required = false) String assetType) {
        return CommonResult.success(assetQueryService.listAssets(regionCode, yearMonth, assetType));
    }
}