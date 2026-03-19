package com.agriculture.villagefinance.module.finance.service.impl;

import com.agriculture.villagefinance.module.finance.constant.FinanceVoucherType;
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
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherActionRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherEntryReqVO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinAssetCardDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinAssetCategoryDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinAssetDepreciationDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinAssetDisposalDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinAssetInventoryDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinAssetInventoryDetailDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinBookDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodCloseDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodOperationLogDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodReopenLogDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinSubjectDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinVoucherDO;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinAssetCardMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinAssetCategoryMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinAssetDepreciationMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinAssetDisposalMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinAssetInventoryDetailMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinAssetInventoryMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinBookMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodCloseMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodOperationLogMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodReopenLogMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinSubjectMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinVoucherMapper;
import com.agriculture.villagefinance.module.finance.service.BizVoucherLinkService;
import com.agriculture.villagefinance.module.finance.service.FinanceAssetService;
import com.agriculture.villagefinance.module.finance.service.dto.BizVoucherCreateCmd;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class FinanceAssetServiceImpl implements FinanceAssetService {

    private static final int ENABLE_FLAG = 1;
    private static final String PERIOD_CLOSED = "CLOSED";
    private static final String PERIOD_OPEN = "OPEN";
    private static final String ASSET_STATUS_DISPOSED = "DISPOSED";
    private static final String INVENTORY_STATUS_DRAFT = "DRAFT";
    private static final String DISPOSAL_STATUS_NORMAL = "NORMAL";
    private static final String ASSET_CLOSE_TYPE = "ASSET";
    private static final String ASSET_OPERATION_CLOSE = "ASSET_CLOSE";
    private static final String ASSET_OPERATION_REOPEN = "ASSET_REOPEN";
    private static final String ASSET_REOPEN_NO_PREFIX = "ASSET-REOPEN-";
    private static final DateTimeFormatter PERIOD_LABEL_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM");
    private static final DateTimeFormatter INVENTORY_NO_DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyyMMdd");

    private final FinAssetCategoryMapper finAssetCategoryMapper;
    private final FinAssetCardMapper finAssetCardMapper;
    private final FinAssetDepreciationMapper finAssetDepreciationMapper;
    private final FinAssetDisposalMapper finAssetDisposalMapper;
    private final FinAssetInventoryMapper finAssetInventoryMapper;
    private final FinAssetInventoryDetailMapper finAssetInventoryDetailMapper;
    private final FinBookMapper finBookMapper;
    private final FinVoucherMapper finVoucherMapper;
    private final FinSubjectMapper finSubjectMapper;
    private final FinPeriodMapper finPeriodMapper;
    private final FinPeriodCloseMapper finPeriodCloseMapper;
    private final FinPeriodReopenLogMapper finPeriodReopenLogMapper;
    private final FinPeriodOperationLogMapper finPeriodOperationLogMapper;
    private final BizVoucherLinkService bizVoucherLinkService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AssetCategoryRespVO createCategory(AssetCategoryCreateReqVO reqVO) {
        requireCategoryCodeUnique(reqVO.getCategoryCode(), null);
        FinAssetCategoryDO category = new FinAssetCategoryDO();
        category.setCategoryCode(reqVO.getCategoryCode().trim());
        category.setCategoryName(reqVO.getCategoryName().trim());
        category.setParentId(reqVO.getParentId());
        category.setDepreciationYears(reqVO.getDepreciationYears());
        category.setDepreciationMethod(reqVO.getDepreciationMethod());
        category.setResidualRate(reqVO.getResidualRate());
        category.setEnableFlag(reqVO.getEnableFlag() == null ? ENABLE_FLAG : reqVO.getEnableFlag());
        category.setCreatedBy(defaultOperator(reqVO.getOperatorId()));
        category.setCreatedAt(LocalDateTime.now());
        category.setRemark(reqVO.getRemark());
        finAssetCategoryMapper.insert(category);
        return toCategoryResp(category);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AssetCategoryRespVO updateCategory(AssetCategoryUpdateReqVO reqVO) {
        FinAssetCategoryDO category = requireCategory(reqVO.getCategoryId());
        requireCategoryCodeUnique(reqVO.getCategoryCode(), reqVO.getCategoryId());
        category.setCategoryCode(reqVO.getCategoryCode().trim());
        category.setCategoryName(reqVO.getCategoryName().trim());
        category.setParentId(reqVO.getParentId());
        category.setDepreciationYears(reqVO.getDepreciationYears());
        category.setDepreciationMethod(reqVO.getDepreciationMethod());
        category.setResidualRate(reqVO.getResidualRate());
        category.setEnableFlag(reqVO.getEnableFlag() == null ? category.getEnableFlag() : reqVO.getEnableFlag());
        category.setUpdatedBy(defaultOperator(reqVO.getOperatorId()));
        category.setUpdatedAt(LocalDateTime.now());
        category.setRemark(reqVO.getRemark());
        finAssetCategoryMapper.updateById(category);
        return toCategoryResp(category);
    }

    @Override
    public List<AssetCategoryRespVO> getCategories(Integer enableFlag) {
        LambdaQueryWrapper<FinAssetCategoryDO> wrapper = new LambdaQueryWrapper<FinAssetCategoryDO>()
                .orderByAsc(FinAssetCategoryDO::getCategoryCode);
        if (enableFlag != null) {
            wrapper.eq(FinAssetCategoryDO::getEnableFlag, enableFlag);
        }
        return finAssetCategoryMapper.selectList(wrapper).stream()
                .map(this::toCategoryResp)
                .toList();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteCategory(Long categoryId) {
        requireCategory(categoryId);
        long assetCount = finAssetCardMapper.selectCount(new LambdaQueryWrapper<FinAssetCardDO>()
                .eq(FinAssetCardDO::getCategoryId, categoryId));
        if (assetCount > 0) {
            throw new IllegalStateException("Category is referenced by asset cards and cannot be deleted");
        }
        finAssetCategoryMapper.deleteById(categoryId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AssetCardRespVO createAssetCard(AssetCardCreateReqVO reqVO) {
        requireAssetCodeUnique(reqVO.getAssetCode(), null);
        FinAssetCategoryDO category = requireCategory(reqVO.getCategoryId());
        requireLedger(reqVO.getLedgerId());
        BigDecimal originalValue = defaultAmount(reqVO.getOriginalValue());
        BigDecimal netValue = reqVO.getNetValue() == null ? originalValue : requireNonNegative(reqVO.getNetValue(), "netValue");
        FinAssetCardDO card = new FinAssetCardDO();
        card.setAssetCode(reqVO.getAssetCode().trim());
        card.setAssetName(reqVO.getAssetName().trim());
        card.setCategoryId(category.getId());
        card.setBookId(reqVO.getLedgerId());
        card.setOrgId(reqVO.getOrgId());
        card.setPurchaseDate(reqVO.getPurchaseDate());
        card.setOriginalValue(originalValue);
        card.setNetValue(netValue);
        card.setAccumulatedDepreciation(BigDecimal.ZERO);
        card.setDepreciationYears(reqVO.getDepreciationYears());
        card.setDepreciationMethod(reqVO.getDepreciationMethod());
        card.setResidualRate(reqVO.getResidualRate());
        card.setLocation(reqVO.getLocation());
        card.setKeeperName(reqVO.getKeeperName());
        card.setStatus(StringUtils.hasText(reqVO.getStatus()) ? reqVO.getStatus().trim() : "USING");
        card.setEnableFlag(reqVO.getEnableFlag() == null ? ENABLE_FLAG : reqVO.getEnableFlag());
        card.setCreatedBy(defaultOperator(reqVO.getOperatorId()));
        card.setCreatedAt(LocalDateTime.now());
        card.setRemark(reqVO.getRemark());
        finAssetCardMapper.insert(card);
        return buildAssetResp(card, category.getCategoryName());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AssetCardRespVO updateAssetCard(AssetCardUpdateReqVO reqVO) {
        FinAssetCardDO card = requireAssetCard(reqVO.getAssetId());
        FinAssetCategoryDO category = requireCategory(reqVO.getCategoryId());
        if (reqVO.getOriginalValue() != null) {
            card.setOriginalValue(requireNonNegative(reqVO.getOriginalValue(), "originalValue"));
        }
        if (reqVO.getNetValue() != null) {
            card.setNetValue(requireNonNegative(reqVO.getNetValue(), "netValue"));
        }
        card.setAssetName(reqVO.getAssetName().trim());
        card.setCategoryId(reqVO.getCategoryId());
        card.setOrgId(reqVO.getOrgId());
        card.setPurchaseDate(reqVO.getPurchaseDate());
        card.setDepreciationYears(reqVO.getDepreciationYears());
        card.setDepreciationMethod(reqVO.getDepreciationMethod());
        card.setResidualRate(reqVO.getResidualRate());
        card.setLocation(reqVO.getLocation());
        card.setKeeperName(reqVO.getKeeperName());
        if (StringUtils.hasText(reqVO.getStatus())) {
            card.setStatus(reqVO.getStatus().trim());
        }
        if (reqVO.getEnableFlag() != null) {
            card.setEnableFlag(reqVO.getEnableFlag());
        }
        card.setUpdatedBy(defaultOperator(reqVO.getOperatorId()));
        card.setUpdatedAt(LocalDateTime.now());
        card.setRemark(reqVO.getRemark());
        finAssetCardMapper.updateById(card);
        return buildAssetResp(card, category.getCategoryName());
    }

    @Override
    public AssetCardRespVO getAssetCard(Long assetId) {
        FinAssetCardDO card = requireAssetCard(assetId);
        FinAssetCategoryDO category = requireCategory(card.getCategoryId());
        return buildAssetResp(card, category.getCategoryName());
    }

    @Override
    public AssetCardPageRespVO getAssetCardPage(Integer pageNo, Integer pageSize, String assetName, Long assetCategory, String useStatus) {
        long total = finAssetCardMapper.selectCount(buildAssetListQuery(assetName, assetCategory, useStatus));
        List<FinAssetCardDO> cards = applyPagination(
                finAssetCardMapper.selectList(buildAssetListQuery(assetName, assetCategory, useStatus)),
                pageNo, pageSize
        );
        Map<Long, String> categoryNames = loadCategoryNames(cards);
        AssetCardPageRespVO resp = new AssetCardPageRespVO();
        resp.setTotal(total);
        resp.setRecords(cards.stream().map(item -> {
            AssetCardPageRespVO.Record record = new AssetCardPageRespVO.Record();
            record.setAssetId(item.getId());
            record.setAssetCode(item.getAssetCode());
            record.setAssetName(item.getAssetName());
            record.setCategoryName(categoryNames.get(item.getCategoryId()));
            record.setOriginalValue(item.getOriginalValue());
            record.setNetValue(item.getNetValue());
            record.setUseStatus(item.getStatus());
            return record;
        }).toList());
        return resp;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteAssetCard(Long assetId) {
        FinAssetCardDO card = requireAssetCard(assetId);
        rejectDeleteWhenProtected(card.getId());
        finAssetCardMapper.deleteById(assetId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AssetDepreciationRespVO createDepreciation(AssetDepreciationCreateReqVO reqVO) {
        FinAssetCardDO card = requireAssetCard(reqVO.getAssetId());
        requireAssetDepreciable(card);
        FinPeriodDO period = requireOpenPeriodByLabel(card.getBookId(), reqVO.getPeriodLabel());
        FinSubjectDO debitSubject = requireSubject(reqVO.getDebitSubjectId(), card.getBookId());
        FinSubjectDO creditSubject = requireSubject(reqVO.getCreditSubjectId(), card.getBookId());
        BigDecimal depreciationAmount = requirePositive(reqVO.getDepreciationAmount(), "depreciationAmount");
        BigDecimal currentAccumulated = defaultAmount(card.getAccumulatedDepreciation());
        BigDecimal currentNet = defaultAmount(card.getNetValue());
        BigDecimal accumulatedAmount = currentAccumulated.add(depreciationAmount);
        BigDecimal netValueAfter = reqVO.getNetValueAfter() == null
                ? currentNet.subtract(depreciationAmount)
                : requireNonNegative(reqVO.getNetValueAfter(), "netValueAfter");
        if (netValueAfter.compareTo(BigDecimal.ZERO) < 0) {
            throw new IllegalArgumentException("netValueAfter cannot be negative");
        }

        FinAssetDepreciationDO depreciation = new FinAssetDepreciationDO();
        depreciation.setAssetId(card.getId());
        depreciation.setBookId(card.getBookId());
        depreciation.setPeriodLabel(formatPeriodLabel(period));
        depreciation.setDepreciationAmount(depreciationAmount);
        depreciation.setAccumulatedAmount(accumulatedAmount);
        depreciation.setNetValueAfter(netValueAfter);
        depreciation.setCreatedBy(defaultOperator(reqVO.getOperatorId()));
        depreciation.setCreatedAt(LocalDateTime.now());
        depreciation.setRemark(reqVO.getRemark());
        finAssetDepreciationMapper.insert(depreciation);

        VoucherActionRespVO voucher = createAssetVoucher(
                card.getBookId(),
                period.getId(),
                period.getStartDate() == null ? LocalDate.now() : period.getStartDate(),
                FinanceVoucherType.ASSET_DEPRECIATION,
                depreciation.getId(),
                buildDepreciationSummary(card.getId(), depreciation.getPeriodLabel()),
                reqVO.getRemark(),
                defaultOperator(reqVO.getOperatorId()),
                depreciationAmount,
                debitSubject.getId(),
                creditSubject.getId()
        );
        depreciation.setVoucherId(voucher.getVoucherId());
        finAssetDepreciationMapper.updateById(depreciation);

        card.setAccumulatedDepreciation(accumulatedAmount);
        card.setNetValue(netValueAfter);
        card.setUpdatedBy(defaultOperator(reqVO.getOperatorId()));
        card.setUpdatedAt(LocalDateTime.now());
        finAssetCardMapper.updateById(card);

        return toDepreciationResp(depreciation);
    }

    @Override
    public List<AssetDepreciationRespVO> getDepreciationList(Long assetId, Long ledgerId, String periodLabel) {
        LambdaQueryWrapper<FinAssetDepreciationDO> wrapper = new LambdaQueryWrapper<FinAssetDepreciationDO>()
                .orderByDesc(FinAssetDepreciationDO::getId);
        if (assetId != null) {
            wrapper.eq(FinAssetDepreciationDO::getAssetId, assetId);
        }
        if (ledgerId != null) {
            wrapper.eq(FinAssetDepreciationDO::getBookId, ledgerId);
        }
        if (StringUtils.hasText(periodLabel)) {
            wrapper.eq(FinAssetDepreciationDO::getPeriodLabel, normalizePeriodLabel(periodLabel));
        }
        return finAssetDepreciationMapper.selectList(wrapper).stream()
                .map(this::toDepreciationResp)
                .toList();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AssetDisposalRespVO createDisposal(AssetDisposalCreateReqVO reqVO) {
        FinAssetCardDO card = requireAssetCard(reqVO.getAssetId());
        if (ASSET_STATUS_DISPOSED.equalsIgnoreCase(card.getStatus())) {
            throw new IllegalStateException("Asset is already disposed");
        }
        long disposalCount = finAssetDisposalMapper.selectCount(new LambdaQueryWrapper<FinAssetDisposalDO>()
                .eq(FinAssetDisposalDO::getAssetId, card.getId()));
        if (disposalCount > 0) {
            throw new IllegalStateException("Asset disposal record already exists");
        }
        FinPeriodDO period = requireOpenPeriodByDate(card.getBookId(), reqVO.getDisposalDate());
        FinSubjectDO debitSubject = requireSubject(reqVO.getDebitSubjectId(), card.getBookId());
        FinSubjectDO creditSubject = requireSubject(reqVO.getCreditSubjectId(), card.getBookId());
        BigDecimal voucherAmount = requirePositive(reqVO.getVoucherAmount(), "voucherAmount");
        BigDecimal disposalIncome = defaultAmount(reqVO.getDisposalIncome());
        BigDecimal disposalLoss = defaultAmount(reqVO.getDisposalLoss());

        FinAssetDisposalDO disposal = new FinAssetDisposalDO();
        disposal.setAssetId(card.getId());
        disposal.setDisposalType(reqVO.getDisposalType().trim());
        disposal.setDisposalDate(reqVO.getDisposalDate());
        disposal.setDisposalIncome(disposalIncome);
        disposal.setDisposalLoss(disposalLoss);
        disposal.setNetValue(defaultAmount(card.getNetValue()));
        disposal.setStatus(DISPOSAL_STATUS_NORMAL);
        disposal.setCreatedBy(defaultOperator(reqVO.getOperatorId()));
        disposal.setCreatedAt(LocalDateTime.now());
        disposal.setRemark(reqVO.getRemark());
        finAssetDisposalMapper.insert(disposal);

        VoucherActionRespVO voucher = createAssetVoucher(
                card.getBookId(),
                period.getId(),
                reqVO.getDisposalDate(),
                FinanceVoucherType.ASSET_DISPOSAL,
                disposal.getId(),
                buildDisposalSummary(card.getId(), reqVO.getDisposalType()),
                reqVO.getRemark(),
                defaultOperator(reqVO.getOperatorId()),
                voucherAmount,
                debitSubject.getId(),
                creditSubject.getId()
        );
        disposal.setVoucherId(voucher.getVoucherId());
        finAssetDisposalMapper.updateById(disposal);

        card.setStatus(ASSET_STATUS_DISPOSED);
        card.setEnableFlag(0);
        card.setUpdatedBy(defaultOperator(reqVO.getOperatorId()));
        card.setUpdatedAt(LocalDateTime.now());
        finAssetCardMapper.updateById(card);
        return toDisposalResp(disposal);
    }

    @Override
    public List<AssetDisposalRespVO> getDisposalList(Long assetId, Long ledgerId) {
        LambdaQueryWrapper<FinAssetDisposalDO> wrapper = new LambdaQueryWrapper<FinAssetDisposalDO>()
                .orderByDesc(FinAssetDisposalDO::getId);
        Set<Long> filteredAssetIds = resolveAssetIdsForDisposalFilter(assetId, ledgerId);
        if (filteredAssetIds != null) {
            if (filteredAssetIds.isEmpty()) {
                return List.of();
            }
            wrapper.in(FinAssetDisposalDO::getAssetId, filteredAssetIds);
        }
        return finAssetDisposalMapper.selectList(wrapper).stream()
                .map(this::toDisposalResp)
                .toList();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AssetInventoryRespVO createInventory(AssetInventoryCreateReqVO reqVO) {
        requireLedger(reqVO.getLedgerId());
        requireOpenPeriodByDate(reqVO.getLedgerId(), reqVO.getInventoryDate());
        long totalAssetCount = finAssetCardMapper.selectCount(new LambdaQueryWrapper<FinAssetCardDO>()
                .eq(FinAssetCardDO::getBookId, reqVO.getLedgerId()));

        FinAssetInventoryDO inventory = new FinAssetInventoryDO();
        inventory.setInventoryNo(buildInventoryNo(reqVO.getLedgerId(), reqVO.getInventoryDate()));
        inventory.setBookId(reqVO.getLedgerId());
        inventory.setOrgId(reqVO.getOrgId());
        inventory.setInventoryDate(reqVO.getInventoryDate());
        inventory.setTotalAssetCount(Math.toIntExact(totalAssetCount));
        inventory.setActualAssetCount(0);
        inventory.setDiffCount(0);
        inventory.setStatus(INVENTORY_STATUS_DRAFT);
        inventory.setCreatedBy(defaultOperator(reqVO.getOperatorId()));
        inventory.setCreatedAt(LocalDateTime.now());
        inventory.setRemark(reqVO.getRemark());
        finAssetInventoryMapper.insert(inventory);
        return toInventoryResp(inventory, List.of());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AssetInventoryDetailRespVO createInventoryDetail(AssetInventoryDetailCreateReqVO reqVO) {
        FinAssetInventoryDO inventory = requireInventory(reqVO.getInventoryId());
        requireOpenPeriodByDate(inventory.getBookId(), inventory.getInventoryDate());
        FinAssetCardDO card = requireAssetCard(reqVO.getAssetId());
        if (!Objects.equals(card.getBookId(), inventory.getBookId())) {
            throw new IllegalArgumentException("Asset and inventory ledger are not consistent");
        }
        BigDecimal actualValue = requireNonNegative(reqVO.getActualValue(), "actualValue");
        BigDecimal bookValue = defaultAmount(card.getNetValue());
        BigDecimal diffValue = actualValue.subtract(bookValue);

        FinAssetInventoryDetailDO detail = new FinAssetInventoryDetailDO();
        detail.setInventoryId(inventory.getId());
        detail.setAssetId(card.getId());
        detail.setBookValue(bookValue);
        detail.setActualValue(actualValue);
        detail.setDiffValue(diffValue);
        detail.setResultType(resolveInventoryResultType(diffValue));
        detail.setRemark(reqVO.getRemark());
        finAssetInventoryDetailMapper.insert(detail);

        refreshInventoryStats(inventory);
        return toInventoryDetailResp(detail, card);
    }

    @Override
    public List<AssetInventoryRespVO> getInventoryList(Long ledgerId, String status) {
        LambdaQueryWrapper<FinAssetInventoryDO> wrapper = new LambdaQueryWrapper<FinAssetInventoryDO>()
                .orderByDesc(FinAssetInventoryDO::getId);
        if (ledgerId != null) {
            wrapper.eq(FinAssetInventoryDO::getBookId, ledgerId);
        }
        if (StringUtils.hasText(status)) {
            wrapper.eq(FinAssetInventoryDO::getStatus, status.trim());
        }
        return finAssetInventoryMapper.selectList(wrapper).stream()
                .map(item -> toInventoryResp(item, List.of()))
                .toList();
    }

    @Override
    public AssetInventoryRespVO getInventoryResult(Long inventoryId) {
        FinAssetInventoryDO inventory = requireInventory(inventoryId);
        List<FinAssetInventoryDetailDO> details = finAssetInventoryDetailMapper.selectList(
                new LambdaQueryWrapper<FinAssetInventoryDetailDO>()
                        .eq(FinAssetInventoryDetailDO::getInventoryId, inventoryId)
                        .orderByAsc(FinAssetInventoryDetailDO::getId)
        );
        Map<Long, FinAssetCardDO> assetMap = loadAssetMap(details);
        List<AssetInventoryDetailRespVO> detailRespList = details.stream()
                .map(item -> toInventoryDetailResp(item, assetMap.get(item.getAssetId())))
                .toList();
        return toInventoryResp(inventory, detailRespList);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AssetPeriodCloseRespVO closeAssetPeriod(AssetPeriodCloseReqVO reqVO) {
        requireLedger(reqVO.getLedgerId());
        requirePeriod(reqVO.getPeriodId(), reqVO.getLedgerId());
        if (isAssetPeriodClosed(reqVO.getLedgerId(), reqVO.getPeriodId())) {
            throw new IllegalStateException("Asset period already closed");
        }
        FinPeriodCloseDO closeDO = new FinPeriodCloseDO();
        closeDO.setBookId(reqVO.getLedgerId());
        closeDO.setPeriodId(reqVO.getPeriodId());
        closeDO.setCloseNo(buildAssetCloseNo(reqVO.getLedgerId(), reqVO.getPeriodId()));
        closeDO.setCloseType(ASSET_CLOSE_TYPE);
        closeDO.setCloseStatus("SUCCESS");
        closeDO.setCloseTime(LocalDateTime.now());
        closeDO.setPendingVoucherCount(0);
        closeDO.setOperatorId(defaultOperator(reqVO.getOperatorId()));
        closeDO.setRemark(reqVO.getRemark());
        finPeriodCloseMapper.insert(closeDO);

        writeAssetPeriodOperation(reqVO.getPeriodId(), ASSET_OPERATION_CLOSE, reqVO.getOperatorId(),
                PERIOD_OPEN, PERIOD_CLOSED, "Asset period close");

        AssetPeriodCloseRespVO respVO = new AssetPeriodCloseRespVO();
        respVO.setCloseId(closeDO.getId());
        respVO.setCloseNo(closeDO.getCloseNo());
        respVO.setCloseStatus(closeDO.getCloseStatus());
        respVO.setCloseTime(closeDO.getCloseTime());
        return respVO;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AssetPeriodReopenRespVO reopenAssetPeriod(AssetPeriodReopenReqVO reqVO) {
        requireLedger(reqVO.getLedgerId());
        requirePeriod(reqVO.getPeriodId(), reqVO.getLedgerId());
        if (!isAssetPeriodClosed(reqVO.getLedgerId(), reqVO.getPeriodId())) {
            throw new IllegalStateException("Asset period is not closed");
        }
        FinPeriodReopenLogDO reopenLogDO = new FinPeriodReopenLogDO();
        reopenLogDO.setBookId(reqVO.getLedgerId());
        reopenLogDO.setPeriodId(reqVO.getPeriodId());
        reopenLogDO.setReopenNo(buildAssetReopenNo(reqVO.getLedgerId(), reqVO.getPeriodId()));
        reopenLogDO.setReason(reqVO.getReason());
        reopenLogDO.setOperatorId(defaultOperator(reqVO.getOperatorId()));
        reopenLogDO.setOperateTime(LocalDateTime.now());
        reopenLogDO.setPeriodStatus(PERIOD_OPEN);
        finPeriodReopenLogMapper.insert(reopenLogDO);

        writeAssetPeriodOperation(reqVO.getPeriodId(), ASSET_OPERATION_REOPEN, reqVO.getOperatorId(),
                PERIOD_CLOSED, PERIOD_OPEN, "Asset period reopen");

        AssetPeriodReopenRespVO respVO = new AssetPeriodReopenRespVO();
        respVO.setReopenId(reopenLogDO.getId());
        respVO.setReopenNo(reopenLogDO.getReopenNo());
        respVO.setPeriodStatus(reopenLogDO.getPeriodStatus());
        respVO.setOperateTime(reopenLogDO.getOperateTime());
        return respVO;
    }

    private void rejectDeleteWhenProtected(Long assetId) {
        long depreciationCount = finAssetDepreciationMapper.selectCount(new LambdaQueryWrapper<FinAssetDepreciationDO>()
                .eq(FinAssetDepreciationDO::getAssetId, assetId));
        if (depreciationCount > 0) {
            throw new IllegalStateException("Asset already has depreciation records and cannot be deleted");
        }
        long disposalCount = finAssetDisposalMapper.selectCount(new LambdaQueryWrapper<FinAssetDisposalDO>()
                .eq(FinAssetDisposalDO::getAssetId, assetId));
        if (disposalCount > 0) {
            throw new IllegalStateException("Asset already has disposal records and cannot be deleted");
        }
        long inventoryCount = finAssetInventoryDetailMapper.selectCount(new LambdaQueryWrapper<FinAssetInventoryDetailDO>()
                .eq(FinAssetInventoryDetailDO::getAssetId, assetId));
        if (inventoryCount > 0) {
            throw new IllegalStateException("Asset already has inventory records and cannot be deleted");
        }
        List<Long> depreciationIds = finAssetDepreciationMapper.selectList(new LambdaQueryWrapper<FinAssetDepreciationDO>()
                        .eq(FinAssetDepreciationDO::getAssetId, assetId))
                .stream()
                .map(FinAssetDepreciationDO::getId)
                .toList();
        List<Long> disposalIds = finAssetDisposalMapper.selectList(new LambdaQueryWrapper<FinAssetDisposalDO>()
                        .eq(FinAssetDisposalDO::getAssetId, assetId))
                .stream()
                .map(FinAssetDisposalDO::getId)
                .toList();
        long voucherLinkCount = 0L;
        if (!depreciationIds.isEmpty()) {
            voucherLinkCount += finVoucherMapper.selectCount(new LambdaQueryWrapper<FinVoucherDO>()
                    .eq(FinVoucherDO::getVoucherType, FinanceVoucherType.ASSET_DEPRECIATION)
                    .in(FinVoucherDO::getBizId, depreciationIds));
        }
        if (!disposalIds.isEmpty()) {
            voucherLinkCount += finVoucherMapper.selectCount(new LambdaQueryWrapper<FinVoucherDO>()
                    .eq(FinVoucherDO::getVoucherType, FinanceVoucherType.ASSET_DISPOSAL)
                    .in(FinVoucherDO::getBizId, disposalIds));
        }
        if (voucherLinkCount > 0) {
            throw new IllegalStateException("Asset already linked voucher records and cannot be deleted");
        }
    }

    private LambdaQueryWrapper<FinAssetCardDO> buildAssetListQuery(String assetName, Long assetCategory, String useStatus) {
        LambdaQueryWrapper<FinAssetCardDO> wrapper = new LambdaQueryWrapper<FinAssetCardDO>()
                .orderByDesc(FinAssetCardDO::getId);
        if (StringUtils.hasText(assetName)) {
            wrapper.like(FinAssetCardDO::getAssetName, assetName.trim());
        }
        if (assetCategory != null) {
            wrapper.eq(FinAssetCardDO::getCategoryId, assetCategory);
        }
        if (StringUtils.hasText(useStatus)) {
            wrapper.eq(FinAssetCardDO::getStatus, useStatus.trim().toUpperCase());
        }
        return wrapper;
    }

    private Map<Long, String> loadCategoryNames(List<FinAssetCardDO> cards) {
        Set<Long> categoryIds = cards.stream()
                .map(FinAssetCardDO::getCategoryId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());
        if (categoryIds.isEmpty()) {
            return Map.of();
        }
        return finAssetCategoryMapper.selectBatchIds(categoryIds).stream()
                .collect(Collectors.toMap(FinAssetCategoryDO::getId, FinAssetCategoryDO::getCategoryName,
                        (a, b) -> a, LinkedHashMap::new));
    }

    private FinAssetCategoryDO requireCategory(Long categoryId) {
        FinAssetCategoryDO category = finAssetCategoryMapper.selectById(categoryId);
        if (category == null) {
            throw new IllegalArgumentException("Asset category does not exist");
        }
        return category;
    }

    private FinBookDO requireLedger(Long ledgerId) {
        FinBookDO ledger = finBookMapper.selectById(ledgerId);
        if (ledger == null) {
            throw new IllegalArgumentException("Ledger does not exist");
        }
        return ledger;
    }

    private FinAssetCardDO requireAssetCard(Long assetId) {
        FinAssetCardDO card = finAssetCardMapper.selectById(assetId);
        if (card == null) {
            throw new IllegalArgumentException("Asset card does not exist");
        }
        return card;
    }

    private FinAssetInventoryDO requireInventory(Long inventoryId) {
        FinAssetInventoryDO inventory = finAssetInventoryMapper.selectById(inventoryId);
        if (inventory == null) {
            throw new IllegalArgumentException("Asset inventory does not exist");
        }
        return inventory;
    }

    private FinPeriodDO requireOpenPeriodByDate(Long ledgerId, LocalDate businessDate) {
        FinPeriodDO period = finPeriodMapper.selectOne(new LambdaQueryWrapper<FinPeriodDO>()
                .eq(FinPeriodDO::getBookId, ledgerId)
                .le(FinPeriodDO::getStartDate, businessDate)
                .ge(FinPeriodDO::getEndDate, businessDate)
                .last("LIMIT 1"));
        if (period == null) {
            throw new IllegalArgumentException("No accounting period found for the business date");
        }
        if (PERIOD_CLOSED.equalsIgnoreCase(period.getCloseStatus())) {
            throw new IllegalStateException("Period is closed and write is not allowed");
        }
        ensureAssetPeriodWritable(period.getBookId(), period.getId());
        return period;
    }

    private FinPeriodDO requireOpenPeriodByLabel(Long ledgerId, String periodLabel) {
        YearMonth yearMonth = parsePeriodLabel(periodLabel);
        FinPeriodDO period = finPeriodMapper.selectOne(new LambdaQueryWrapper<FinPeriodDO>()
                .eq(FinPeriodDO::getBookId, ledgerId)
                .eq(FinPeriodDO::getPeriodYear, yearMonth.getYear())
                .eq(FinPeriodDO::getPeriodNo, yearMonth.getMonthValue())
                .last("LIMIT 1"));
        if (period == null) {
            throw new IllegalArgumentException("Accounting period does not exist");
        }
        if (PERIOD_CLOSED.equalsIgnoreCase(period.getCloseStatus())) {
            throw new IllegalStateException("Period is closed and write is not allowed");
        }
        ensureAssetPeriodWritable(period.getBookId(), period.getId());
        return period;
    }

    private FinPeriodDO requirePeriod(Long periodId, Long ledgerId) {
        FinPeriodDO period = finPeriodMapper.selectById(periodId);
        if (period == null || !Objects.equals(period.getBookId(), ledgerId)) {
            throw new IllegalArgumentException("Accounting period does not exist");
        }
        return period;
    }

    private FinSubjectDO requireSubject(Long subjectId, Long ledgerId) {
        FinSubjectDO subject = finSubjectMapper.selectById(subjectId);
        if (subject == null || !Objects.equals(subject.getBookId(), ledgerId)) {
            throw new IllegalArgumentException("Accounting subject does not exist");
        }
        if (subject.getEnableFlag() == null || subject.getEnableFlag() != 1) {
            throw new IllegalArgumentException("Accounting subject is disabled");
        }
        return subject;
    }

    private void requireAssetDepreciable(FinAssetCardDO card) {
        if (!Objects.equals(card.getEnableFlag(), ENABLE_FLAG)) {
            throw new IllegalStateException("Asset is disabled and cannot be depreciated");
        }
        if (ASSET_STATUS_DISPOSED.equalsIgnoreCase(card.getStatus())) {
            throw new IllegalStateException("Disposed asset cannot be depreciated");
        }
    }

    private void requireCategoryCodeUnique(String categoryCode, Long excludeId) {
        if (!StringUtils.hasText(categoryCode)) {
            throw new IllegalArgumentException("categoryCode is required");
        }
        LambdaQueryWrapper<FinAssetCategoryDO> wrapper = new LambdaQueryWrapper<FinAssetCategoryDO>()
                .eq(FinAssetCategoryDO::getCategoryCode, categoryCode.trim());
        if (excludeId != null) {
            wrapper.ne(FinAssetCategoryDO::getId, excludeId);
        }
        if (finAssetCategoryMapper.selectCount(wrapper) > 0) {
            throw new IllegalArgumentException("Asset category code already exists");
        }
    }

    private void requireAssetCodeUnique(String assetCode, Long excludeId) {
        if (!StringUtils.hasText(assetCode)) {
            throw new IllegalArgumentException("assetCode is required");
        }
        LambdaQueryWrapper<FinAssetCardDO> wrapper = new LambdaQueryWrapper<FinAssetCardDO>()
                .eq(FinAssetCardDO::getAssetCode, assetCode.trim());
        if (excludeId != null) {
            wrapper.ne(FinAssetCardDO::getId, excludeId);
        }
        if (finAssetCardMapper.selectCount(wrapper) > 0) {
            throw new IllegalArgumentException("Asset code already exists");
        }
    }

    private String buildInventoryNo(Long ledgerId, LocalDate inventoryDate) {
        long dayCount = finAssetInventoryMapper.selectCount(new LambdaQueryWrapper<FinAssetInventoryDO>()
                .eq(FinAssetInventoryDO::getBookId, ledgerId)
                .eq(FinAssetInventoryDO::getInventoryDate, inventoryDate));
        return "INV-" + ledgerId + "-" + inventoryDate.format(INVENTORY_NO_DATE_FORMATTER) + "-"
                + String.format("%03d", dayCount + 1);
    }

    private void refreshInventoryStats(FinAssetInventoryDO inventory) {
        long actualCount = finAssetInventoryDetailMapper.selectCount(new LambdaQueryWrapper<FinAssetInventoryDetailDO>()
                .eq(FinAssetInventoryDetailDO::getInventoryId, inventory.getId()));
        long diffCount = finAssetInventoryDetailMapper.selectCount(new LambdaQueryWrapper<FinAssetInventoryDetailDO>()
                .eq(FinAssetInventoryDetailDO::getInventoryId, inventory.getId())
                .ne(FinAssetInventoryDetailDO::getDiffValue, BigDecimal.ZERO));
        inventory.setActualAssetCount(Math.toIntExact(actualCount));
        inventory.setDiffCount(Math.toIntExact(diffCount));
        finAssetInventoryMapper.updateById(inventory);
    }

    private Set<Long> resolveAssetIdsForDisposalFilter(Long assetId, Long ledgerId) {
        if (assetId == null && ledgerId == null) {
            return null;
        }
        if (ledgerId == null) {
            return Set.of(assetId);
        }
        LambdaQueryWrapper<FinAssetCardDO> assetWrapper = new LambdaQueryWrapper<FinAssetCardDO>()
                .eq(FinAssetCardDO::getBookId, ledgerId);
        if (assetId != null) {
            assetWrapper.eq(FinAssetCardDO::getId, assetId);
        }
        return finAssetCardMapper.selectList(assetWrapper).stream()
                .map(FinAssetCardDO::getId)
                .collect(Collectors.toSet());
    }

    private Map<Long, FinAssetCardDO> loadAssetMap(List<FinAssetInventoryDetailDO> details) {
        Set<Long> assetIds = details.stream()
                .map(FinAssetInventoryDetailDO::getAssetId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());
        if (assetIds.isEmpty()) {
            return Map.of();
        }
        return finAssetCardMapper.selectBatchIds(assetIds).stream()
                .collect(Collectors.toMap(FinAssetCardDO::getId, item -> item));
    }

    private String resolveInventoryResultType(BigDecimal diffValue) {
        int flag = diffValue.compareTo(BigDecimal.ZERO);
        if (flag > 0) {
            return "PROFIT";
        }
        if (flag < 0) {
            return "LOSS";
        }
        return "NORMAL";
    }

    private VoucherActionRespVO createAssetVoucher(Long ledgerId, Long periodId, LocalDate voucherDate,
                                                   String voucherType, Long bizId, String summary, String remark,
                                                   Long operatorId, BigDecimal amount,
                                                   Long debitSubjectId, Long creditSubjectId) {
        VoucherEntryReqVO debit = new VoucherEntryReqVO();
        debit.setSubjectId(debitSubjectId);
        debit.setSummary(summary);
        debit.setDebitAmount(amount);
        debit.setCreditAmount(BigDecimal.ZERO);
        debit.setSortOrder(1);

        VoucherEntryReqVO credit = new VoucherEntryReqVO();
        credit.setSubjectId(creditSubjectId);
        credit.setSummary(summary);
        credit.setDebitAmount(BigDecimal.ZERO);
        credit.setCreditAmount(amount);
        credit.setSortOrder(2);

        BizVoucherCreateCmd cmd = new BizVoucherCreateCmd();
        cmd.setLedgerId(ledgerId);
        cmd.setPeriodId(periodId);
        cmd.setVoucherDate(voucherDate);
        cmd.setVoucherType(voucherType);
        cmd.setBizId(bizId);
        cmd.setSummary(summary);
        cmd.setRemark(remark);
        cmd.setOperatorId(operatorId);
        cmd.setEntries(List.of(debit, credit));
        return bizVoucherLinkService.createVoucher(cmd);
    }

    private String buildDepreciationSummary(Long assetId, String periodLabel) {
        return "Asset depreciation: assetId=" + assetId + ", period=" + periodLabel;
    }

    private String buildDisposalSummary(Long assetId, String disposalType) {
        return "Asset disposal: assetId=" + assetId + ", type=" + disposalType;
    }

    private void ensureAssetPeriodWritable(Long ledgerId, Long periodId) {
        if (isAssetPeriodClosed(ledgerId, periodId)) {
            throw new IllegalStateException("Asset period is closed and write is not allowed");
        }
    }

    private boolean isAssetPeriodClosed(Long ledgerId, Long periodId) {
        FinPeriodCloseDO latestClose = finPeriodCloseMapper.selectOne(new LambdaQueryWrapper<FinPeriodCloseDO>()
                .eq(FinPeriodCloseDO::getBookId, ledgerId)
                .eq(FinPeriodCloseDO::getPeriodId, periodId)
                .eq(FinPeriodCloseDO::getCloseType, ASSET_CLOSE_TYPE)
                .orderByDesc(FinPeriodCloseDO::getId)
                .last("limit 1"));
        if (latestClose == null) {
            return false;
        }
        FinPeriodReopenLogDO latestReopen = finPeriodReopenLogMapper.selectOne(new LambdaQueryWrapper<FinPeriodReopenLogDO>()
                .eq(FinPeriodReopenLogDO::getBookId, ledgerId)
                .eq(FinPeriodReopenLogDO::getPeriodId, periodId)
                .like(FinPeriodReopenLogDO::getReopenNo, ASSET_REOPEN_NO_PREFIX + ledgerId + "-" + periodId + "-")
                .orderByDesc(FinPeriodReopenLogDO::getId)
                .last("limit 1"));
        if (latestReopen == null) {
            return true;
        }
        LocalDateTime closeTime = latestClose.getCloseTime() == null ? LocalDateTime.MIN : latestClose.getCloseTime();
        LocalDateTime reopenTime = latestReopen.getOperateTime() == null ? LocalDateTime.MIN : latestReopen.getOperateTime();
        return !reopenTime.isAfter(closeTime);
    }

    private String buildAssetCloseNo(Long ledgerId, Long periodId) {
        long count = finPeriodCloseMapper.selectCount(new LambdaQueryWrapper<FinPeriodCloseDO>()
                .eq(FinPeriodCloseDO::getBookId, ledgerId)
                .eq(FinPeriodCloseDO::getPeriodId, periodId)
                .eq(FinPeriodCloseDO::getCloseType, ASSET_CLOSE_TYPE));
        return "ASSET-CLOSE-" + ledgerId + "-" + periodId + "-" + String.format("%03d", count + 1);
    }

    private String buildAssetReopenNo(Long ledgerId, Long periodId) {
        String prefix = ASSET_REOPEN_NO_PREFIX + ledgerId + "-" + periodId + "-";
        long count = finPeriodReopenLogMapper.selectCount(new LambdaQueryWrapper<FinPeriodReopenLogDO>()
                .eq(FinPeriodReopenLogDO::getBookId, ledgerId)
                .eq(FinPeriodReopenLogDO::getPeriodId, periodId)
                .like(FinPeriodReopenLogDO::getReopenNo, prefix));
        return prefix + String.format("%03d", count + 1);
    }

    private void writeAssetPeriodOperation(Long periodId, String operationType, Long operatorId,
                                           String beforeStatus, String afterStatus, String desc) {
        FinPeriodOperationLogDO logDO = new FinPeriodOperationLogDO();
        logDO.setPeriodId(periodId);
        logDO.setOperationType(operationType);
        logDO.setOperatorId(defaultOperator(operatorId));
        logDO.setOperationTime(LocalDateTime.now());
        logDO.setBeforeStatus(beforeStatus);
        logDO.setAfterStatus(afterStatus);
        logDO.setOperationDesc(desc);
        finPeriodOperationLogMapper.insert(logDO);
    }

    private AssetCategoryRespVO toCategoryResp(FinAssetCategoryDO item) {
        AssetCategoryRespVO vo = new AssetCategoryRespVO();
        vo.setCategoryId(item.getId());
        vo.setCategoryCode(item.getCategoryCode());
        vo.setCategoryName(item.getCategoryName());
        vo.setParentId(item.getParentId());
        vo.setDepreciationYears(item.getDepreciationYears());
        vo.setDepreciationMethod(item.getDepreciationMethod());
        vo.setResidualRate(item.getResidualRate());
        vo.setEnableFlag(item.getEnableFlag());
        vo.setRemark(item.getRemark());
        return vo;
    }

    private AssetCardRespVO buildAssetResp(FinAssetCardDO item, String categoryName) {
        AssetCardRespVO vo = new AssetCardRespVO();
        vo.setAssetId(item.getId());
        vo.setAssetCode(item.getAssetCode());
        vo.setAssetName(item.getAssetName());
        vo.setCategoryId(item.getCategoryId());
        vo.setCategoryName(categoryName);
        vo.setLedgerId(item.getBookId());
        vo.setOrgId(item.getOrgId());
        vo.setPurchaseDate(item.getPurchaseDate());
        vo.setOriginalValue(item.getOriginalValue());
        vo.setNetValue(item.getNetValue());
        vo.setAccumulatedDepreciation(item.getAccumulatedDepreciation());
        vo.setDepreciationYears(item.getDepreciationYears());
        vo.setDepreciationMethod(item.getDepreciationMethod());
        vo.setResidualRate(item.getResidualRate());
        vo.setLocation(item.getLocation());
        vo.setKeeperName(item.getKeeperName());
        vo.setStatus(item.getStatus());
        vo.setEnableFlag(item.getEnableFlag());
        vo.setRemark(item.getRemark());
        return vo;
    }

    private AssetDepreciationRespVO toDepreciationResp(FinAssetDepreciationDO item) {
        AssetDepreciationRespVO vo = new AssetDepreciationRespVO();
        vo.setDepreciationId(item.getId());
        vo.setAssetId(item.getAssetId());
        vo.setPeriodLabel(item.getPeriodLabel());
        vo.setDepreciationAmount(item.getDepreciationAmount());
        vo.setAccumulatedAmount(item.getAccumulatedAmount());
        vo.setNetValueAfter(item.getNetValueAfter());
        vo.setVoucherId(item.getVoucherId());
        vo.setCreatedAt(item.getCreatedAt());
        return vo;
    }

    private AssetDisposalRespVO toDisposalResp(FinAssetDisposalDO item) {
        AssetDisposalRespVO vo = new AssetDisposalRespVO();
        vo.setDisposalId(item.getId());
        vo.setAssetId(item.getAssetId());
        vo.setDisposalType(item.getDisposalType());
        vo.setDisposalDate(item.getDisposalDate());
        vo.setDisposalIncome(item.getDisposalIncome());
        vo.setDisposalLoss(item.getDisposalLoss());
        vo.setNetValue(item.getNetValue());
        vo.setVoucherId(item.getVoucherId());
        vo.setStatus(item.getStatus());
        vo.setCreatedAt(item.getCreatedAt());
        return vo;
    }

    private AssetInventoryRespVO toInventoryResp(FinAssetInventoryDO item, List<AssetInventoryDetailRespVO> details) {
        AssetInventoryRespVO vo = new AssetInventoryRespVO();
        vo.setInventoryId(item.getId());
        vo.setInventoryNo(item.getInventoryNo());
        vo.setLedgerId(item.getBookId());
        vo.setOrgId(item.getOrgId());
        vo.setInventoryDate(item.getInventoryDate());
        vo.setTotalAssetCount(item.getTotalAssetCount());
        vo.setActualAssetCount(item.getActualAssetCount());
        vo.setDiffCount(item.getDiffCount());
        vo.setStatus(item.getStatus());
        vo.setCreatedAt(item.getCreatedAt());
        vo.setDetails(details);
        return vo;
    }

    private AssetInventoryDetailRespVO toInventoryDetailResp(FinAssetInventoryDetailDO detail, FinAssetCardDO card) {
        AssetInventoryDetailRespVO vo = new AssetInventoryDetailRespVO();
        vo.setDetailId(detail.getId());
        vo.setInventoryId(detail.getInventoryId());
        vo.setAssetId(detail.getAssetId());
        vo.setAssetCode(card == null ? null : card.getAssetCode());
        vo.setAssetName(card == null ? null : card.getAssetName());
        vo.setBookValue(detail.getBookValue());
        vo.setActualValue(detail.getActualValue());
        vo.setDiffValue(detail.getDiffValue());
        vo.setResultType(detail.getResultType());
        vo.setRemark(detail.getRemark());
        return vo;
    }

    private BigDecimal defaultAmount(BigDecimal amount) {
        if (amount == null) {
            return BigDecimal.ZERO;
        }
        if (amount.compareTo(BigDecimal.ZERO) < 0) {
            throw new IllegalArgumentException("amount cannot be negative");
        }
        return amount;
    }

    private BigDecimal requirePositive(BigDecimal amount, String fieldName) {
        if (amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException(fieldName + " must be greater than zero");
        }
        return amount;
    }

    private BigDecimal requireNonNegative(BigDecimal amount, String fieldName) {
        if (amount == null || amount.compareTo(BigDecimal.ZERO) < 0) {
            throw new IllegalArgumentException(fieldName + " cannot be negative");
        }
        return amount;
    }

    private Long defaultOperator(Long operatorId) {
        return operatorId == null ? 0L : operatorId;
    }

    private YearMonth parsePeriodLabel(String periodLabel) {
        if (!StringUtils.hasText(periodLabel)) {
            throw new IllegalArgumentException("periodLabel is required");
        }
        try {
            return YearMonth.parse(periodLabel.trim(), PERIOD_LABEL_FORMATTER);
        } catch (DateTimeParseException ex) {
            throw new IllegalArgumentException("periodLabel format must be yyyy-MM");
        }
    }

    private String normalizePeriodLabel(String periodLabel) {
        return parsePeriodLabel(periodLabel).format(PERIOD_LABEL_FORMATTER);
    }

    private String formatPeriodLabel(FinPeriodDO period) {
        return YearMonth.of(period.getPeriodYear(), period.getPeriodNo()).format(PERIOD_LABEL_FORMATTER);
    }

    private <T> List<T> applyPagination(List<T> source, Integer pageNo, Integer pageSize) {
        if (pageNo == null || pageSize == null || pageNo <= 0 || pageSize <= 0) {
            return source;
        }
        int fromIndex = Math.max((pageNo - 1) * pageSize, 0);
        if (fromIndex >= source.size()) {
            return List.of();
        }
        int toIndex = Math.min(fromIndex + pageSize, source.size());
        return source.subList(fromIndex, toIndex);
    }
}
