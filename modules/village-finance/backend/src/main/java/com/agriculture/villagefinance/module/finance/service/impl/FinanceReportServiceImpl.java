package com.agriculture.villagefinance.module.finance.service.impl;

import com.agriculture.villagefinance.module.finance.controller.vo.DetailLedgerRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.GeneralLedgerRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.JournalLedgerRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssistBalanceRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.MultiLedgerRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ReportExportRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ReportPrintRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ReportProgressRespVO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinBookDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinSubjectDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinVoucherDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinVoucherEntryDO;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinBookMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinSubjectMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinVoucherEntryMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinVoucherMapper;
import com.agriculture.villagefinance.module.finance.service.FinanceReportService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class FinanceReportServiceImpl implements FinanceReportService {

    private static final String STATUS_AUDITED = "AUDITED";

    private final FinBookMapper finBookMapper;
    private final FinPeriodMapper finPeriodMapper;
    private final FinSubjectMapper finSubjectMapper;
    private final FinVoucherMapper finVoucherMapper;
    private final FinVoucherEntryMapper finVoucherEntryMapper;

    @Override
    public List<GeneralLedgerRespVO> queryGeneralLedger(Long ledgerId, Long periodId, String subjectCode, Boolean includeChild) {
        requireLedger(ledgerId);
        FinPeriodDO period = requirePeriod(periodId, ledgerId);
        List<FinSubjectDO> subjects = loadSubjects(ledgerId, subjectCode, includeChild);
        if (subjects.isEmpty()) {
            return List.of();
        }
        Map<Long, FinVoucherDO> voucherMap = loadAuditedVoucherMap(ledgerId, period.getEndDate());
        if (voucherMap.isEmpty()) {
            return subjects.stream().map(this::zeroGeneralLedger).toList();
        }
        List<FinVoucherEntryDO> entries = loadEntries(voucherMap.keySet(), subjects.stream().map(FinSubjectDO::getId).collect(Collectors.toSet()));
        Map<Long, BigDecimal> openingMap = new HashMap<>();
        Map<Long, BigDecimal> debitMap = new HashMap<>();
        Map<Long, BigDecimal> creditMap = new HashMap<>();
        for (FinVoucherEntryDO entry : entries) {
            FinVoucherDO voucher = voucherMap.get(entry.getVoucherId());
            if (voucher == null) {
                continue;
            }
            Long sid = entry.getSubjectId();
            BigDecimal debit = nvl(entry.getDebitAmount());
            BigDecimal credit = nvl(entry.getCreditAmount());
            if (voucher.getVoucherDate().isBefore(period.getStartDate())) {
                openingMap.put(sid, nvl(openingMap.get(sid)).add(debit).subtract(credit));
            } else {
                debitMap.put(sid, nvl(debitMap.get(sid)).add(debit));
                creditMap.put(sid, nvl(creditMap.get(sid)).add(credit));
            }
        }
        List<GeneralLedgerRespVO> result = new ArrayList<>();
        for (FinSubjectDO subject : subjects) {
            BigDecimal opening = nvl(openingMap.get(subject.getId()));
            BigDecimal debit = nvl(debitMap.get(subject.getId()));
            BigDecimal credit = nvl(creditMap.get(subject.getId()));
            GeneralLedgerRespVO vo = new GeneralLedgerRespVO();
            vo.setSubjectCode(subject.getSubjectCode());
            vo.setSubjectName(subject.getSubjectName());
            vo.setOpeningBalance(opening);
            vo.setDebitAmount(debit);
            vo.setCreditAmount(credit);
            vo.setClosingBalance(opening.add(debit).subtract(credit));
            result.add(vo);
        }
        return result;
    }

    @Override
    public List<DetailLedgerRespVO> queryDetailLedger(Long ledgerId, Long periodId, Long subjectId, LocalDate startDate, LocalDate endDate) {
        requireLedger(ledgerId);
        FinPeriodDO period = requirePeriod(periodId, ledgerId);
        FinSubjectDO subject = requireSubject(subjectId, ledgerId);
        LocalDate queryStart = startDate == null ? period.getStartDate() : startDate;
        LocalDate queryEnd = endDate == null ? period.getEndDate() : endDate;
        if (queryStart.isAfter(queryEnd)) {
            throw new IllegalArgumentException("startDate不能大于endDate");
        }
        Map<Long, FinVoucherDO> voucherMap = loadAuditedVoucherMap(ledgerId, queryEnd);
        if (voucherMap.isEmpty()) {
            return List.of();
        }
        List<FinVoucherEntryDO> entries = new ArrayList<>(finVoucherEntryMapper.selectList(new LambdaQueryWrapper<FinVoucherEntryDO>()
                .in(FinVoucherEntryDO::getVoucherId, voucherMap.keySet())
                .eq(FinVoucherEntryDO::getSubjectId, subject.getId())));
        entries.sort(Comparator.comparing((FinVoucherEntryDO entry) -> voucherMap.get(entry.getVoucherId()).getVoucherDate())
                .thenComparing(entry -> voucherMap.get(entry.getVoucherId()).getVoucherNo())
                .thenComparing(FinVoucherEntryDO::getLineNo));

        BigDecimal opening = BigDecimal.ZERO;
        for (FinVoucherEntryDO entry : entries) {
            FinVoucherDO voucher = voucherMap.get(entry.getVoucherId());
            if (voucher.getVoucherDate().isBefore(queryStart)) {
                opening = opening.add(nvl(entry.getDebitAmount())).subtract(nvl(entry.getCreditAmount()));
            }
        }

        BigDecimal running = opening;
        List<DetailLedgerRespVO> result = new ArrayList<>();
        for (FinVoucherEntryDO entry : entries) {
            FinVoucherDO voucher = voucherMap.get(entry.getVoucherId());
            LocalDate date = voucher.getVoucherDate();
            if (date.isBefore(queryStart) || date.isAfter(queryEnd)) {
                continue;
            }
            BigDecimal debit = nvl(entry.getDebitAmount());
            BigDecimal credit = nvl(entry.getCreditAmount());
            running = running.add(debit).subtract(credit);
            DetailLedgerRespVO vo = new DetailLedgerRespVO();
            vo.setVoucherNo(voucher.getVoucherNo());
            vo.setVoucherDate(date);
            vo.setSummary(entry.getSummary());
            vo.setDebitAmount(debit);
            vo.setCreditAmount(credit);
            vo.setBalance(running);
            result.add(vo);
        }
        return result;
    }

    @Override
    public List<GeneralLedgerRespVO> querySubjectBalance(Long ledgerId, Long periodId) {
        // S2-R5口径冻结：科目余额表与总账同口径（仅AUDITED入账）
        return queryGeneralLedger(ledgerId, periodId, null, false);
    }

    @Override
    public List<JournalLedgerRespVO> queryJournalLedger(Long ledgerId, Long periodId, LocalDate startDate, LocalDate endDate, String keyword) {
        requireLedger(ledgerId);
        FinPeriodDO period = requirePeriod(periodId, ledgerId);
        LocalDate queryStart = startDate == null ? period.getStartDate() : startDate;
        LocalDate queryEnd = endDate == null ? period.getEndDate() : endDate;
        if (queryStart.isAfter(queryEnd)) {
            throw new IllegalArgumentException("startDate不能大于endDate");
        }
        List<FinVoucherDO> vouchers = loadAuditedVouchers(ledgerId, queryEnd).stream()
                .filter(voucher -> !voucher.getVoucherDate().isBefore(queryStart))
                .filter(voucher -> !voucher.getVoucherDate().isAfter(queryEnd))
                .toList();
        if (vouchers.isEmpty()) {
            return List.of();
        }
        Set<Long> voucherIds = vouchers.stream().map(FinVoucherDO::getId).collect(Collectors.toSet());
        Map<Long, String> firstSummaryMap = loadFirstEntrySummary(voucherIds);
        Map<Long, BigDecimal> amountMap = loadVoucherAmountMap(voucherIds);
        List<JournalLedgerRespVO> result = new ArrayList<>();
        for (FinVoucherDO voucher : vouchers) {
            String summary = firstSummaryMap.get(voucher.getId());
            if (StringUtils.hasText(keyword)) {
                String kw = keyword.trim();
                String merged = (summary == null ? "" : summary) + "|" + (voucher.getVoucherNo() == null ? "" : voucher.getVoucherNo());
                if (!merged.contains(kw)) {
                    continue;
                }
            }
            JournalLedgerRespVO vo = new JournalLedgerRespVO();
            vo.setVoucherNo(voucher.getVoucherNo());
            vo.setVoucherDate(voucher.getVoucherDate());
            vo.setSummary(summary);
            BigDecimal amount = nvl(voucher.getTotalDebit());
            if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                amount = nvl(amountMap.get(voucher.getId()));
            }
            vo.setAmount(amount);
            result.add(vo);
        }
        return result;
    }

    @Override
    public List<AssistBalanceRespVO> queryAssistBalance(Long ledgerId, Long periodId, String assistTypeId) {
        requireLedger(ledgerId);
        FinPeriodDO period = requirePeriod(periodId, ledgerId);
        Map<Long, FinVoucherDO> voucherMap = loadAuditedVoucherMap(ledgerId, period.getEndDate());
        if (voucherMap.isEmpty()) {
            return List.of();
        }
        List<FinVoucherEntryDO> entries = finVoucherEntryMapper.selectList(new LambdaQueryWrapper<FinVoucherEntryDO>()
                .in(FinVoucherEntryDO::getVoucherId, voucherMap.keySet())
                .isNotNull(FinVoucherEntryDO::getAuxType));
        Map<String, BigDecimal> openingMap = new HashMap<>();
        Map<String, BigDecimal> debitMap = new HashMap<>();
        Map<String, BigDecimal> creditMap = new HashMap<>();
        for (FinVoucherEntryDO entry : entries) {
            if (StringUtils.hasText(assistTypeId)
                    && !assistTypeId.trim().equalsIgnoreCase(entry.getAuxType() == null ? "" : entry.getAuxType())) {
                continue;
            }
            FinVoucherDO voucher = voucherMap.get(entry.getVoucherId());
            if (voucher == null) {
                continue;
            }
            String itemName = assistItemName(entry);
            BigDecimal debit = nvl(entry.getDebitAmount());
            BigDecimal credit = nvl(entry.getCreditAmount());
            if (voucher.getVoucherDate().isBefore(period.getStartDate())) {
                openingMap.put(itemName, nvl(openingMap.get(itemName)).add(debit).subtract(credit));
            } else {
                debitMap.put(itemName, nvl(debitMap.get(itemName)).add(debit));
                creditMap.put(itemName, nvl(creditMap.get(itemName)).add(credit));
            }
        }
        List<String> itemNames = openingMap.keySet().stream().collect(Collectors.toCollection(ArrayList::new));
        for (String key : debitMap.keySet()) {
            if (!itemNames.contains(key)) {
                itemNames.add(key);
            }
        }
        for (String key : creditMap.keySet()) {
            if (!itemNames.contains(key)) {
                itemNames.add(key);
            }
        }
        itemNames.sort(String::compareTo);
        List<AssistBalanceRespVO> result = new ArrayList<>();
        for (String itemName : itemNames) {
            AssistBalanceRespVO vo = new AssistBalanceRespVO();
            BigDecimal opening = nvl(openingMap.get(itemName));
            BigDecimal debit = nvl(debitMap.get(itemName));
            BigDecimal credit = nvl(creditMap.get(itemName));
            vo.setItemName(itemName);
            vo.setOpeningBalance(opening);
            vo.setDebitAmount(debit);
            vo.setCreditAmount(credit);
            vo.setClosingBalance(opening.add(debit).subtract(credit));
            result.add(vo);
        }
        return result;
    }

    @Override
    public List<MultiLedgerRespVO> queryMultiLedger(Long ledgerId, Long periodId, String subjectGroup) {
        requireLedger(ledgerId);
        FinPeriodDO period = requirePeriod(periodId, ledgerId);
        Map<Long, FinSubjectDO> subjectMap = loadLedgerSubjectMap(ledgerId);
        Map<Long, FinVoucherDO> voucherMap = loadAuditedVoucherMap(ledgerId, period.getEndDate());
        if (voucherMap.isEmpty()) {
            return List.of();
        }
        List<FinVoucherEntryDO> entries = finVoucherEntryMapper.selectList(new LambdaQueryWrapper<FinVoucherEntryDO>()
                .in(FinVoucherEntryDO::getVoucherId, voucherMap.keySet())
                .orderByAsc(FinVoucherEntryDO::getVoucherId)
                .orderByAsc(FinVoucherEntryDO::getLineNo));
        Map<String, BigDecimal> columnMap = new LinkedHashMap<>();
        for (FinVoucherEntryDO entry : entries) {
            FinVoucherDO voucher = voucherMap.get(entry.getVoucherId());
            if (voucher == null || voucher.getVoucherDate().isBefore(period.getStartDate())) {
                continue;
            }
            FinSubjectDO subject = subjectMap.get(entry.getSubjectId());
            String columnName = subject == null ? "UNKNOWN" : subject.getSubjectName();
            if (StringUtils.hasText(subjectGroup)) {
                String group = subjectGroup.trim();
                String code = subject == null ? "" : String.valueOf(subject.getSubjectCode());
                String name = subject == null ? "" : String.valueOf(subject.getSubjectName());
                if (!code.startsWith(group) && !name.contains(group)) {
                    continue;
                }
            }
            BigDecimal amount = nvl(entry.getDebitAmount()).subtract(nvl(entry.getCreditAmount()));
            columnMap.put(columnName, nvl(columnMap.get(columnName)).add(amount));
        }
        return columnMap.entrySet().stream().map(item -> {
            MultiLedgerRespVO vo = new MultiLedgerRespVO();
            vo.setColumnName(item.getKey());
            vo.setAmount(item.getValue());
            return vo;
        }).toList();
    }

    @Override
    public ReportProgressRespVO queryReportProgress(Long ledgerId, Long periodId) {
        requireLedger(ledgerId);
        requirePeriod(periodId, ledgerId);
        long voucherTotal = finVoucherMapper.selectCount(new LambdaQueryWrapper<FinVoucherDO>()
                .eq(FinVoucherDO::getBookId, ledgerId)
                .eq(FinVoucherDO::getPeriodId, periodId));
        long auditedTotal = finVoucherMapper.selectCount(new LambdaQueryWrapper<FinVoucherDO>()
                .eq(FinVoucherDO::getBookId, ledgerId)
                .eq(FinVoucherDO::getPeriodId, periodId)
                .eq(FinVoucherDO::getStatus, STATUS_AUDITED));
        ReportProgressRespVO vo = new ReportProgressRespVO();
        vo.setVoucherTotal(voucherTotal);
        vo.setAuditedTotal(auditedTotal);
        if (voucherTotal == 0) {
            vo.setPercent("0.00%");
        } else {
            BigDecimal percent = BigDecimal.valueOf(auditedTotal).multiply(new BigDecimal("100"))
                    .divide(BigDecimal.valueOf(voucherTotal), 2, java.math.RoundingMode.HALF_UP);
            vo.setPercent(percent.toPlainString() + "%");
        }
        return vo;
    }

    @Override
    public ReportExportRespVO exportReport(String reportType, Long periodId, String format) {
        if (!StringUtils.hasText(reportType) || periodId == null) {
            throw new IllegalArgumentException("reportType和periodId不能为空");
        }
        String fmt = StringUtils.hasText(format) ? format.trim().toLowerCase(Locale.ROOT) : "pdf";
        ReportExportRespVO vo = new ReportExportRespVO();
        vo.setFileUrl("/api/village-finance/report/export/file?reportType=" + reportType.trim()
                + "&periodId=" + periodId + "&format=" + fmt);
        return vo;
    }

    @Override
    public ReportPrintRespVO printReport(String reportType, Long periodId) {
        if (!StringUtils.hasText(reportType) || periodId == null) {
            throw new IllegalArgumentException("reportType和periodId不能为空");
        }
        ReportPrintRespVO vo = new ReportPrintRespVO();
        vo.setPrintUrl("/api/village-finance/report/print/view?reportType=" + reportType.trim()
                + "&periodId=" + periodId);
        return vo;
    }

    private List<FinSubjectDO> loadSubjects(Long ledgerId, String subjectCode, Boolean includeChild) {
        LambdaQueryWrapper<FinSubjectDO> wrapper = new LambdaQueryWrapper<FinSubjectDO>()
                .eq(FinSubjectDO::getBookId, ledgerId)
                .eq(FinSubjectDO::getEnableFlag, 1)
                .orderByAsc(FinSubjectDO::getSubjectCode);
        if (!StringUtils.hasText(subjectCode)) {
            return finSubjectMapper.selectList(wrapper);
        }
        FinSubjectDO root = finSubjectMapper.selectOne(new LambdaQueryWrapper<FinSubjectDO>()
                .eq(FinSubjectDO::getBookId, ledgerId)
                .eq(FinSubjectDO::getSubjectCode, subjectCode.trim())
                .last("limit 1"));
        if (root == null || !Objects.equals(root.getEnableFlag(), 1)) {
            throw new IllegalArgumentException("会计科目不存在");
        }
        if (Boolean.TRUE.equals(includeChild)) {
            wrapper.likeRight(FinSubjectDO::getSubjectCode, root.getSubjectCode());
            return finSubjectMapper.selectList(wrapper);
        }
        return List.of(root);
    }

    private Map<Long, FinVoucherDO> loadAuditedVoucherMap(Long ledgerId, LocalDate endDate) {
        List<FinVoucherDO> vouchers = loadAuditedVouchers(ledgerId, endDate);
        return vouchers.stream().collect(Collectors.toMap(FinVoucherDO::getId, item -> item, (a, b) -> a, LinkedHashMap::new));
    }

    private List<FinVoucherDO> loadAuditedVouchers(Long ledgerId, LocalDate endDate) {
        return finVoucherMapper.selectList(new LambdaQueryWrapper<FinVoucherDO>()
                        .eq(FinVoucherDO::getBookId, ledgerId)
                        .eq(FinVoucherDO::getStatus, STATUS_AUDITED)
                        .le(FinVoucherDO::getVoucherDate, endDate)
                        .orderByAsc(FinVoucherDO::getVoucherDate)
                        .orderByAsc(FinVoucherDO::getId)).stream()
                // Double-check口径，避免Mapper mock或后续变更导致DRAFT误入账
                .filter(voucher -> STATUS_AUDITED.equalsIgnoreCase(voucher.getStatus()))
                .toList();
    }

    private Map<Long, FinSubjectDO> loadLedgerSubjectMap(Long ledgerId) {
        return finSubjectMapper.selectList(new LambdaQueryWrapper<FinSubjectDO>()
                        .eq(FinSubjectDO::getBookId, ledgerId))
                .stream()
                .collect(Collectors.toMap(FinSubjectDO::getId, item -> item, (a, b) -> a, LinkedHashMap::new));
    }

    private List<FinVoucherEntryDO> loadEntries(Set<Long> voucherIds, Set<Long> subjectIds) {
        if (voucherIds.isEmpty() || subjectIds.isEmpty()) {
            return List.of();
        }
        return finVoucherEntryMapper.selectList(new LambdaQueryWrapper<FinVoucherEntryDO>()
                .in(FinVoucherEntryDO::getVoucherId, voucherIds)
                .in(FinVoucherEntryDO::getSubjectId, subjectIds));
    }

    private Map<Long, String> loadFirstEntrySummary(Set<Long> voucherIds) {
        if (voucherIds.isEmpty()) {
            return Map.of();
        }
        List<FinVoucherEntryDO> entries = finVoucherEntryMapper.selectList(new LambdaQueryWrapper<FinVoucherEntryDO>()
                .in(FinVoucherEntryDO::getVoucherId, voucherIds)
                .orderByAsc(FinVoucherEntryDO::getVoucherId)
                .orderByAsc(FinVoucherEntryDO::getLineNo));
        Map<Long, String> summaryMap = new HashMap<>();
        for (FinVoucherEntryDO entry : entries) {
            if (!summaryMap.containsKey(entry.getVoucherId())) {
                summaryMap.put(entry.getVoucherId(), entry.getSummary());
            }
        }
        return summaryMap;
    }

    private Map<Long, BigDecimal> loadVoucherAmountMap(Set<Long> voucherIds) {
        if (voucherIds.isEmpty()) {
            return Map.of();
        }
        List<FinVoucherEntryDO> entries = finVoucherEntryMapper.selectList(new LambdaQueryWrapper<FinVoucherEntryDO>()
                .in(FinVoucherEntryDO::getVoucherId, voucherIds));
        Map<Long, BigDecimal> amountMap = new HashMap<>();
        for (FinVoucherEntryDO entry : entries) {
            amountMap.put(entry.getVoucherId(), nvl(amountMap.get(entry.getVoucherId())).add(nvl(entry.getDebitAmount())));
        }
        return amountMap;
    }

    private String assistItemName(FinVoucherEntryDO entry) {
        if (entry.getAuxId() == null) {
            return entry.getAuxType();
        }
        return entry.getAuxType() + ":" + entry.getAuxId();
    }

    private GeneralLedgerRespVO zeroGeneralLedger(FinSubjectDO subject) {
        GeneralLedgerRespVO vo = new GeneralLedgerRespVO();
        vo.setSubjectCode(subject.getSubjectCode());
        vo.setSubjectName(subject.getSubjectName());
        vo.setOpeningBalance(BigDecimal.ZERO);
        vo.setDebitAmount(BigDecimal.ZERO);
        vo.setCreditAmount(BigDecimal.ZERO);
        vo.setClosingBalance(BigDecimal.ZERO);
        return vo;
    }

    private FinBookDO requireLedger(Long ledgerId) {
        FinBookDO book = finBookMapper.selectById(ledgerId);
        if (book == null) {
            throw new IllegalArgumentException("账套不存在");
        }
        return book;
    }

    private FinPeriodDO requirePeriod(Long periodId, Long ledgerId) {
        FinPeriodDO period = finPeriodMapper.selectById(periodId);
        if (period == null || !Objects.equals(period.getBookId(), ledgerId)) {
            throw new IllegalArgumentException("会计期间不存在");
        }
        return period;
    }

    private FinSubjectDO requireSubject(Long subjectId, Long ledgerId) {
        FinSubjectDO subject = finSubjectMapper.selectById(subjectId);
        if (subject == null || !Objects.equals(subject.getBookId(), ledgerId)) {
            throw new IllegalArgumentException("会计科目不存在");
        }
        return subject;
    }

    private BigDecimal nvl(BigDecimal value) {
        return value == null ? BigDecimal.ZERO : value;
    }
}
