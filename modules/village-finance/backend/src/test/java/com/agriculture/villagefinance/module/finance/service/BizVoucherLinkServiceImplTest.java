package com.agriculture.villagefinance.module.finance.service;

import com.agriculture.villagefinance.module.finance.controller.vo.VoucherActionRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherEntryReqVO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinVoucherDO;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinVoucherMapper;
import com.agriculture.villagefinance.module.finance.service.dto.BizVoucherCreateCmd;
import com.agriculture.villagefinance.module.finance.service.dto.BizVoucherTraceRespVO;
import com.agriculture.villagefinance.module.finance.service.impl.BizVoucherLinkServiceImpl;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class BizVoucherLinkServiceImplTest {

    @Test
    void shouldCreateVoucherViaUnifiedLinkService() {
        VoucherService voucherService = mock(VoucherService.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        when(voucherMapper.selectCount(any())).thenReturn(0L);

        VoucherActionRespVO action = new VoucherActionRespVO();
        action.setVoucherId(100L);
        when(voucherService.createVoucher(any())).thenReturn(action);

        FinVoucherDO persisted = new FinVoucherDO();
        persisted.setId(100L);
        persisted.setBookId(1L);
        persisted.setPeriodId(2L);
        persisted.setVoucherType("TRANSFER");
        persisted.setBizId(88L);
        when(voucherMapper.selectById(100L)).thenReturn(persisted);

        BizVoucherLinkService service = new BizVoucherLinkServiceImpl(voucherService, voucherMapper);
        BizVoucherCreateCmd cmd = buildTransferCmd();

        VoucherActionRespVO resp = service.createVoucher(cmd);
        assertEquals(100L, resp.getVoucherId());
        verify(voucherService).createVoucher(any());
    }

    @Test
    void shouldTraceBusinessSourceFromVoucherTypeAndBizId() {
        VoucherService voucherService = mock(VoucherService.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);

        FinVoucherDO voucher = new FinVoucherDO();
        voucher.setId(101L);
        voucher.setVoucherNo("BOOK-202603-0001");
        voucher.setBookId(1L);
        voucher.setPeriodId(2L);
        voucher.setVoucherType("TRANSFER");
        voucher.setBizId(88L);
        voucher.setStatus("DRAFT");
        voucher.setVoucherDate(LocalDate.of(2026, 3, 12));
        when(voucherMapper.selectOne(any())).thenReturn(voucher);
        when(voucherMapper.selectById(101L)).thenReturn(voucher);

        BizVoucherLinkService service = new BizVoucherLinkServiceImpl(voucherService, voucherMapper);

        BizVoucherTraceRespVO byBiz = service.queryVoucherByBiz("TRANSFER", 88L);
        assertEquals(101L, byBiz.getVoucherId());
        assertEquals(88L, byBiz.getBizId());

        BizVoucherTraceRespVO byVoucher = service.traceByVoucherId(101L);
        assertEquals("TRANSFER", byVoucher.getVoucherType());
    }

    @Test
    void shouldRejectBypassVoucherWriteInModuleService() {
        VoucherService voucherService = mock(VoucherService.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        BizVoucherLinkService service = new BizVoucherLinkServiceImpl(voucherService, voucherMapper);

        BizVoucherCreateCmd cmd = buildTransferCmd();
        cmd.setVoucherType("MANUAL");
        assertThrows(IllegalArgumentException.class, () -> service.createVoucher(cmd));
    }

    private static BizVoucherCreateCmd buildTransferCmd() {
        VoucherEntryReqVO debit = new VoucherEntryReqVO();
        debit.setSubjectId(1002L);
        debit.setDebitAmount(new BigDecimal("20.00"));
        debit.setCreditAmount(BigDecimal.ZERO);

        VoucherEntryReqVO credit = new VoucherEntryReqVO();
        credit.setSubjectId(1001L);
        credit.setDebitAmount(BigDecimal.ZERO);
        credit.setCreditAmount(new BigDecimal("20.00"));

        BizVoucherCreateCmd cmd = new BizVoucherCreateCmd();
        cmd.setLedgerId(1L);
        cmd.setPeriodId(2L);
        cmd.setVoucherDate(LocalDate.of(2026, 3, 12));
        cmd.setVoucherType("TRANSFER");
        cmd.setBizId(88L);
        cmd.setSummary("内部转账");
        cmd.setOperatorId(7L);
        cmd.setEntries(List.of(debit, credit));
        return cmd;
    }
}
