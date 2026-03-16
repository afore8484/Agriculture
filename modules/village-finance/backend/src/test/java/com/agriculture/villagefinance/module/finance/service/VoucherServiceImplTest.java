package com.agriculture.villagefinance.module.finance.service;

import com.agriculture.villagefinance.module.finance.controller.vo.VoucherActionRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherAuditReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherEntryReqVO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinBookDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinSubjectDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinVoucherDO;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinBookMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinSubjectMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinVoucherAttachmentMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinVoucherAuditLogMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinVoucherEntryMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinVoucherMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinVoucherOperationLogMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinVoucherRecycleEntryMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinVoucherRecycleMapper;
import com.agriculture.villagefinance.module.finance.service.impl.VoucherServiceImpl;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class VoucherServiceImplTest {

    @Test
    void shouldCreateVoucherWithBalancedEntries() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        FinVoucherEntryMapper entryMapper = mock(FinVoucherEntryMapper.class);

        FinBookDO book = new FinBookDO();
        book.setId(1L);
        book.setBookCode("BOOK");
        when(bookMapper.selectById(1L)).thenReturn(book);
        FinPeriodDO period = new FinPeriodDO();
        period.setId(2L);
        period.setBookId(1L);
        period.setPeriodYear(2026);
        period.setPeriodNo(3);
        when(periodMapper.selectById(2L)).thenReturn(period);
        FinSubjectDO subject = new FinSubjectDO();
        subject.setId(9L);
        when(subjectMapper.selectBatchIds(any())).thenReturn(List.of(subject));
        when(voucherMapper.selectCount(any())).thenReturn(0L);
        doAnswer(invocation -> {
            FinVoucherDO voucher = invocation.getArgument(0);
            voucher.setId(100L);
            return 1;
        }).when(voucherMapper).insert(any(FinVoucherDO.class));

        VoucherService service = new VoucherServiceImpl(
                bookMapper, periodMapper, subjectMapper,
                voucherMapper, entryMapper,
                mock(FinVoucherAttachmentMapper.class), mock(FinVoucherAuditLogMapper.class),
                mock(FinVoucherOperationLogMapper.class), mock(FinVoucherRecycleMapper.class),
                mock(FinVoucherRecycleEntryMapper.class), new ObjectMapper()
        );

        VoucherCreateReqVO reqVO = new VoucherCreateReqVO();
        reqVO.setLedgerId(1L);
        reqVO.setPeriodId(2L);
        reqVO.setVoucherDate(LocalDate.of(2026, 3, 12));
        reqVO.setCreatedBy(7L);
        reqVO.setEntries(List.of(
                entry(9L, new BigDecimal("100.00"), BigDecimal.ZERO),
                entry(9L, BigDecimal.ZERO, new BigDecimal("100.00"))
        ));

        VoucherActionRespVO respVO = service.createVoucher(reqVO);

        assertEquals(100L, respVO.getVoucherId());
        ArgumentCaptor<FinVoucherDO> captor = ArgumentCaptor.forClass(FinVoucherDO.class);
        verify(voucherMapper).insert(captor.capture());
        assertEquals("BOOK-202603-0001", captor.getValue().getVoucherNo());
        verify(entryMapper).insert(any());
    }

    @Test
    void shouldRejectUnbalancedVoucherEntries() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        FinBookDO book = new FinBookDO();
        book.setId(1L);
        book.setBookCode("BOOK");
        when(bookMapper.selectById(1L)).thenReturn(book);
        FinPeriodDO period = new FinPeriodDO();
        period.setId(2L);
        period.setBookId(1L);
        when(periodMapper.selectById(2L)).thenReturn(period);
        FinSubjectDO subject = new FinSubjectDO();
        subject.setId(9L);
        when(subjectMapper.selectBatchIds(any())).thenReturn(List.of(subject));

        VoucherService service = new VoucherServiceImpl(
                bookMapper, periodMapper, subjectMapper,
                voucherMapper, mock(FinVoucherEntryMapper.class),
                mock(FinVoucherAttachmentMapper.class), mock(FinVoucherAuditLogMapper.class),
                mock(FinVoucherOperationLogMapper.class), mock(FinVoucherRecycleMapper.class),
                mock(FinVoucherRecycleEntryMapper.class), new ObjectMapper()
        );

        VoucherCreateReqVO reqVO = new VoucherCreateReqVO();
        reqVO.setLedgerId(1L);
        reqVO.setPeriodId(2L);
        reqVO.setVoucherDate(LocalDate.of(2026, 3, 12));
        reqVO.setCreatedBy(7L);
        reqVO.setEntries(List.of(
                entry(9L, new BigDecimal("100.00"), BigDecimal.ZERO),
                entry(9L, BigDecimal.ZERO, new BigDecimal("20.00"))
        ));

        assertThrows(IllegalArgumentException.class, () -> service.createVoucher(reqVO));
    }

    @Test
    void shouldAuditDraftVoucher() {
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);
        FinVoucherDO voucher = new FinVoucherDO();
        voucher.setId(100L);
        voucher.setVoucherNo("BOOK-202603-0001");
        voucher.setStatus("DRAFT");
        when(voucherMapper.selectById(100L)).thenReturn(voucher);

        VoucherService service = new VoucherServiceImpl(
                mock(FinBookMapper.class), mock(FinPeriodMapper.class), mock(FinSubjectMapper.class),
                voucherMapper, mock(FinVoucherEntryMapper.class),
                mock(FinVoucherAttachmentMapper.class), mock(FinVoucherAuditLogMapper.class),
                mock(FinVoucherOperationLogMapper.class), mock(FinVoucherRecycleMapper.class),
                mock(FinVoucherRecycleEntryMapper.class), new ObjectMapper()
        );

        VoucherAuditReqVO reqVO = new VoucherAuditReqVO();
        reqVO.setOperatorId(9L);

        VoucherActionRespVO respVO = service.auditVoucher(100L, reqVO);

        assertEquals("AUDITED", respVO.getStatus());
        verify(voucherMapper).updateById(any(FinVoucherDO.class));
    }

    private static VoucherEntryReqVO entry(Long subjectId, BigDecimal debit, BigDecimal credit) {
        VoucherEntryReqVO reqVO = new VoucherEntryReqVO();
        reqVO.setSubjectId(subjectId);
        reqVO.setDebitAmount(debit);
        reqVO.setCreditAmount(credit);
        return reqVO;
    }
}
