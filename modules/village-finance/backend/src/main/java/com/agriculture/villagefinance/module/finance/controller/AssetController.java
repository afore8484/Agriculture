package com.agriculture.villagefinance.module.finance.controller;

import com.agriculture.villagefinance.common.pojo.CommonResult;
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
import com.agriculture.villagefinance.module.finance.service.FinanceAssetService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping({"/api/village-finance/asset", "/api/asset"})
public class AssetController {

    private final FinanceAssetService financeAssetService;

    @PostMapping("/category/create")
    public CommonResult<AssetCategoryRespVO> createCategory(@Valid @RequestBody AssetCategoryCreateReqVO reqVO) {
        return CommonResult.success(financeAssetService.createCategory(reqVO));
    }

    @PutMapping("/category/update")
    public CommonResult<AssetCategoryRespVO> updateCategory(@Valid @RequestBody AssetCategoryUpdateReqVO reqVO) {
        return CommonResult.success(financeAssetService.updateCategory(reqVO));
    }

    @GetMapping("/category/list")
    public CommonResult<List<AssetCategoryRespVO>> getCategories(@RequestParam(required = false) Integer enableFlag) {
        return CommonResult.success(financeAssetService.getCategories(enableFlag));
    }

    @DeleteMapping("/category/delete")
    public CommonResult<Boolean> deleteCategory(@RequestParam Long categoryId) {
        financeAssetService.deleteCategory(categoryId);
        return CommonResult.success(true);
    }

    @PostMapping("/card/create")
    public CommonResult<AssetCardRespVO> createAssetCard(@Valid @RequestBody AssetCardCreateReqVO reqVO) {
        return CommonResult.success(financeAssetService.createAssetCard(reqVO));
    }

    @PutMapping("/card/update")
    public CommonResult<AssetCardRespVO> updateAssetCard(@Valid @RequestBody AssetCardUpdateReqVO reqVO) {
        return CommonResult.success(financeAssetService.updateAssetCard(reqVO));
    }

    @GetMapping("/card/detail")
    public CommonResult<AssetCardRespVO> getAssetCard(@RequestParam Long assetId) {
        return CommonResult.success(financeAssetService.getAssetCard(assetId));
    }

    @GetMapping("/card/page")
    public CommonResult<AssetCardPageRespVO> getAssetCards(@RequestParam Integer pageNo,
                                                           @RequestParam Integer pageSize,
                                                           @RequestParam(required = false) String assetName,
                                                           @RequestParam(required = false) Long assetCategory,
                                                           @RequestParam(required = false) String useStatus) {
        return CommonResult.success(financeAssetService.getAssetCardPage(pageNo, pageSize, assetName, assetCategory, useStatus));
    }

    @DeleteMapping("/card/delete")
    public CommonResult<Boolean> deleteAssetCard(@RequestParam Long assetId) {
        financeAssetService.deleteAssetCard(assetId);
        return CommonResult.success(true);
    }

    @PostMapping("/depreciation/create")
    public CommonResult<AssetDepreciationRespVO> createDepreciation(@Valid @RequestBody AssetDepreciationCreateReqVO reqVO) {
        return CommonResult.success(financeAssetService.createDepreciation(reqVO));
    }

    @GetMapping("/depreciation/list")
    public CommonResult<List<AssetDepreciationRespVO>> getDepreciationList(@RequestParam(required = false) Long assetId,
                                                                            @RequestParam(required = false) Long ledgerId,
                                                                            @RequestParam(required = false) String periodLabel) {
        return CommonResult.success(financeAssetService.getDepreciationList(assetId, ledgerId, periodLabel));
    }

    @PostMapping("/disposal/create")
    public CommonResult<AssetDisposalRespVO> createDisposal(@Valid @RequestBody AssetDisposalCreateReqVO reqVO) {
        return CommonResult.success(financeAssetService.createDisposal(reqVO));
    }

    @GetMapping("/disposal/list")
    public CommonResult<List<AssetDisposalRespVO>> getDisposalList(@RequestParam(required = false) Long assetId,
                                                                   @RequestParam(required = false) Long ledgerId) {
        return CommonResult.success(financeAssetService.getDisposalList(assetId, ledgerId));
    }

    @PostMapping("/inventory/create")
    public CommonResult<AssetInventoryRespVO> createInventory(@Valid @RequestBody AssetInventoryCreateReqVO reqVO) {
        return CommonResult.success(financeAssetService.createInventory(reqVO));
    }

    @PostMapping("/inventory/detail/create")
    public CommonResult<AssetInventoryDetailRespVO> createInventoryDetail(@Valid @RequestBody AssetInventoryDetailCreateReqVO reqVO) {
        return CommonResult.success(financeAssetService.createInventoryDetail(reqVO));
    }

    @GetMapping("/inventory/list")
    public CommonResult<List<AssetInventoryRespVO>> getInventoryList(@RequestParam(required = false) Long ledgerId,
                                                                     @RequestParam(required = false) String status) {
        return CommonResult.success(financeAssetService.getInventoryList(ledgerId, status));
    }

    @GetMapping("/inventory/result")
    public CommonResult<AssetInventoryRespVO> getInventoryResult(@RequestParam Long inventoryId) {
        return CommonResult.success(financeAssetService.getInventoryResult(inventoryId));
    }

    @PostMapping("/period-close/close")
    public CommonResult<AssetPeriodCloseRespVO> closeAssetPeriod(@Valid @RequestBody AssetPeriodCloseReqVO reqVO) {
        return CommonResult.success(financeAssetService.closeAssetPeriod(reqVO));
    }

    @PostMapping("/period-close/reopen")
    public CommonResult<AssetPeriodReopenRespVO> reopenAssetPeriod(@Valid @RequestBody AssetPeriodReopenReqVO reqVO) {
        return CommonResult.success(financeAssetService.reopenAssetPeriod(reqVO));
    }
}
