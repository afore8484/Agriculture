package com.agriculture.villagefinance.module.finance.service.impl;

import com.agriculture.villagefinance.module.finance.constant.FinanceVoucherType;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeAssetDistributionRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeOrgOptionRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeRecentVoucherRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeStatsRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeTodoRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeTrendRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeYearOptionRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ReportProgressRespVO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinApproveInstanceDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinApproveTaskDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinAssetCardDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinAssetCategoryDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinAssetDepreciationDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinAssetDisposalDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinBookDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinContractMainDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinContractPaymentDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinInternalTransferDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinVoucherDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinVoucherEntryDO;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinApproveInstanceMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinApproveTaskMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinAssetCardMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinAssetCategoryMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinAssetDepreciationMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinAssetDisposalMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinBookMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinContractMainMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinContractPaymentMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinInternalTransferMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinVoucherEntryMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinVoucherMapper;
import com.agriculture.villagefinance.module.finance.service.FinanceHomeService;
import com.agriculture.villagefinance.module.finance.service.FinanceReportService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class FinanceHomeServiceImpl implements FinanceHomeService {

    private static final String STATUS_AUDITED = "AUDITED";
    private static final String TASK_PENDING = "PENDING";
    private static final int DEFAULT_TODO_LIMIT = 10;
    private static final int DEFAULT_VOUCHER_LIMIT = 5;
    private static final int DEFAULT_CHART_MONTHS = 6;
    private static final int MAX_LIMIT = 50;
    private static final int MAX_CHART_MONTHS = 24;
    private static final Pattern PERIOD_PATTERN = Pattern.compile("^(\\d{4})-(\\d{1,2})$");

    private final FinBookMapper finBookMapper;
    private final FinPeriodMapper finPeriodMapper;
    private final FinVoucherMapper finVoucherMapper;
    private final FinVoucherEntryMapper finVoucherEntryMapper;
    private final FinAssetCardMapper finAssetCardMapper;
    private final FinAssetCategoryMapper finAssetCategoryMapper;
    private final FinAssetDepreciationMapper finAssetDepreciationMapper;
    private final FinAssetDisposalMapper finAssetDisposalMapper;
    private final FinApproveTaskMapper finApproveTaskMapper;
    private final FinApproveInstanceMapper finApproveInstanceMapper;
    private final FinContractMainMapper finContractMainMapper;
    private final FinContractPaymentMapper finContractPaymentMapper;
    private final FinInternalTransferMapper finInternalTransferMapper;
    private final FinanceReportService financeReportService;

    @Override
    public List<HomeYearOptionRespVO> queryHomeYears() {
        TreeSet<Integer> years = finBookMapper.selectList(new LambdaQueryWrapper<FinBookDO>()
                        .select(FinBookDO::getFiscalYear)
                        .orderByDesc(FinBookDO::getFiscalYear)
                        .orderByDesc(FinBookDO::getId))
                .stream()
                .map(FinBookDO::getFiscalYear)
                .filter(Objects::nonNull)
                .collect(Collectors.toCollection(TreeSet::new));
        return years.descendingSet().stream().map(year -> {
            HomeYearOptionRespVO vo = new HomeYearOptionRespVO();
            vo.setYear(year);
            return vo;
        }).toList();
    }

    @Override
    public List<HomeOrgOptionRespVO> queryHomeOrgs(Integer year) {
        List<FinBookDO> books = finBookMapper.selectList(new LambdaQueryWrapper<FinBookDO>()
                .eq(year != null, FinBookDO::getFiscalYear, year)
                .orderByDesc(FinBookDO::getId));
        Map<Long, FinBookDO> bookMap = new LinkedHashMap<>();
        for (FinBookDO book : books) {
            if (book.getOrgId() != null) {
                bookMap.putIfAbsent(book.getOrgId(), book);
            }
        }
        return bookMap.values().stream().map(book -> {
            HomeOrgOptionRespVO vo = new HomeOrgOptionRespVO();
            vo.setOrgId(book.getOrgId());
            vo.setLedgerId(book.getId());
            vo.setOrgCode(book.getOrgCode());
            vo.setOrgName(resolveOrgName(book));
            return vo;
        }).toList();
    }

    @Override
    public HomeStatsRespVO queryHomeStats(Long ledgerId, Long orgId, Long periodId, String period, Integer year, Long userId) {
        FinBookDO book = resolveBook(ledgerId, orgId, year);
        FinPeriodDO finPeriod = resolvePeriod(book.getId(), periodId, period, year);
        List<FinVoucherDO> auditedVouchers = finVoucherMapper.selectList(new LambdaQueryWrapper<FinVoucherDO>()
                .eq(FinVoucherDO::getBookId, book.getId())
                .eq(FinVoucherDO::getPeriodId, finPeriod.getId())
                .eq(FinVoucherDO::getStatus, STATUS_AUDITED));

        BigDecimal incomeAmount = BigDecimal.ZERO;
        BigDecimal expenseAmount = BigDecimal.ZERO;
        for (FinVoucherDO voucher : auditedVouchers) {
            BigDecimal amount = voucherAmount(voucher);
            if (isIncomeVoucher(voucher.getVoucherType())) {
                incomeAmount = incomeAmount.add(amount);
            } else if (isExpenseVoucher(voucher.getVoucherType())) {
                expenseAmount = expenseAmount.add(amount);
            }
        }

        LambdaQueryWrapper<FinApproveTaskDO> pendingWrapper = new LambdaQueryWrapper<FinApproveTaskDO>()
                .eq(FinApproveTaskDO::getTaskStatus, TASK_PENDING)
                .eq(hasEffectiveUser(userId), FinApproveTaskDO::getApproverId, userId);
        if (year != null) {
            pendingWrapper.ge(FinApproveTaskDO::getCreatedAt, yearStart(year))
                    .lt(FinApproveTaskDO::getCreatedAt, yearEndExclusive(year));
        }
        List<FinApproveTaskDO> pendingTasks = finApproveTaskMapper.selectList(pendingWrapper);
        Map<Long, FinApproveInstanceDO> instanceMap = loadInstanceMap(
                pendingTasks.stream().map(FinApproveTaskDO::getInstanceId).collect(Collectors.toSet())
        );
        if (orgId != null) {
            pendingTasks = pendingTasks.stream()
                    .filter(task -> matchesOrg(instanceMap.get(task.getInstanceId()), orgId))
                    .collect(Collectors.toCollection(ArrayList::new));
        }
        long pendingTodoCount = pendingTasks.size();
        long urgentTodoCount = pendingTasks.stream().filter(task -> isUrgent(task, instanceMap.get(task.getInstanceId()))).count();

        HomeStatsRespVO vo = new HomeStatsRespVO();
        vo.setLedgerId(book.getId());
        vo.setPeriodId(finPeriod.getId());
        vo.setIncomeAmount(incomeAmount);
        vo.setExpenseAmount(expenseAmount);
        vo.setAssetAmount(sumAssetAmount(book.getId()));
        vo.setPendingTodoCount(pendingTodoCount);
        vo.setUrgentTodoCount(urgentTodoCount);
        return vo;
    }

    @Override
    public List<HomeTodoRespVO> queryHomeTodos(Long userId, Long orgId, Integer year, Integer limit) {
        int queryLimit = normalizeLimit(limit, DEFAULT_TODO_LIMIT);
        LambdaQueryWrapper<FinApproveTaskDO> taskWrapper = new LambdaQueryWrapper<FinApproveTaskDO>()
                .eq(FinApproveTaskDO::getTaskStatus, TASK_PENDING)
                .orderByDesc(FinApproveTaskDO::getCreatedAt)
                .orderByDesc(FinApproveTaskDO::getId);
        if (hasEffectiveUser(userId)) {
            taskWrapper.eq(FinApproveTaskDO::getApproverId, userId);
        }
        if (year != null) {
            taskWrapper.ge(FinApproveTaskDO::getCreatedAt, yearStart(year))
                    .lt(FinApproveTaskDO::getCreatedAt, yearEndExclusive(year));
        }
        List<FinApproveTaskDO> tasks = finApproveTaskMapper.selectList(taskWrapper);
        if (tasks.isEmpty()) {
            return List.of();
        }
        Map<Long, FinApproveInstanceDO> instanceMap = loadInstanceMap(
                tasks.stream().map(FinApproveTaskDO::getInstanceId).collect(Collectors.toSet())
        );
        if (orgId != null) {
            tasks = tasks.stream()
                    .filter(task -> matchesOrg(instanceMap.get(task.getInstanceId()), orgId))
                    .collect(Collectors.toCollection(ArrayList::new));
        }
        if (tasks.size() > queryLimit) {
            tasks = new ArrayList<>(tasks.subList(0, queryLimit));
        }
        List<HomeTodoRespVO> result = new ArrayList<>();
        for (FinApproveTaskDO task : tasks) {
            FinApproveInstanceDO instance = instanceMap.get(task.getInstanceId());
            HomeTodoRespVO vo = new HomeTodoRespVO();
            vo.setTodoId(task.getId());
            vo.setTodoType(instance == null ? "APPROVAL" : nvlStr(instance.getBizType(), "APPROVAL"));
            vo.setTitle(buildTodoTitle(task, instance));
            vo.setCreateTime(task.getCreatedAt());
            vo.setTaskId(task.getId());
            vo.setInstanceId(task.getInstanceId());
            if (instance != null) {
                vo.setBizType(instance.getBizType());
                vo.setBizId(instance.getBizId());
            }
            vo.setNodeName(task.getNodeName());
            vo.setTaskStatus(task.getTaskStatus());
            vo.setUrgency(isUrgent(task, instance) ? "URGENT" : "NORMAL");
            result.add(vo);
        }
        return result;
    }

    @Override
    public List<HomeTrendRespVO> queryHomeCharts(Long ledgerId, Long orgId, Long periodId, String period, Integer year, Integer months) {
        FinBookDO book = resolveBook(ledgerId, orgId, year);
        FinPeriodDO finPeriod = resolvePeriod(book.getId(), periodId, period, year);
        int monthCount = normalizeMonthCount(months);
        YearMonth endMonth = YearMonth.from(finPeriod.getEndDate());
        YearMonth startMonth = endMonth.minusMonths(monthCount - 1L);
        LocalDate startDate = startMonth.atDay(1);

        List<FinVoucherDO> auditedVouchers = finVoucherMapper.selectList(new LambdaQueryWrapper<FinVoucherDO>()
                .eq(FinVoucherDO::getBookId, book.getId())
                .eq(FinVoucherDO::getStatus, STATUS_AUDITED)
                .ge(FinVoucherDO::getVoucherDate, startDate)
                .le(FinVoucherDO::getVoucherDate, finPeriod.getEndDate()));
        Map<YearMonth, BigDecimal> incomeMap = new LinkedHashMap<>();
        Map<YearMonth, BigDecimal> expenseMap = new LinkedHashMap<>();
        for (FinVoucherDO voucher : auditedVouchers) {
            if (voucher.getVoucherDate() == null) {
                continue;
            }
            YearMonth ym = YearMonth.from(voucher.getVoucherDate());
            BigDecimal amount = voucherAmount(voucher);
            if (isIncomeVoucher(voucher.getVoucherType())) {
                incomeMap.put(ym, nvl(incomeMap.get(ym)).add(amount));
            } else if (isExpenseVoucher(voucher.getVoucherType())) {
                expenseMap.put(ym, nvl(expenseMap.get(ym)).add(amount));
            }
        }
        List<HomeTrendRespVO> result = new ArrayList<>();
        for (int i = 0; i < monthCount; i++) {
            YearMonth ym = startMonth.plusMonths(i);
            HomeTrendRespVO vo = new HomeTrendRespVO();
            vo.setPeriodLabel(ym.toString());
            vo.setIncomeAmount(nvl(incomeMap.get(ym)));
            vo.setExpenseAmount(nvl(expenseMap.get(ym)));
            result.add(vo);
        }
        return result;
    }

    @Override
    public List<HomeAssetDistributionRespVO> queryAssetDistribution(Long ledgerId, Long orgId, Integer year) {
        FinBookDO book = resolveBook(ledgerId, orgId, year);
        Map<Long, String> categoryMap = finAssetCategoryMapper.selectList(new LambdaQueryWrapper<FinAssetCategoryDO>()
                        .orderByAsc(FinAssetCategoryDO::getCategoryCode)
                        .orderByAsc(FinAssetCategoryDO::getId))
                .stream()
                .collect(Collectors.toMap(FinAssetCategoryDO::getId, FinAssetCategoryDO::getCategoryName, (a, b) -> a, LinkedHashMap::new));
        List<FinAssetCardDO> assets = finAssetCardMapper.selectList(new LambdaQueryWrapper<FinAssetCardDO>()
                .eq(FinAssetCardDO::getBookId, book.getId())
                .eq(FinAssetCardDO::getEnableFlag, 1));
        Map<String, BigDecimal> grouped = new LinkedHashMap<>();
        for (FinAssetCardDO asset : assets) {
            String categoryName = categoryMap.getOrDefault(asset.getCategoryId(), "未分类");
            BigDecimal amount = assetAmount(asset);
            grouped.put(categoryName, nvl(grouped.get(categoryName)).add(amount));
        }
        return grouped.entrySet().stream()
                .sorted((a, b) -> b.getValue().compareTo(a.getValue()))
                .map(entry -> {
                    HomeAssetDistributionRespVO vo = new HomeAssetDistributionRespVO();
                    vo.setCategoryName(entry.getKey());
                    vo.setAmount(entry.getValue());
                    return vo;
                }).toList();
    }

    @Override
    public List<HomeRecentVoucherRespVO> queryRecentVouchers(Long ledgerId, Long orgId, Long periodId, String period, Integer year, Integer limit) {
        FinBookDO book = resolveBook(ledgerId, orgId, year);
        FinPeriodDO finPeriod = (periodId != null || StringUtils.hasText(period))
                ? resolvePeriod(book.getId(), periodId, period, year)
                : null;
        int queryLimit = normalizeLimit(limit, DEFAULT_VOUCHER_LIMIT);
        LambdaQueryWrapper<FinVoucherDO> wrapper = new LambdaQueryWrapper<FinVoucherDO>()
                .eq(FinVoucherDO::getBookId, book.getId())
                .orderByDesc(FinVoucherDO::getVoucherDate)
                .orderByDesc(FinVoucherDO::getId);
        if (finPeriod != null) {
            wrapper.eq(FinVoucherDO::getPeriodId, finPeriod.getId());
        }
        List<FinVoucherDO> vouchers = finVoucherMapper.selectList(wrapper);
        if (vouchers.isEmpty()) {
            return List.of();
        }
        if (vouchers.size() > queryLimit) {
            vouchers = new ArrayList<>(vouchers.subList(0, queryLimit));
        }
        Map<Long, String> summaryMap = loadFirstSummary(vouchers.stream().map(FinVoucherDO::getId).collect(Collectors.toSet()));
        List<HomeRecentVoucherRespVO> result = new ArrayList<>();
        for (FinVoucherDO voucher : vouchers) {
            HomeRecentVoucherRespVO vo = new HomeRecentVoucherRespVO();
            vo.setVoucherId(voucher.getId());
            vo.setVoucherNo(voucher.getVoucherNo());
            vo.setVoucherDate(voucher.getVoucherDate());
            vo.setSummary(summaryMap.get(voucher.getId()));
            vo.setAmount(voucherAmount(voucher));
            vo.setDirection(resolveDirection(voucher.getVoucherType()));
            vo.setAuditStatus(voucher.getStatus());
            vo.setVoucherType(voucher.getVoucherType());
            vo.setBizId(voucher.getBizId());
            result.add(vo);
        }
        return result;
    }

    @Override
    public ReportProgressRespVO queryHomeProgress(Long ledgerId, Long orgId, Long periodId, String period, Integer year) {
        FinBookDO book = resolveBook(ledgerId, orgId, year);
        FinPeriodDO finPeriod = resolvePeriod(book.getId(), periodId, period, year);
        return financeReportService.queryReportProgress(book.getId(), finPeriod.getId());
    }

    private BigDecimal sumAssetAmount(Long ledgerId) {
        List<FinAssetCardDO> cards = finAssetCardMapper.selectList(new LambdaQueryWrapper<FinAssetCardDO>()
                .eq(FinAssetCardDO::getBookId, ledgerId)
                .eq(FinAssetCardDO::getEnableFlag, 1));
        BigDecimal amount = BigDecimal.ZERO;
        for (FinAssetCardDO card : cards) {
            amount = amount.add(assetAmount(card));
        }
        return amount;
    }

    private Map<Long, FinApproveInstanceDO> loadInstanceMap(Set<Long> instanceIds) {
        if (instanceIds == null || instanceIds.isEmpty()) {
            return Map.of();
        }
        return finApproveInstanceMapper.selectBatchIds(instanceIds).stream()
                .collect(Collectors.toMap(FinApproveInstanceDO::getId, item -> item, (a, b) -> a, LinkedHashMap::new));
    }

    private Map<Long, String> loadFirstSummary(Set<Long> voucherIds) {
        if (voucherIds == null || voucherIds.isEmpty()) {
            return Map.of();
        }
        List<FinVoucherEntryDO> entries = finVoucherEntryMapper.selectList(new LambdaQueryWrapper<FinVoucherEntryDO>()
                .in(FinVoucherEntryDO::getVoucherId, voucherIds)
                .orderByAsc(FinVoucherEntryDO::getVoucherId)
                .orderByAsc(FinVoucherEntryDO::getLineNo));
        Map<Long, String> summaryMap = new LinkedHashMap<>();
        for (FinVoucherEntryDO entry : entries) {
            summaryMap.putIfAbsent(entry.getVoucherId(), entry.getSummary());
        }
        return summaryMap;
    }

    private FinBookDO resolveBook(Long ledgerId, Long orgId, Integer year) {
        FinBookDO book;
        if (ledgerId != null) {
            book = finBookMapper.selectById(ledgerId);
            if (book == null) {
                throw new IllegalArgumentException("账套不存在");
            }
            return book;
        }
        if (orgId != null) {
            book = finBookMapper.selectOne(new LambdaQueryWrapper<FinBookDO>()
                    .eq(FinBookDO::getOrgId, orgId)
                    .eq(year != null, FinBookDO::getFiscalYear, year)
                    .orderByDesc(FinBookDO::getId)
                    .last("limit 1"));
            if (book != null) {
                return book;
            }
        }
        book = finBookMapper.selectOne(new LambdaQueryWrapper<FinBookDO>()
                .eq(year != null, FinBookDO::getFiscalYear, year)
                .orderByDesc(FinBookDO::getId)
                .last("limit 1"));
        if (book == null) {
            throw new IllegalArgumentException("未找到可用账套");
        }
        return book;
    }

    private FinPeriodDO resolvePeriod(Long ledgerId, Long periodId, String period, Integer year) {
        if (periodId != null) {
            FinPeriodDO periodDO = finPeriodMapper.selectById(periodId);
            if (periodDO == null || !Objects.equals(periodDO.getBookId(), ledgerId)) {
                throw new IllegalArgumentException("会计期间不存在");
            }
            return periodDO;
        }
        if (StringUtils.hasText(period)) {
            Matcher matcher = PERIOD_PATTERN.matcher(period.trim());
            if (!matcher.matches()) {
                throw new IllegalArgumentException("period格式应为yyyy-MM");
            }
            int parsedYear = Integer.parseInt(matcher.group(1));
            int month = Integer.parseInt(matcher.group(2));
            FinPeriodDO periodDO = finPeriodMapper.selectOne(new LambdaQueryWrapper<FinPeriodDO>()
                    .eq(FinPeriodDO::getBookId, ledgerId)
                    .eq(FinPeriodDO::getPeriodYear, parsedYear)
                    .eq(FinPeriodDO::getPeriodNo, month)
                    .last("limit 1"));
            if (periodDO != null) {
                return periodDO;
            }
            throw new IllegalArgumentException("会计期间不存在");
        }
        if (year != null) {
            FinPeriodDO latestInYear = finPeriodMapper.selectOne(new LambdaQueryWrapper<FinPeriodDO>()
                    .eq(FinPeriodDO::getBookId, ledgerId)
                    .eq(FinPeriodDO::getPeriodYear, year)
                    .orderByDesc(FinPeriodDO::getPeriodNo)
                    .last("limit 1"));
            if (latestInYear != null) {
                return latestInYear;
            }
            throw new IllegalArgumentException("会计期间不存在");
        }
        FinPeriodDO latest = finPeriodMapper.selectOne(new LambdaQueryWrapper<FinPeriodDO>()
                .eq(FinPeriodDO::getBookId, ledgerId)
                .orderByDesc(FinPeriodDO::getPeriodYear)
                .orderByDesc(FinPeriodDO::getPeriodNo)
                .last("limit 1"));
        if (latest == null) {
            throw new IllegalArgumentException("账套下不存在会计期间");
        }
        return latest;
    }

    private String buildTodoTitle(FinApproveTaskDO task, FinApproveInstanceDO instance) {
        if (instance != null && StringUtils.hasText(instance.getRemark())) {
            return instance.getRemark().trim();
        }
        if (instance == null) {
            return "瀹℃壒浠诲姟-" + task.getTaskNo();
        }
        String bizType = nvlStr(instance.getBizType(), "BIZ");
        return bizType + "-" + instance.getBizId();
    }

    private boolean isUrgent(FinApproveTaskDO task, FinApproveInstanceDO instance) {
        if (containsUrgentKeyword(task.getNodeName())) {
            return true;
        }
        return instance != null && containsUrgentKeyword(instance.getRemark());
    }

    private boolean containsUrgentKeyword(String value) {
        if (!StringUtils.hasText(value)) {
            return false;
        }
        String normalized = value.trim().toUpperCase(Locale.ROOT);
        return normalized.contains("紧急")
                || normalized.contains("URGENT")
                || normalized.contains("HIGH");
    }

    private LocalDateTime yearStart(Integer year) {
        return LocalDate.of(year, 1, 1).atStartOfDay();
    }

    private LocalDateTime yearEndExclusive(Integer year) {
        return LocalDate.of(year + 1, 1, 1).atStartOfDay();
    }

    private String resolveOrgName(FinBookDO book) {
        if (StringUtils.hasText(book.getOrgCode())) {
            return book.getOrgCode().trim();
        }
        if (StringUtils.hasText(book.getBookName())) {
            return book.getBookName().trim();
        }
        return "组织-" + book.getOrgId();
    }

    private boolean matchesOrg(FinApproveInstanceDO instance, Long orgId) {
        Long bookId = resolveInstanceBookId(instance);
        if (bookId == null) {
            return false;
        }
        FinBookDO book = finBookMapper.selectById(bookId);
        return book != null && Objects.equals(book.getOrgId(), orgId);
    }

    private Long resolveInstanceBookId(FinApproveInstanceDO instance) {
        if (instance == null || instance.getBizId() == null) {
            return null;
        }
        String bizType = nvlStr(instance.getBizType(), "").trim().toUpperCase(Locale.ROOT);
        Long bizId = instance.getBizId();
        if (FinanceVoucherType.TRANSFER.equals(bizType)) {
            FinInternalTransferDO transfer = finInternalTransferMapper.selectById(bizId);
            return transfer == null ? null : transfer.getBookId();
        }
        if (FinanceVoucherType.ASSET_DEPRECIATION.equals(bizType)) {
            FinAssetDepreciationDO depreciation = finAssetDepreciationMapper.selectById(bizId);
            return depreciation == null ? null : depreciation.getBookId();
        }
        if (FinanceVoucherType.ASSET_DISPOSAL.equals(bizType)) {
            FinAssetDisposalDO disposal = finAssetDisposalMapper.selectById(bizId);
            if (disposal == null || disposal.getAssetId() == null) {
                return null;
            }
            FinAssetCardDO asset = finAssetCardMapper.selectById(disposal.getAssetId());
            return asset == null ? null : asset.getBookId();
        }
        if (FinanceVoucherType.CONTRACT_RECEIPT.equals(bizType) || FinanceVoucherType.CONTRACT_PAYMENT.equals(bizType)) {
            FinContractPaymentDO payment = finContractPaymentMapper.selectById(bizId);
            if (payment == null || payment.getContractId() == null) {
                return null;
            }
            FinContractMainDO contract = finContractMainMapper.selectById(payment.getContractId());
            return contract == null ? null : contract.getBookId();
        }
        return null;
    }

    private int normalizeLimit(Integer limit, int defaultValue) {
        if (limit == null || limit <= 0) {
            return defaultValue;
        }
        return Math.min(limit, MAX_LIMIT);
    }

    private int normalizeMonthCount(Integer months) {
        if (months == null || months <= 0) {
            return DEFAULT_CHART_MONTHS;
        }
        return Math.min(months, MAX_CHART_MONTHS);
    }

    private boolean hasEffectiveUser(Long userId) {
        return userId != null && userId > 0;
    }

    private BigDecimal voucherAmount(FinVoucherDO voucher) {
        BigDecimal debit = nvl(voucher.getTotalDebit());
        if (debit.compareTo(BigDecimal.ZERO) > 0) {
            return debit;
        }
        return nvl(voucher.getTotalCredit());
    }

    private BigDecimal assetAmount(FinAssetCardDO asset) {
        BigDecimal net = nvl(asset.getNetValue());
        if (net.compareTo(BigDecimal.ZERO) > 0) {
            return net;
        }
        return nvl(asset.getOriginalValue());
    }

    private String resolveDirection(String voucherType) {
        String normalized = FinanceVoucherType.normalize(voucherType);
        if (isIncomeVoucher(normalized)) {
            return "INCOME";
        }
        if (isExpenseVoucher(normalized)) {
            return "EXPENSE";
        }
        return "UNKNOWN";
    }

    private boolean isIncomeVoucher(String voucherType) {
        return FinanceVoucherType.CONTRACT_RECEIPT.equalsIgnoreCase(FinanceVoucherType.normalize(voucherType));
    }

    private boolean isExpenseVoucher(String voucherType) {
        String normalized = FinanceVoucherType.normalize(voucherType);
        return FinanceVoucherType.CONTRACT_PAYMENT.equalsIgnoreCase(normalized)
                || FinanceVoucherType.ASSET_DEPRECIATION.equalsIgnoreCase(normalized)
                || FinanceVoucherType.ASSET_DISPOSAL.equalsIgnoreCase(normalized);
    }

    private BigDecimal nvl(BigDecimal value) {
        return value == null ? BigDecimal.ZERO : value;
    }

    private String nvlStr(String value, String fallback) {
        return StringUtils.hasText(value) ? value : fallback;
    }
}

