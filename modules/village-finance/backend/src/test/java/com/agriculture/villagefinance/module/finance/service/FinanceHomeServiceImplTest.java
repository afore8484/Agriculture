package com.agriculture.villagefinance.module.finance.service;

import com.agriculture.villagefinance.module.finance.controller.vo.HomeRecentVoucherRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeStatsRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeTodoRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeTrendRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ReportProgressRespVO;
import com.agriculture.villagefinance.module.finance.constant.FinanceVoucherType;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinApproveInstanceDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinApproveTaskDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinAssetCardDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinBookDO;
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
import com.agriculture.villagefinance.module.finance.service.impl.FinanceHomeServiceImpl;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class FinanceHomeServiceImplTest {

    @Test
    void shouldQueryHomeStatsAndCharts() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        FinVoucherEntryMapper voucherEntryMapper = mock(FinVoucherEntryMapper.class);
        FinAssetCardMapper assetCardMapper = mock(FinAssetCardMapper.class);
        FinApproveTaskMapper taskMapper = mock(FinApproveTaskMapper.class);
        FinApproveInstanceMapper instanceMapper = mock(FinApproveInstanceMapper.class);

        when(bookMapper.selectById(1L)).thenReturn(book());
        when(periodMapper.selectById(3L)).thenReturn(period());
        when(voucherMapper.selectList(any())).thenReturn(List.of(
                voucher(100L, FinanceVoucherType.CONTRACT_RECEIPT, new BigDecimal("120.00"), LocalDate.of(2026, 3, 10), "AUDITED"),
                voucher(101L, FinanceVoucherType.CONTRACT_PAYMENT, new BigDecimal("30.00"), LocalDate.of(2026, 3, 11), "AUDITED")
        ));
        when(assetCardMapper.selectList(any())).thenReturn(List.of(
                asset(new BigDecimal("1000.00"), null),
                asset(null, new BigDecimal("200.00"))
        ));
        when(taskMapper.selectCount(any())).thenReturn(2L);
        when(taskMapper.selectList(any())).thenReturn(List.of(
                task(11L, 201L, "PENDING", "紧急处理", 9L),
                task(12L, 202L, "PENDING", "常规处理", 9L)
        ));
        when(instanceMapper.selectBatchIds(any())).thenReturn(List.of(
                instance(201L, "CONTRACT", 3001L, "紧急合同审批"),
                instance(202L, "CONTRACT", 3002L, "普通合同审批")
        ));

        FinanceReportService reportService = mock(FinanceReportService.class);
        FinanceHomeService service = service(
                bookMapper, periodMapper, voucherMapper, voucherEntryMapper, assetCardMapper,
                taskMapper, instanceMapper, reportService
        );

        HomeStatsRespVO stats = service.queryHomeStats(1L, null, 3L, null, null, 9L);
        List<HomeTrendRespVO> charts = service.queryHomeCharts(1L, null, 3L, null, null, 2);

        assertEquals(new BigDecimal("120.00"), stats.getIncomeAmount());
        assertEquals(new BigDecimal("30.00"), stats.getExpenseAmount());
        assertEquals(new BigDecimal("1200.00"), stats.getAssetAmount());
        assertEquals(2L, stats.getPendingTodoCount());
        assertEquals(1L, stats.getUrgentTodoCount());
        assertEquals(2, charts.size());
        assertEquals(new BigDecimal("120.00"), charts.get(1).getIncomeAmount());
        assertEquals(new BigDecimal("30.00"), charts.get(1).getExpenseAmount());
    }

    @Test
    void shouldQueryHomeTodos() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        FinVoucherEntryMapper voucherEntryMapper = mock(FinVoucherEntryMapper.class);
        FinAssetCardMapper assetCardMapper = mock(FinAssetCardMapper.class);
        FinApproveTaskMapper taskMapper = mock(FinApproveTaskMapper.class);
        FinApproveInstanceMapper instanceMapper = mock(FinApproveInstanceMapper.class);

        when(taskMapper.selectList(any())).thenReturn(List.of(
                task(11L, 201L, "PENDING", "节点A", 8L),
                task(12L, 202L, "PENDING", "节点B", 8L)
        ));
        when(instanceMapper.selectBatchIds(any())).thenReturn(List.of(
                instance(201L, "CONTRACT", 3001L, "合同审批A"),
                instance(202L, "PAYMENT", 5002L, "支付审批B")
        ));

        FinanceHomeService service = service(
                bookMapper, periodMapper, voucherMapper, voucherEntryMapper, assetCardMapper,
                taskMapper, instanceMapper, mock(FinanceReportService.class)
        );

        List<HomeTodoRespVO> todos = service.queryHomeTodos(8L, null, null, 10);

        assertEquals(2, todos.size());
        assertEquals("CONTRACT", todos.get(0).getTodoType());
        assertEquals("合同审批A", todos.get(0).getTitle());
        assertEquals("NORMAL", todos.get(0).getUrgency());
    }

    @Test
    void shouldQueryRecentVouchersAndHomeProgress() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        FinVoucherEntryMapper voucherEntryMapper = mock(FinVoucherEntryMapper.class);
        FinAssetCardMapper assetCardMapper = mock(FinAssetCardMapper.class);
        FinApproveTaskMapper taskMapper = mock(FinApproveTaskMapper.class);
        FinApproveInstanceMapper instanceMapper = mock(FinApproveInstanceMapper.class);
        FinanceReportService reportService = mock(FinanceReportService.class);

        when(bookMapper.selectById(1L)).thenReturn(book());
        when(voucherMapper.selectList(any())).thenReturn(List.of(
                voucher(100L, FinanceVoucherType.CONTRACT_RECEIPT, new BigDecimal("66.00"), LocalDate.of(2026, 3, 12), "AUDITED"),
                voucher(101L, FinanceVoucherType.CONTRACT_PAYMENT, new BigDecimal("25.00"), LocalDate.of(2026, 3, 11), "DRAFT")
        ));
        when(voucherEntryMapper.selectList(any())).thenReturn(List.of(
                entry(100L, "收合同款"),
                entry(101L, "支付合同款")
        ));
        ReportProgressRespVO progress = new ReportProgressRespVO();
        progress.setVoucherTotal(10L);
        progress.setAuditedTotal(6L);
        progress.setPercent("60.00%");
        when(periodMapper.selectById(3L)).thenReturn(period());
        when(reportService.queryReportProgress(1L, 3L)).thenReturn(progress);

        FinanceHomeService service = service(
                bookMapper, periodMapper, voucherMapper, voucherEntryMapper, assetCardMapper,
                taskMapper, instanceMapper, reportService
        );

        List<HomeRecentVoucherRespVO> vouchers = service.queryRecentVouchers(1L, null, null, null, null, 5);
        ReportProgressRespVO resp = service.queryHomeProgress(1L, null, 3L, null, null);

        assertEquals(2, vouchers.size());
        assertEquals("收合同款", vouchers.get(0).getSummary());
        assertEquals("INCOME", vouchers.get(0).getDirection());
        assertEquals("EXPENSE", vouchers.get(1).getDirection());
        assertEquals("60.00%", resp.getPercent());
    }

    private static FinanceHomeService service(FinBookMapper bookMapper,
                                              FinPeriodMapper periodMapper,
                                              FinVoucherMapper voucherMapper,
                                              FinVoucherEntryMapper voucherEntryMapper,
                                              FinAssetCardMapper assetCardMapper,
                                              FinApproveTaskMapper taskMapper,
                                              FinApproveInstanceMapper instanceMapper,
                                              FinanceReportService reportService) {
        return new FinanceHomeServiceImpl(
                bookMapper, periodMapper, voucherMapper, voucherEntryMapper,
                assetCardMapper, mock(FinAssetCategoryMapper.class), mock(FinAssetDepreciationMapper.class),
                mock(FinAssetDisposalMapper.class), taskMapper, instanceMapper,
                mock(FinContractMainMapper.class), mock(FinContractPaymentMapper.class), mock(FinInternalTransferMapper.class),
                reportService
        );
    }

    private static FinBookDO book() {
        FinBookDO book = new FinBookDO();
        book.setId(1L);
        book.setBookCode("BOOK");
        return book;
    }

    private static FinPeriodDO period() {
        FinPeriodDO period = new FinPeriodDO();
        period.setId(3L);
        period.setBookId(1L);
        period.setPeriodYear(2026);
        period.setPeriodNo(3);
        period.setStartDate(LocalDate.of(2026, 3, 1));
        period.setEndDate(LocalDate.of(2026, 3, 31));
        return period;
    }

    private static FinVoucherDO voucher(Long id, String voucherType, BigDecimal amount, LocalDate date, String status) {
        FinVoucherDO voucher = new FinVoucherDO();
        voucher.setId(id);
        voucher.setBookId(1L);
        voucher.setPeriodId(3L);
        voucher.setVoucherType(voucherType);
        voucher.setTotalDebit(amount);
        voucher.setVoucherDate(date);
        voucher.setStatus(status);
        voucher.setVoucherNo("V-" + id);
        return voucher;
    }

    private static FinAssetCardDO asset(BigDecimal netValue, BigDecimal originalValue) {
        FinAssetCardDO card = new FinAssetCardDO();
        card.setBookId(1L);
        card.setEnableFlag(1);
        card.setNetValue(netValue);
        card.setOriginalValue(originalValue);
        return card;
    }

    private static FinApproveTaskDO task(Long id, Long instanceId, String status, String nodeName, Long approverId) {
        FinApproveTaskDO task = new FinApproveTaskDO();
        task.setId(id);
        task.setInstanceId(instanceId);
        task.setTaskStatus(status);
        task.setNodeName(nodeName);
        task.setApproverId(approverId);
        task.setTaskNo("TASK-" + id);
        task.setCreatedAt(LocalDateTime.of(2026, 3, 10, 10, 0));
        return task;
    }

    private static FinApproveInstanceDO instance(Long id, String bizType, Long bizId, String remark) {
        FinApproveInstanceDO instance = new FinApproveInstanceDO();
        instance.setId(id);
        instance.setBizType(bizType);
        instance.setBizId(bizId);
        instance.setRemark(remark);
        return instance;
    }

    private static FinVoucherEntryDO entry(Long voucherId, String summary) {
        FinVoucherEntryDO entry = new FinVoucherEntryDO();
        entry.setVoucherId(voucherId);
        entry.setLineNo(1);
        entry.setSummary(summary);
        return entry;
    }
}
