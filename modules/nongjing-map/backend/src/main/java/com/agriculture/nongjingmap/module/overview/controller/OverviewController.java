package com.agriculture.nongjingmap.module.overview.controller;

import com.agriculture.nongjingmap.common.pojo.CommonResult;
import com.agriculture.nongjingmap.module.overview.controller.vo.MapStatRespVO;
import com.agriculture.nongjingmap.module.overview.controller.vo.OverviewCardsRespVO;
import com.agriculture.nongjingmap.module.overview.controller.vo.WeatherRespVO;
import com.agriculture.nongjingmap.module.overview.service.OverviewQueryService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Tag(name = "农经一张图-总览接口")
@RestController
@RequestMapping("/api/nongjing/overview")
public class OverviewController {

    private final OverviewQueryService overviewQueryService;

    public OverviewController(OverviewQueryService overviewQueryService) {
        this.overviewQueryService = overviewQueryService;
    }

    @Operation(summary = "查询总览天气")
    @GetMapping("/weather")
    public CommonResult<WeatherRespVO> getWeather(@RequestParam(required = false) String regionCode) {
        return CommonResult.success(overviewQueryService.getWeather(regionCode));
    }

    @Operation(summary = "查询总览卡片")
    @GetMapping("/cards")
    public CommonResult<OverviewCardsRespVO> getOverviewCards(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String statMonth) {
        return CommonResult.success(overviewQueryService.getOverviewCards(regionCode, statMonth));
    }

    @Operation(summary = "查询总览地图统计")
    @GetMapping("/map-stats")
    public CommonResult<List<MapStatRespVO>> listMapStats(
            @RequestParam(required = false) String metricCode,
            @RequestParam(required = false) String statMonth,
            @RequestParam(required = false) Integer limit) {
        return CommonResult.success(overviewQueryService.listMapStats(metricCode, statMonth, limit));
    }
}