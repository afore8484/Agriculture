package com.agriculture.villagefinance.module.finance.service;

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
import com.agriculture.villagefinance.module.finance.service.impl.FinanceReportServiceImpl;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class FinanceReportServiceImplTest {

    @Test
    void shouldQuerySubjectBalanceByLedgerPeriod() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        FinVoucherEntryMapper entryMapper = mock(FinVoucherEntryMapper.class);

        mockLedger(bookMapper);
        mockPeriod(periodMapper, "OPEN");
        FinSubjectDO subject = subject(11L, "1001", "库存现金");
        when(subjectMapper.selectList(any())).thenReturn(List.of(subject));
        when(voucherMapper.selectList(any())).thenReturn(List.of(voucher(100L, "V001", LocalDate.of(2026, 3, 10), "AUDITED")));
        when(entryMapper.selectList(any())).thenReturn(List.of(entry(100L, 11L, new BigDecimal("15"), BigDecimal.ZERO, "余额表")));

        FinanceReportService service = service(bookMapper, periodMapper, subjectMapper, voucherMapper, entryMapper);
        List<GeneralLedgerRespVO> rows = service.querySubjectBalance(1L, 3L);

        assertEquals(1, rows.size());
        assertEquals("1001", rows.get(0).getSubjectCode());
        assertEquals(new BigDecimal("15"), rows.get(0).getClosingBalance());
    }

    @Test
    void shouldQueryGeneralLedgerByLedgerPeriodSubject() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        FinVoucherEntryMapper entryMapper = mock(FinVoucherEntryMapper.class);

        mockLedger(bookMapper);
        mockPeriod(periodMapper, "OPEN");
        FinSubjectDO subject = subject(11L, "1001", "库存现金");
        when(subjectMapper.selectOne(any())).thenReturn(subject);
        when(subjectMapper.selectList(any())).thenReturn(List.of(subject));
        when(voucherMapper.selectList(any())).thenReturn(List.of(voucher(100L, "V001", LocalDate.of(2026, 3, 10), "AUDITED")));
        when(entryMapper.selectList(any())).thenReturn(List.of(entry(100L, 11L, new BigDecimal("20"), BigDecimal.ZERO, "收入")));

        FinanceReportService service = service(bookMapper, periodMapper, subjectMapper, voucherMapper, entryMapper);
        List<GeneralLedgerRespVO> rows = service.queryGeneralLedger(1L, 3L, "1001", false);

        assertEquals(1, rows.size());
        assertEquals(new BigDecimal("20"), rows.get(0).getDebitAmount());
    }

    @Test
    void shouldQueryDetailLedgerByLedgerPeriodSubject() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        FinVoucherEntryMapper entryMapper = mock(FinVoucherEntryMapper.class);

        mockLedger(bookMapper);
        mockPeriod(periodMapper, "OPEN");
        when(subjectMapper.selectById(11L)).thenReturn(subject(11L, "1001", "库存现金"));
        when(voucherMapper.selectList(any())).thenReturn(List.of(voucher(100L, "V001", LocalDate.of(2026, 3, 10), "AUDITED")));
        when(entryMapper.selectList(any())).thenReturn(List.of(entry(100L, 11L, new BigDecimal("30"), BigDecimal.ZERO, "明细")));

        FinanceReportService service = service(bookMapper, periodMapper, subjectMapper, voucherMapper, entryMapper);
        List<DetailLedgerRespVO> rows = service.queryDetailLedger(1L, 3L, 11L, null, null);

        assertEquals(1, rows.size());
        assertEquals("V001", rows.get(0).getVoucherNo());
        assertEquals(new BigDecimal("30"), rows.get(0).getBalance());
    }

    @Test
    void shouldQueryJournalLedgerByLedgerPeriodDateRange() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        FinVoucherEntryMapper entryMapper = mock(FinVoucherEntryMapper.class);

        mockLedger(bookMapper);
        mockPeriod(periodMapper, "OPEN");
        when(voucherMapper.selectList(any())).thenReturn(List.of(
                voucher(100L, "V001", LocalDate.of(2026, 3, 10), "AUDITED"),
                voucher(101L, "V002", LocalDate.of(2026, 3, 11), "AUDITED")
        ));
        when(entryMapper.selectList(any())).thenReturn(List.of(
                entry(100L, 11L, new BigDecimal("30"), BigDecimal.ZERO, "序时账A"),
                entry(101L, 11L, new BigDecimal("20"), BigDecimal.ZERO, "序时账B")
        ));

        FinanceReportService service = service(bookMapper, periodMapper, subjectMapper, voucherMapper, entryMapper);
        List<JournalLedgerRespVO> rows = service.queryJournalLedger(
                1L, 3L, LocalDate.of(2026, 3, 10), LocalDate.of(2026, 3, 10), null
        );

        assertEquals(1, rows.size());
        assertEquals("V001", rows.get(0).getVoucherNo());
        assertEquals(new BigDecimal("30"), rows.get(0).getAmount());
    }

    @Test
    void shouldRespectAuditedOnlyRule() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        FinVoucherEntryMapper entryMapper = mock(FinVoucherEntryMapper.class);

        mockLedger(bookMapper);
        mockPeriod(periodMapper, "OPEN");
        when(voucherMapper.selectList(any())).thenReturn(List.of(
                voucher(100L, "V001", LocalDate.of(2026, 3, 10), "AUDITED"),
                voucher(101L, "V002", LocalDate.of(2026, 3, 10), "DRAFT")
        ));
        when(entryMapper.selectList(any())).thenReturn(List.of(
                entry(100L, 11L, new BigDecimal("30"), BigDecimal.ZERO, "审核凭证"),
                entry(101L, 11L, new BigDecimal("999"), BigDecimal.ZERO, "草稿凭证")
        ));

        FinanceReportService service = service(bookMapper, periodMapper, subjectMapper, voucherMapper, entryMapper);
        List<JournalLedgerRespVO> rows = service.queryJournalLedger(1L, 3L, null, null, null);

        assertEquals(1, rows.size());
        assertEquals("V001", rows.get(0).getVoucherNo());
    }

    @Test
    void shouldExcludeDeletedOrInvalidVoucherEntriesIfRequiredByBaseline() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        FinVoucherEntryMapper entryMapper = mock(FinVoucherEntryMapper.class);

        mockLedger(bookMapper);
        mockPeriod(periodMapper, "OPEN");
        when(subjectMapper.selectById(11L)).thenReturn(subject(11L, "1001", "库存现金"));
        // DRAFT should be excluded by service query condition
        when(voucherMapper.selectList(any())).thenReturn(List.of(voucher(100L, "V001", LocalDate.of(2026, 3, 10), "AUDITED")));
        when(entryMapper.selectList(any())).thenReturn(List.of(entry(100L, 11L, new BigDecimal("40"), BigDecimal.ZERO, "仅审核")));

        FinanceReportService service = service(bookMapper, periodMapper, subjectMapper, voucherMapper, entryMapper);
        List<DetailLedgerRespVO> rows = service.queryDetailLedger(1L, 3L, 11L, null, null);

        assertEquals(1, rows.size());
        assertEquals(new BigDecimal("40"), rows.get(0).getDebitAmount());
    }

    @Test
    void shouldRespectClosedPeriodReadability() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        FinVoucherEntryMapper entryMapper = mock(FinVoucherEntryMapper.class);

        mockLedger(bookMapper);
        mockPeriod(periodMapper, "CLOSED");
        when(subjectMapper.selectById(11L)).thenReturn(subject(11L, "1001", "库存现金"));
        when(voucherMapper.selectList(any())).thenReturn(List.of(voucher(100L, "V001", LocalDate.of(2026, 3, 10), "AUDITED")));
        when(entryMapper.selectList(any())).thenReturn(List.of(entry(100L, 11L, new BigDecimal("10"), BigDecimal.ZERO, "closed-read")));

        FinanceReportService service = service(bookMapper, periodMapper, subjectMapper, voucherMapper, entryMapper);
        List<DetailLedgerRespVO> rows = service.queryDetailLedger(1L, 3L, 11L, null, null);

        assertEquals(1, rows.size());
    }

    @Test
    void shouldCalculateDebitCreditAndBalanceByBaselineRule() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        FinVoucherEntryMapper entryMapper = mock(FinVoucherEntryMapper.class);

        mockLedger(bookMapper);
        mockPeriod(periodMapper, "OPEN");
        FinSubjectDO subject = subject(11L, "1001", "库存现金");
        when(subjectMapper.selectOne(any())).thenReturn(subject);
        when(subjectMapper.selectList(any())).thenReturn(List.of(subject));
        when(voucherMapper.selectList(any())).thenReturn(List.of(
                voucher(99L, "V000", LocalDate.of(2026, 2, 20), "AUDITED"),
                voucher(100L, "V001", LocalDate.of(2026, 3, 10), "AUDITED")
        ));
        when(entryMapper.selectList(any())).thenReturn(List.of(
                entry(99L, 11L, new BigDecimal("100"), BigDecimal.ZERO, "期初沉淀"),
                entry(100L, 11L, new BigDecimal("20"), new BigDecimal("5"), "本期发生")
        ));

        FinanceReportService service = service(bookMapper, periodMapper, subjectMapper, voucherMapper, entryMapper);
        List<GeneralLedgerRespVO> rows = service.queryGeneralLedger(1L, 3L, "1001", false);

        assertEquals(1, rows.size());
        assertEquals(new BigDecimal("100"), rows.get(0).getOpeningBalance());
        assertEquals(new BigDecimal("20"), rows.get(0).getDebitAmount());
        assertEquals(new BigDecimal("5"), rows.get(0).getCreditAmount());
        assertEquals(new BigDecimal("115"), rows.get(0).getClosingBalance());
    }

    @Test
    void shouldKeepBalanceCalculationConsistentWithGeneralLedger() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        FinVoucherEntryMapper entryMapper = mock(FinVoucherEntryMapper.class);

        mockLedger(bookMapper);
        mockPeriod(periodMapper, "OPEN");
        FinSubjectDO subject = subject(11L, "1001", "库存现金");
        when(subjectMapper.selectList(any())).thenReturn(List.of(subject));
        when(voucherMapper.selectList(any())).thenReturn(List.of(
                voucher(99L, "V000", LocalDate.of(2026, 2, 20), "AUDITED"),
                voucher(100L, "V001", LocalDate.of(2026, 3, 10), "AUDITED")
        ));
        when(entryMapper.selectList(any())).thenReturn(List.of(
                entry(99L, 11L, new BigDecimal("100"), BigDecimal.ZERO, "期初"),
                entry(100L, 11L, new BigDecimal("20"), new BigDecimal("5"), "本期")
        ));

        FinanceReportService service = service(bookMapper, periodMapper, subjectMapper, voucherMapper, entryMapper);
        List<GeneralLedgerRespVO> generalRows = service.queryGeneralLedger(1L, 3L, null, false);
        List<GeneralLedgerRespVO> balanceRows = service.querySubjectBalance(1L, 3L);

        assertEquals(generalRows.size(), balanceRows.size());
        assertEquals(generalRows.get(0).getClosingBalance(), balanceRows.get(0).getClosingBalance());
        assertEquals(generalRows.get(0).getDebitAmount(), balanceRows.get(0).getDebitAmount());
        assertEquals(generalRows.get(0).getCreditAmount(), balanceRows.get(0).getCreditAmount());
    }

    @Test
    void shouldQueryAssistBalanceMinimal() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        FinVoucherEntryMapper entryMapper = mock(FinVoucherEntryMapper.class);

        mockLedger(bookMapper);
        mockPeriod(periodMapper, "OPEN");
        when(voucherMapper.selectList(any())).thenReturn(List.of(voucher(100L, "V001", LocalDate.of(2026, 3, 10), "AUDITED")));
        FinVoucherEntryDO e = entry(100L, 11L, new BigDecimal("8"), BigDecimal.ZERO, "辅助");
        e.setAuxType("CUSTOMER");
        e.setAuxId(2001L);
        when(entryMapper.selectList(any())).thenReturn(List.of(e));

        FinanceReportService service = service(bookMapper, periodMapper, subjectMapper, voucherMapper, entryMapper);
        List<AssistBalanceRespVO> rows = service.queryAssistBalance(1L, 3L, "CUSTOMER");

        assertEquals(1, rows.size());
        assertEquals("CUSTOMER:2001", rows.get(0).getItemName());
        assertEquals(new BigDecimal("8"), rows.get(0).getClosingBalance());
    }

    @Test
    void shouldQueryMultiLedgerMinimal() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        FinVoucherEntryMapper entryMapper = mock(FinVoucherEntryMapper.class);

        mockLedger(bookMapper);
        mockPeriod(periodMapper, "OPEN");
        when(subjectMapper.selectList(any())).thenReturn(List.of(subject(11L, "1001", "库存现金")));
        when(voucherMapper.selectList(any())).thenReturn(List.of(voucher(100L, "V001", LocalDate.of(2026, 3, 10), "AUDITED")));
        when(entryMapper.selectList(any())).thenReturn(List.of(entry(100L, 11L, new BigDecimal("12"), new BigDecimal("2"), "多栏")));

        FinanceReportService service = service(bookMapper, periodMapper, subjectMapper, voucherMapper, entryMapper);
        List<MultiLedgerRespVO> rows = service.queryMultiLedger(1L, 3L, "1001");

        assertEquals(1, rows.size());
        assertEquals("库存现金", rows.get(0).getColumnName());
        assertEquals(new BigDecimal("10"), rows.get(0).getAmount());
    }

    @Test
    void shouldSupportReportCenterQueryExportPrintMinimalChain() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        FinVoucherEntryMapper entryMapper = mock(FinVoucherEntryMapper.class);

        mockLedger(bookMapper);
        mockPeriod(periodMapper, "OPEN");
        when(voucherMapper.selectCount(any())).thenReturn(10L, 6L);

        FinanceReportService service = service(bookMapper, periodMapper, subjectMapper, voucherMapper, entryMapper);
        ReportProgressRespVO progress = service.queryReportProgress(1L, 3L);
        ReportExportRespVO export = service.exportReport("progress", 3L, "xlsx");
        ReportPrintRespVO print = service.printReport("progress", 3L);

        assertEquals(10L, progress.getVoucherTotal());
        assertEquals(6L, progress.getAuditedTotal());
        assertEquals("60.00%", progress.getPercent());
        assertEquals("/api/village-finance/report/export/file?reportType=progress&periodId=3&format=xlsx", export.getFileUrl());
        assertEquals("/api/village-finance/report/print/view?reportType=progress&periodId=3", print.getPrintUrl());
    }

    @Test
    void shouldRejectInvalidDateRangeForDetailLedger() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);

        mockLedger(bookMapper);
        mockPeriod(periodMapper, "OPEN");
        when(subjectMapper.selectById(11L)).thenReturn(subject(11L, "1001", "库存现金"));

        FinanceReportService service = service(
                bookMapper, periodMapper, subjectMapper,
                mock(FinVoucherMapper.class), mock(FinVoucherEntryMapper.class)
        );

        assertThrows(IllegalArgumentException.class, () ->
                service.queryDetailLedger(1L, 3L, 11L, LocalDate.of(2026, 3, 31), LocalDate.of(2026, 3, 1)));
    }

    private static FinanceReportService service(FinBookMapper bookMapper,
                                                FinPeriodMapper periodMapper,
                                                FinSubjectMapper subjectMapper,
                                                FinVoucherMapper voucherMapper,
                                                FinVoucherEntryMapper entryMapper) {
        return new FinanceReportServiceImpl(bookMapper, periodMapper, subjectMapper, voucherMapper, entryMapper);
    }

    private static void mockLedger(FinBookMapper bookMapper) {
        FinBookDO book = new FinBookDO();
        book.setId(1L);
        when(bookMapper.selectById(1L)).thenReturn(book);
    }

    private static void mockPeriod(FinPeriodMapper periodMapper, String closeStatus) {
        FinPeriodDO period = new FinPeriodDO();
        period.setId(3L);
        period.setBookId(1L);
        period.setStartDate(LocalDate.of(2026, 3, 1));
        period.setEndDate(LocalDate.of(2026, 3, 31));
        period.setCloseStatus(closeStatus);
        when(periodMapper.selectById(3L)).thenReturn(period);
    }

    private static FinSubjectDO subject(Long id, String code, String name) {
        FinSubjectDO subject = new FinSubjectDO();
        subject.setId(id);
        subject.setBookId(1L);
        subject.setSubjectCode(code);
        subject.setSubjectName(name);
        subject.setEnableFlag(1);
        return subject;
    }

    private static FinVoucherDO voucher(Long id, String no, LocalDate date, String status) {
        FinVoucherDO voucher = new FinVoucherDO();
        voucher.setId(id);
        voucher.setBookId(1L);
        voucher.setPeriodId(3L);
        voucher.setVoucherNo(no);
        voucher.setVoucherDate(date);
        voucher.setStatus(status);
        return voucher;
    }

    private static FinVoucherEntryDO entry(Long voucherId, Long subjectId, BigDecimal debit, BigDecimal credit, String summary) {
        FinVoucherEntryDO entry = new FinVoucherEntryDO();
        entry.setVoucherId(voucherId);
        entry.setSubjectId(subjectId);
        entry.setLineNo(1);
        entry.setDebitAmount(debit);
        entry.setCreditAmount(credit);
        entry.setSummary(summary);
        return entry;
    }
}
