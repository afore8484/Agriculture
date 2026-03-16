package com.agriculture.nongjingmap.module.asset.service;

import com.agriculture.nongjingmap.module.asset.controller.vo.*;
import java.util.List;

public interface AssetQueryService {

    AssetSummaryRespVO getAssetSummary(String regionCode, String yearMonth);

    List<AssetNamedValueRespVO> listTypeDistribution(String regionCode, String yearMonth);

    List<AssetTrendRespVO> listTrend(String regionCode, String startMonth, String endMonth);

    List<AssetRankRespVO> listRank(String regionCode, String yearMonth, Integer topN);

    List<AssetRankRespVO> listMapStats(String regionCode, String yearMonth);

    List<AssetListRespVO> listAssets(String regionCode, String yearMonth, String assetType);
}