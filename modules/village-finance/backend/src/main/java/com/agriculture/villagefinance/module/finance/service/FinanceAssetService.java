package com.agriculture.villagefinance.module.finance.service;

import com.agriculture.villagefinance.module.finance.controller.vo.AssetCardCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetCardPageRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetCardRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetCardUpdateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetCategoryCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetCategoryRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetCategoryUpdateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetDepreciationCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetDepreciationRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetDisposalCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetDisposalRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetInventoryCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetInventoryDetailCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetInventoryDetailRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetInventoryRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetPeriodCloseReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetPeriodCloseRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetPeriodReopenReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetPeriodReopenRespVO;

import java.util.List;

public interface FinanceAssetService {

    AssetCategoryRespVO createCategory(AssetCategoryCreateReqVO reqVO);

    AssetCategoryRespVO updateCategory(AssetCategoryUpdateReqVO reqVO);

    List<AssetCategoryRespVO> getCategories(Integer enableFlag);

    void deleteCategory(Long categoryId);

    AssetCardRespVO createAssetCard(AssetCardCreateReqVO reqVO);

    AssetCardRespVO updateAssetCard(AssetCardUpdateReqVO reqVO);

    AssetCardRespVO getAssetCard(Long assetId);

    AssetCardPageRespVO getAssetCardPage(Integer pageNo, Integer pageSize, String assetName, Long assetCategory, String useStatus);

    void deleteAssetCard(Long assetId);

    AssetDepreciationRespVO createDepreciation(AssetDepreciationCreateReqVO reqVO);

    List<AssetDepreciationRespVO> getDepreciationList(Long assetId, Long ledgerId, String periodLabel);

    AssetDisposalRespVO createDisposal(AssetDisposalCreateReqVO reqVO);

    List<AssetDisposalRespVO> getDisposalList(Long assetId, Long ledgerId);

    AssetInventoryRespVO createInventory(AssetInventoryCreateReqVO reqVO);

    AssetInventoryDetailRespVO createInventoryDetail(AssetInventoryDetailCreateReqVO reqVO);

    List<AssetInventoryRespVO> getInventoryList(Long ledgerId, String status);

    AssetInventoryRespVO getInventoryResult(Long inventoryId);

    AssetPeriodCloseRespVO closeAssetPeriod(AssetPeriodCloseReqVO reqVO);

    AssetPeriodReopenRespVO reopenAssetPeriod(AssetPeriodReopenReqVO reqVO);
}
