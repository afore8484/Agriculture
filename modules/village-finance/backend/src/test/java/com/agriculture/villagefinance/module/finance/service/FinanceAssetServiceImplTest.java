package com.agriculture.villagefinance.module.finance.service;

import com.agriculture.villagefinance.module.finance.constant.FinanceVoucherType;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetDepreciationCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssetDisposalCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherActionRespVO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinAssetCardDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinAssetDepreciationDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinAssetDisposalDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodCloseDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodReopenLogDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinSubjectDO;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinAssetCardMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinAssetCategoryMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinAssetDepreciationMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinAssetDisposalMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinAssetInventoryDetailMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinAssetInventoryMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinBookMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodCloseMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodOperationLogMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodReopenLogMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinSubjectMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinVoucherMapper;
import com.agriculture.villagefinance.module.finance.service.BizVoucherLinkService;
import com.agriculture.villagefinance.module.finance.service.dto.BizVoucherCreateCmd;
import com.agriculture.villagefinance.module.finance.service.impl.FinanceAssetServiceImpl;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class FinanceAssetServiceImplTest {

    @Test
    void shouldCreateDepreciationAndLinkVoucher() {
        TestContext c = newContext();
        mockActiveAsset(c, 100L, 1L, "USING", new BigDecimal("900.00"), new BigDecimal("100.00"));
        mockOpenPeriodByLabel(c, 1L, 11L);
        mockSubjects(c, 1L, 1001L, 1002L);
        doAnswer(invocation -> {
            FinAssetDepreciationDO row = invocation.getArgument(0);
            row.setId(200L);
            return 1;
        }).when(c.depreciationMapper).insert(any(FinAssetDepreciationDO.class));
        when(c.bizVoucherLinkService.createVoucher(any())).thenReturn(voucherAction(300L));

        AssetDepreciationCreateReqVO reqVO = new AssetDepreciationCreateReqVO();
        reqVO.setAssetId(100L);
        reqVO.setPeriodLabel("2026-03");
        reqVO.setDepreciationAmount(new BigDecimal("50.00"));
        reqVO.setDebitSubjectId(1001L);
        reqVO.setCreditSubjectId(1002L);
        reqVO.setOperatorId(9L);

        assertEquals(300L, c.service.createDepreciation(reqVO).getVoucherId());
        ArgumentCaptor<FinAssetDepreciationDO> depCaptor = ArgumentCaptor.forClass(FinAssetDepreciationDO.class);
        verify(c.depreciationMapper).updateById(depCaptor.capture());
        assertEquals(300L, depCaptor.getValue().getVoucherId());
    }

    @Test
    void shouldCreateDisposalAndLinkVoucher() {
        TestContext c = newContext();
        mockActiveAsset(c, 100L, 1L, "USING", new BigDecimal("800.00"), new BigDecimal("200.00"));
        mockOpenPeriodByDate(c, 1L, 12L);
        mockSubjects(c, 1L, 1001L, 1002L);
        when(c.disposalMapper.selectCount(any())).thenReturn(0L);
        doAnswer(invocation -> {
            FinAssetDisposalDO row = invocation.getArgument(0);
            row.setId(210L);
            return 1;
        }).when(c.disposalMapper).insert(any(FinAssetDisposalDO.class));
        when(c.bizVoucherLinkService.createVoucher(any())).thenReturn(voucherAction(310L));

        AssetDisposalCreateReqVO reqVO = new AssetDisposalCreateReqVO();
        reqVO.setAssetId(100L);
        reqVO.setDisposalType("SELL");
        reqVO.setDisposalDate(LocalDate.of(2026, 3, 15));
        reqVO.setVoucherAmount(new BigDecimal("500.00"));
        reqVO.setDebitSubjectId(1001L);
        reqVO.setCreditSubjectId(1002L);
        reqVO.setDisposalIncome(new BigDecimal("500.00"));
        reqVO.setDisposalLoss(BigDecimal.ZERO);
        reqVO.setOperatorId(8L);

        assertEquals(310L, c.service.createDisposal(reqVO).getVoucherId());
        ArgumentCaptor<FinAssetDisposalDO> disposalCaptor = ArgumentCaptor.forClass(FinAssetDisposalDO.class);
        verify(c.disposalMapper).updateById(disposalCaptor.capture());
        assertEquals(310L, disposalCaptor.getValue().getVoucherId());
    }

    @Test
    void shouldRejectAssetWriteWhenAssetPeriodClosed() {
        TestContext c = newContext();
        mockActiveAsset(c, 100L, 1L, "USING", new BigDecimal("900.00"), new BigDecimal("100.00"));
        mockOpenPeriodByLabel(c, 1L, 11L);
        FinPeriodCloseDO closeDO = new FinPeriodCloseDO();
        closeDO.setBookId(1L);
        closeDO.setPeriodId(11L);
        closeDO.setCloseType("ASSET");
        closeDO.setCloseTime(LocalDateTime.of(2026, 3, 31, 20, 0));
        when(c.periodCloseMapper.selectOne(any())).thenReturn(closeDO);
        when(c.periodReopenLogMapper.selectOne(any())).thenReturn(null);

        AssetDepreciationCreateReqVO reqVO = new AssetDepreciationCreateReqVO();
        reqVO.setAssetId(100L);
        reqVO.setPeriodLabel("2026-03");
        reqVO.setDepreciationAmount(new BigDecimal("50.00"));
        reqVO.setDebitSubjectId(1001L);
        reqVO.setCreditSubjectId(1002L);

        assertThrows(IllegalStateException.class, () -> c.service.createDepreciation(reqVO));
    }

    @Test
    void shouldAllowAssetWriteAfterAssetPeriodReopen() {
        TestContext c = newContext();
        mockActiveAsset(c, 100L, 1L, "USING", new BigDecimal("900.00"), new BigDecimal("100.00"));
        mockOpenPeriodByLabel(c, 1L, 11L);
        mockSubjects(c, 1L, 1001L, 1002L);
        FinPeriodCloseDO closeDO = new FinPeriodCloseDO();
        closeDO.setBookId(1L);
        closeDO.setPeriodId(11L);
        closeDO.setCloseType("ASSET");
        closeDO.setCloseTime(LocalDateTime.of(2026, 3, 31, 20, 0));
        when(c.periodCloseMapper.selectOne(any())).thenReturn(closeDO);
        FinPeriodReopenLogDO reopenLogDO = new FinPeriodReopenLogDO();
        reopenLogDO.setOperateTime(LocalDateTime.of(2026, 4, 1, 9, 0));
        reopenLogDO.setReopenNo("ASSET-REOPEN-1-11-001");
        when(c.periodReopenLogMapper.selectOne(any())).thenReturn(reopenLogDO);
        doAnswer(invocation -> {
            FinAssetDepreciationDO row = invocation.getArgument(0);
            row.setId(200L);
            return 1;
        }).when(c.depreciationMapper).insert(any(FinAssetDepreciationDO.class));
        when(c.bizVoucherLinkService.createVoucher(any())).thenReturn(voucherAction(320L));

        AssetDepreciationCreateReqVO reqVO = new AssetDepreciationCreateReqVO();
        reqVO.setAssetId(100L);
        reqVO.setPeriodLabel("2026-03");
        reqVO.setDepreciationAmount(new BigDecimal("50.00"));
        reqVO.setDebitSubjectId(1001L);
        reqVO.setCreditSubjectId(1002L);

        assertEquals(320L, c.service.createDepreciation(reqVO).getVoucherId());
    }

    @Test
    void shouldKeepBizVoucherLinkConsistentForAsset() {
        TestContext c = newContext();
        mockActiveAsset(c, 100L, 1L, "USING", new BigDecimal("900.00"), new BigDecimal("100.00"));
        mockOpenPeriodByLabel(c, 1L, 11L);
        mockSubjects(c, 1L, 1001L, 1002L);
        doAnswer(invocation -> {
            FinAssetDepreciationDO row = invocation.getArgument(0);
            row.setId(220L);
            return 1;
        }).when(c.depreciationMapper).insert(any(FinAssetDepreciationDO.class));
        when(c.bizVoucherLinkService.createVoucher(any())).thenReturn(voucherAction(330L));

        AssetDepreciationCreateReqVO reqVO = new AssetDepreciationCreateReqVO();
        reqVO.setAssetId(100L);
        reqVO.setPeriodLabel("2026-03");
        reqVO.setDepreciationAmount(new BigDecimal("50.00"));
        reqVO.setDebitSubjectId(1001L);
        reqVO.setCreditSubjectId(1002L);

        c.service.createDepreciation(reqVO);

        ArgumentCaptor<BizVoucherCreateCmd> cmdCaptor = ArgumentCaptor.forClass(BizVoucherCreateCmd.class);
        verify(c.bizVoucherLinkService).createVoucher(cmdCaptor.capture());
        BizVoucherCreateCmd cmd = cmdCaptor.getValue();
        assertEquals(FinanceVoucherType.ASSET_DEPRECIATION, cmd.getVoucherType());
        assertEquals(220L, cmd.getBizId());
        assertNotNull(cmd.getEntries());
        assertEquals(2, cmd.getEntries().size());
        assertEquals(new BigDecimal("50.00"), cmd.getEntries().get(0).getDebitAmount());
        assertEquals(new BigDecimal("50.00"), cmd.getEntries().get(1).getCreditAmount());
    }

    @Test
    void shouldRejectDeleteAssetWhenVoucherLinked() {
        TestContext c = newContext();
        FinAssetCardDO card = new FinAssetCardDO();
        card.setId(100L);
        when(c.cardMapper.selectById(100L)).thenReturn(card);
        when(c.depreciationMapper.selectCount(any())).thenReturn(0L);
        when(c.disposalMapper.selectCount(any())).thenReturn(0L);
        when(c.inventoryDetailMapper.selectCount(any())).thenReturn(0L);

        FinAssetDepreciationDO depreciationDO = new FinAssetDepreciationDO();
        depreciationDO.setId(220L);
        depreciationDO.setAssetId(100L);
        when(c.depreciationMapper.selectList(any())).thenReturn(List.of(depreciationDO));
        when(c.disposalMapper.selectList(any())).thenReturn(List.of());
        when(c.voucherMapper.selectCount(any())).thenReturn(1L);

        assertThrows(IllegalStateException.class, () -> c.service.deleteAssetCard(100L));
        verify(c.cardMapper, never()).deleteById(100L);
    }

    private static void mockActiveAsset(TestContext c, Long assetId, Long ledgerId, String status,
                                        BigDecimal netValue, BigDecimal accumulated) {
        FinAssetCardDO card = new FinAssetCardDO();
        card.setId(assetId);
        card.setBookId(ledgerId);
        card.setEnableFlag(1);
        card.setStatus(status);
        card.setNetValue(netValue);
        card.setAccumulatedDepreciation(accumulated);
        when(c.cardMapper.selectById(assetId)).thenReturn(card);
    }

    private static void mockOpenPeriodByLabel(TestContext c, Long ledgerId, Long periodId) {
        FinPeriodDO period = new FinPeriodDO();
        period.setId(periodId);
        period.setBookId(ledgerId);
        period.setPeriodYear(2026);
        period.setPeriodNo(3);
        period.setStartDate(LocalDate.of(2026, 3, 1));
        period.setCloseStatus("OPEN");
        when(c.periodMapper.selectOne(any())).thenReturn(period);
        when(c.periodCloseMapper.selectOne(any())).thenReturn(null);
        when(c.periodReopenLogMapper.selectOne(any())).thenReturn(null);
    }

    private static void mockOpenPeriodByDate(TestContext c, Long ledgerId, Long periodId) {
        FinPeriodDO period = new FinPeriodDO();
        period.setId(periodId);
        period.setBookId(ledgerId);
        period.setStartDate(LocalDate.of(2026, 3, 1));
        period.setCloseStatus("OPEN");
        when(c.periodMapper.selectOne(any())).thenReturn(period);
        when(c.periodCloseMapper.selectOne(any())).thenReturn(null);
        when(c.periodReopenLogMapper.selectOne(any())).thenReturn(null);
    }

    private static void mockSubjects(TestContext c, Long ledgerId, Long debitId, Long creditId) {
        FinSubjectDO debit = new FinSubjectDO();
        debit.setId(debitId);
        debit.setBookId(ledgerId);
        debit.setEnableFlag(1);
        FinSubjectDO credit = new FinSubjectDO();
        credit.setId(creditId);
        credit.setBookId(ledgerId);
        credit.setEnableFlag(1);
        when(c.subjectMapper.selectById(debitId)).thenReturn(debit);
        when(c.subjectMapper.selectById(creditId)).thenReturn(credit);
    }

    private static VoucherActionRespVO voucherAction(Long voucherId) {
        VoucherActionRespVO vo = new VoucherActionRespVO();
        vo.setVoucherId(voucherId);
        vo.setVoucherNo("V-" + voucherId);
        vo.setStatus("DRAFT");
        return vo;
    }

    private static TestContext newContext() {
        TestContext c = new TestContext();
        c.categoryMapper = mock(FinAssetCategoryMapper.class);
        c.cardMapper = mock(FinAssetCardMapper.class);
        c.depreciationMapper = mock(FinAssetDepreciationMapper.class);
        c.disposalMapper = mock(FinAssetDisposalMapper.class);
        c.inventoryMapper = mock(FinAssetInventoryMapper.class);
        c.inventoryDetailMapper = mock(FinAssetInventoryDetailMapper.class);
        c.bookMapper = mock(FinBookMapper.class);
        c.voucherMapper = mock(FinVoucherMapper.class);
        c.subjectMapper = mock(FinSubjectMapper.class);
        c.periodMapper = mock(FinPeriodMapper.class);
        c.periodCloseMapper = mock(FinPeriodCloseMapper.class);
        c.periodReopenLogMapper = mock(FinPeriodReopenLogMapper.class);
        c.periodOperationLogMapper = mock(FinPeriodOperationLogMapper.class);
        c.bizVoucherLinkService = mock(BizVoucherLinkService.class);
        c.service = new FinanceAssetServiceImpl(
                c.categoryMapper,
                c.cardMapper,
                c.depreciationMapper,
                c.disposalMapper,
                c.inventoryMapper,
                c.inventoryDetailMapper,
                c.bookMapper,
                c.voucherMapper,
                c.subjectMapper,
                c.periodMapper,
                c.periodCloseMapper,
                c.periodReopenLogMapper,
                c.periodOperationLogMapper,
                c.bizVoucherLinkService
        );
        return c;
    }

    private static class TestContext {
        private FinanceAssetService service;
        private FinAssetCategoryMapper categoryMapper;
        private FinAssetCardMapper cardMapper;
        private FinAssetDepreciationMapper depreciationMapper;
        private FinAssetDisposalMapper disposalMapper;
        private FinAssetInventoryMapper inventoryMapper;
        private FinAssetInventoryDetailMapper inventoryDetailMapper;
        private FinBookMapper bookMapper;
        private FinVoucherMapper voucherMapper;
        private FinSubjectMapper subjectMapper;
        private FinPeriodMapper periodMapper;
        private FinPeriodCloseMapper periodCloseMapper;
        private FinPeriodReopenLogMapper periodReopenLogMapper;
        private FinPeriodOperationLogMapper periodOperationLogMapper;
        private BizVoucherLinkService bizVoucherLinkService;
    }
}
