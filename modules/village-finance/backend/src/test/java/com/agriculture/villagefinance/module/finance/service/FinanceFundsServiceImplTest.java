package com.agriculture.villagefinance.module.finance.service;

import com.agriculture.villagefinance.module.finance.controller.vo.InternalTransferReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.BankAccountUpdateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.JournalCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.JournalListRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.PeriodCloseReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.PeriodReopenReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherActionRespVO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinBankAccountDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinBookDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinCashAccountDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinInternalTransferDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinSubjectDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinVoucherDO;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinBankAccountMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinBankJournalMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinBookMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinCashAccountMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinCashJournalMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinInternalTransferMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodCloseCheckMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodCloseMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodOperationLogMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodReopenLogMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinReconciliationMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinSubjectMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinVoucherMapper;
import com.agriculture.villagefinance.module.finance.service.impl.FinanceFundsServiceImpl;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

import java.math.BigDecimal;
import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class FinanceFundsServiceImplTest {

    @Test
    void shouldUpdateBankAccount() {
        FinBankAccountMapper bankAccountMapper = mock(FinBankAccountMapper.class);
        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);

        FinBankAccountDO account = new FinBankAccountDO();
        account.setId(10L);
        account.setBookId(1L);
        account.setAccountName("旧账户");
        account.setSubjectId(1001L);
        account.setStatus("ENABLE");
        when(bankAccountMapper.selectById(10L)).thenReturn(account);

        FinSubjectDO subject = new FinSubjectDO();
        subject.setId(1002L);
        subject.setBookId(1L);
        subject.setEnableFlag(1);
        when(subjectMapper.selectById(1002L)).thenReturn(subject);

        FinanceFundsService service = service(
                mock(FinBookMapper.class),
                mock(FinPeriodMapper.class),
                mock(FinVoucherMapper.class),
                subjectMapper,
                bankAccountMapper,
                mock(FinCashAccountMapper.class),
                mock(FinBankJournalMapper.class),
                mock(FinCashJournalMapper.class),
                mock(FinInternalTransferMapper.class),
                mock(FinReconciliationMapper.class),
                mock(FinPeriodCloseMapper.class),
                mock(FinPeriodCloseCheckMapper.class),
                mock(FinPeriodReopenLogMapper.class),
                mock(FinPeriodOperationLogMapper.class),
                mock(BizVoucherLinkService.class)
        );

        BankAccountUpdateReqVO reqVO = new BankAccountUpdateReqVO();
        reqVO.setAccountName("新账户");
        reqVO.setSubjectId(1002L);
        reqVO.setRemark("澶囨敞");

        service.updateBankAccount(10L, reqVO);

        ArgumentCaptor<FinBankAccountDO> captor = ArgumentCaptor.forClass(FinBankAccountDO.class);
        verify(bankAccountMapper).updateById(captor.capture());
        assertEquals("新账户", captor.getValue().getAccountName());
        assertEquals(1002L, captor.getValue().getSubjectId());
        assertEquals("澶囨敞", captor.getValue().getRemark());
    }

    @Test
    void shouldDisableAccount() {
        FinBankAccountMapper bankAccountMapper = mock(FinBankAccountMapper.class);

        FinBankAccountDO account = new FinBankAccountDO();
        account.setId(10L);
        account.setBookId(1L);
        account.setStatus("ENABLE");
        when(bankAccountMapper.selectById(10L)).thenReturn(account);

        FinanceFundsService service = service(
                mock(FinBookMapper.class),
                mock(FinPeriodMapper.class),
                mock(FinVoucherMapper.class),
                mock(FinSubjectMapper.class),
                bankAccountMapper,
                mock(FinCashAccountMapper.class),
                mock(FinBankJournalMapper.class),
                mock(FinCashJournalMapper.class),
                mock(FinInternalTransferMapper.class),
                mock(FinReconciliationMapper.class),
                mock(FinPeriodCloseMapper.class),
                mock(FinPeriodCloseCheckMapper.class),
                mock(FinPeriodReopenLogMapper.class),
                mock(FinPeriodOperationLogMapper.class),
                mock(BizVoucherLinkService.class)
        );

        service.disableBankAccount(10L);

        ArgumentCaptor<FinBankAccountDO> captor = ArgumentCaptor.forClass(FinBankAccountDO.class);
        verify(bankAccountMapper).updateById(captor.capture());
        assertEquals("DISABLE", captor.getValue().getStatus());
    }

    @Test
    void shouldRejectDeleteWhenLedgerExists() {
        FinBankAccountMapper bankAccountMapper = mock(FinBankAccountMapper.class);
        FinBankJournalMapper bankJournalMapper = mock(FinBankJournalMapper.class);

        FinBankAccountDO account = new FinBankAccountDO();
        account.setId(10L);
        account.setBookId(1L);
        account.setStatus("ENABLE");
        when(bankAccountMapper.selectById(10L)).thenReturn(account);
        when(bankJournalMapper.selectCount(any())).thenReturn(1L);

        FinanceFundsService service = service(
                mock(FinBookMapper.class),
                mock(FinPeriodMapper.class),
                mock(FinVoucherMapper.class),
                mock(FinSubjectMapper.class),
                bankAccountMapper,
                mock(FinCashAccountMapper.class),
                bankJournalMapper,
                mock(FinCashJournalMapper.class),
                mock(FinInternalTransferMapper.class),
                mock(FinReconciliationMapper.class),
                mock(FinPeriodCloseMapper.class),
                mock(FinPeriodCloseCheckMapper.class),
                mock(FinPeriodReopenLogMapper.class),
                mock(FinPeriodOperationLogMapper.class),
                mock(BizVoucherLinkService.class)
        );

        assertThrows(IllegalStateException.class, () -> service.deleteBankAccount(10L));
        verify(bankAccountMapper, never()).deleteById(any(Long.class));
    }

    @Test
    void shouldCreateBankJournalAndRefreshBalance() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinBankAccountMapper bankAccountMapper = mock(FinBankAccountMapper.class);
        FinBankJournalMapper bankJournalMapper = mock(FinBankJournalMapper.class);

        FinBookDO book = new FinBookDO();
        book.setId(1L);
        when(bookMapper.selectById(1L)).thenReturn(book);

        FinBankAccountDO account = new FinBankAccountDO();
        account.setId(10L);
        account.setBookId(1L);
        account.setCurrentBalance(new BigDecimal("100.00"));
        account.setStatus("ENABLE");
        when(bankAccountMapper.selectById(10L)).thenReturn(account);
        FinPeriodDO period = new FinPeriodDO();
        period.setId(3L);
        period.setBookId(1L);
        period.setStartDate(LocalDate.of(2026, 3, 1));
        period.setEndDate(LocalDate.of(2026, 3, 31));
        period.setCloseStatus("OPEN");
        when(periodMapper.selectOne(any())).thenReturn(period);
        doAnswer(invocation -> {
            com.agriculture.villagefinance.module.finance.dal.dataobject.FinBankJournalDO journal = invocation.getArgument(0);
            journal.setId(55L);
            return 1;
        }).when(bankJournalMapper).insert(any(com.agriculture.villagefinance.module.finance.dal.dataobject.FinBankJournalDO.class));

        FinanceFundsService service = service(
                bookMapper,
                periodMapper,
                mock(FinVoucherMapper.class),
                mock(FinSubjectMapper.class),
                bankAccountMapper,
                mock(FinCashAccountMapper.class),
                bankJournalMapper,
                mock(FinCashJournalMapper.class),
                mock(FinInternalTransferMapper.class),
                mock(FinReconciliationMapper.class),
                mock(FinPeriodCloseMapper.class),
                mock(FinPeriodCloseCheckMapper.class),
                mock(FinPeriodReopenLogMapper.class),
                mock(FinPeriodOperationLogMapper.class),
                mock(BizVoucherLinkService.class)
        );

        JournalCreateReqVO reqVO = new JournalCreateReqVO();
        reqVO.setAccountId(10L);
        reqVO.setTxnDate(LocalDate.of(2026, 3, 18));
        reqVO.setDirection("INCOME");
        reqVO.setAmount(new BigDecimal("25.00"));

        JournalListRespVO resp = service.createBankJournal(reqVO);

        assertEquals(55L, resp.getJournalId());
        ArgumentCaptor<FinBankAccountDO> captor = ArgumentCaptor.forClass(FinBankAccountDO.class);
        verify(bankAccountMapper).updateById(captor.capture());
        assertEquals(new BigDecimal("125.00"), captor.getValue().getCurrentBalance());
    }

    @Test
    void shouldRejectClosePeriodWhenPendingVoucherExists() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);

        FinBookDO book = new FinBookDO();
        book.setId(1L);
        when(bookMapper.selectById(1L)).thenReturn(book);

        FinPeriodDO period = new FinPeriodDO();
        period.setId(3L);
        period.setBookId(1L);
        period.setCloseStatus("OPEN");
        when(periodMapper.selectById(3L)).thenReturn(period);
        when(voucherMapper.selectCount(any())).thenReturn(1L);

        FinanceFundsService service = service(
                bookMapper,
                periodMapper,
                voucherMapper,
                mock(FinSubjectMapper.class),
                mock(FinBankAccountMapper.class),
                mock(FinCashAccountMapper.class),
                mock(FinBankJournalMapper.class),
                mock(FinCashJournalMapper.class),
                mock(FinInternalTransferMapper.class),
                mock(FinReconciliationMapper.class),
                mock(FinPeriodCloseMapper.class),
                mock(FinPeriodCloseCheckMapper.class),
                mock(FinPeriodReopenLogMapper.class),
                mock(FinPeriodOperationLogMapper.class),
                mock(BizVoucherLinkService.class)
        );

        PeriodCloseReqVO reqVO = new PeriodCloseReqVO();
        reqVO.setLedgerId(1L);
        reqVO.setPeriodId(3L);

        assertThrows(IllegalStateException.class, () -> service.closePeriod(reqVO));
    }

    @Test
    void shouldCreateTransferAndGenerateVoucher() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinBankAccountMapper bankAccountMapper = mock(FinBankAccountMapper.class);
        FinCashAccountMapper cashAccountMapper = mock(FinCashAccountMapper.class);
        FinInternalTransferMapper transferMapper = mock(FinInternalTransferMapper.class);
        FinBankJournalMapper bankJournalMapper = mock(FinBankJournalMapper.class);
        FinCashJournalMapper cashJournalMapper = mock(FinCashJournalMapper.class);
        BizVoucherLinkService bizVoucherLinkService = mock(BizVoucherLinkService.class);

        FinBankAccountDO from = new FinBankAccountDO();
        from.setId(10L);
        from.setBookId(1L);
        from.setCurrentBalance(new BigDecimal("100.00"));
        from.setStatus("ENABLE");
        from.setSubjectId(1001L);

        FinCashAccountDO to = new FinCashAccountDO();
        to.setId(20L);
        to.setBookId(1L);
        to.setCurrentBalance(new BigDecimal("5.00"));
        to.setStatus("ENABLE");
        to.setSubjectId(1002L);

        when(bankAccountMapper.selectById(10L)).thenReturn(from);
        when(bankAccountMapper.selectById(20L)).thenReturn(null);
        when(cashAccountMapper.selectById(20L)).thenReturn(to);
        when(cashAccountMapper.selectById(10L)).thenReturn(null);

        FinPeriodDO period = new FinPeriodDO();
        period.setId(3L);
        period.setBookId(1L);
        period.setStartDate(LocalDate.of(2026, 3, 1));
        period.setEndDate(LocalDate.of(2026, 3, 31));
        period.setCloseStatus("OPEN");
        when(periodMapper.selectOne(any())).thenReturn(period);

        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);
        FinSubjectDO fromSubject = new FinSubjectDO();
        fromSubject.setId(1001L);
        fromSubject.setBookId(1L);
        fromSubject.setEnableFlag(1);
        FinSubjectDO toSubject = new FinSubjectDO();
        toSubject.setId(1002L);
        toSubject.setBookId(1L);
        toSubject.setEnableFlag(1);
        when(subjectMapper.selectById(1001L)).thenReturn(fromSubject);
        when(subjectMapper.selectById(1002L)).thenReturn(toSubject);

        doAnswer(invocation -> {
            FinInternalTransferDO transfer = invocation.getArgument(0);
            transfer.setId(88L);
            return 1;
        }).when(transferMapper).insert(any(FinInternalTransferDO.class));

        VoucherActionRespVO voucher = new VoucherActionRespVO();
        voucher.setVoucherId(900L);
        when(bizVoucherLinkService.createVoucher(any())).thenReturn(voucher);

        FinanceFundsService service = service(
                bookMapper,
                periodMapper,
                mock(FinVoucherMapper.class),
                subjectMapper,
                bankAccountMapper,
                cashAccountMapper,
                bankJournalMapper,
                cashJournalMapper,
                transferMapper,
                mock(FinReconciliationMapper.class),
                mock(FinPeriodCloseMapper.class),
                mock(FinPeriodCloseCheckMapper.class),
                mock(FinPeriodReopenLogMapper.class),
                mock(FinPeriodOperationLogMapper.class) ,
                bizVoucherLinkService
        );

        InternalTransferReqVO reqVO = new InternalTransferReqVO();
        reqVO.setFromAccountId(10L);
        reqVO.setToAccountId(20L);
        reqVO.setAmount(new BigDecimal("20.00"));
        reqVO.setTxnDate(LocalDate.of(2026, 3, 18));
        reqVO.setOperatorId(7L);

        service.createInternalTransfer(reqVO);

        ArgumentCaptor<FinInternalTransferDO> updateCaptor = ArgumentCaptor.forClass(FinInternalTransferDO.class);
        verify(transferMapper).updateById(updateCaptor.capture());
        assertEquals(900L, updateCaptor.getValue().getVoucherId());
        verify(bizVoucherLinkService).createVoucher(any());
    }

    @Test
    void shouldFailTransferWhenVoucherCreationFails() {
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinBankAccountMapper bankAccountMapper = mock(FinBankAccountMapper.class);
        FinCashAccountMapper cashAccountMapper = mock(FinCashAccountMapper.class);
        FinInternalTransferMapper transferMapper = mock(FinInternalTransferMapper.class);
        BizVoucherLinkService bizVoucherLinkService = mock(BizVoucherLinkService.class);

        FinBankAccountDO from = new FinBankAccountDO();
        from.setId(10L);
        from.setBookId(1L);
        from.setCurrentBalance(new BigDecimal("100.00"));
        from.setStatus("ENABLE");
        from.setSubjectId(1001L);
        FinCashAccountDO to = new FinCashAccountDO();
        to.setId(20L);
        to.setBookId(1L);
        to.setCurrentBalance(new BigDecimal("5.00"));
        to.setStatus("ENABLE");
        to.setSubjectId(1002L);

        when(bankAccountMapper.selectById(10L)).thenReturn(from);
        when(bankAccountMapper.selectById(20L)).thenReturn(null);
        when(cashAccountMapper.selectById(20L)).thenReturn(to);

        FinPeriodDO period = new FinPeriodDO();
        period.setId(3L);
        period.setBookId(1L);
        period.setStartDate(LocalDate.of(2026, 3, 1));
        period.setEndDate(LocalDate.of(2026, 3, 31));
        period.setCloseStatus("OPEN");
        when(periodMapper.selectOne(any())).thenReturn(period);

        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);
        FinSubjectDO fromSubject = new FinSubjectDO();
        fromSubject.setId(1001L);
        fromSubject.setBookId(1L);
        fromSubject.setEnableFlag(1);
        FinSubjectDO toSubject = new FinSubjectDO();
        toSubject.setId(1002L);
        toSubject.setBookId(1L);
        toSubject.setEnableFlag(1);
        when(subjectMapper.selectById(1001L)).thenReturn(fromSubject);
        when(subjectMapper.selectById(1002L)).thenReturn(toSubject);

        when(bizVoucherLinkService.createVoucher(any())).thenThrow(new IllegalStateException("鍑瘉鐢熸垚澶辫触"));

        FinanceFundsService service = service(
                mock(FinBookMapper.class),
                periodMapper,
                mock(FinVoucherMapper.class),
                subjectMapper,
                bankAccountMapper,
                cashAccountMapper,
                mock(FinBankJournalMapper.class),
                mock(FinCashJournalMapper.class),
                transferMapper,
                mock(FinReconciliationMapper.class),
                mock(FinPeriodCloseMapper.class),
                mock(FinPeriodCloseCheckMapper.class),
                mock(FinPeriodReopenLogMapper.class),
                mock(FinPeriodOperationLogMapper.class) ,
                bizVoucherLinkService
        );

        InternalTransferReqVO reqVO = new InternalTransferReqVO();
        reqVO.setFromAccountId(10L);
        reqVO.setToAccountId(20L);
        reqVO.setAmount(new BigDecimal("20.00"));
        reqVO.setTxnDate(LocalDate.of(2026, 3, 18));

        assertThrows(IllegalStateException.class, () -> service.createInternalTransfer(reqVO));
        verify(transferMapper, never()).updateById(any(FinInternalTransferDO.class));
    }

    @Test
    void shouldRejectTransferWhenSubjectMappingMissing() {
        FinBankAccountMapper bankAccountMapper = mock(FinBankAccountMapper.class);
        FinCashAccountMapper cashAccountMapper = mock(FinCashAccountMapper.class);

        FinBankAccountDO from = new FinBankAccountDO();
        from.setId(10L);
        from.setBookId(1L);
        from.setCurrentBalance(new BigDecimal("100.00"));
        from.setStatus("ENABLE");
        from.setSubjectId(null);

        FinCashAccountDO to = new FinCashAccountDO();
        to.setId(20L);
        to.setBookId(1L);
        to.setCurrentBalance(new BigDecimal("5.00"));
        to.setStatus("ENABLE");
        to.setSubjectId(1002L);

        when(bankAccountMapper.selectById(10L)).thenReturn(from);
        when(bankAccountMapper.selectById(20L)).thenReturn(null);
        when(cashAccountMapper.selectById(20L)).thenReturn(to);

        FinanceFundsService service = service(
                mock(FinBookMapper.class),
                mock(FinPeriodMapper.class),
                mock(FinVoucherMapper.class),
                mock(FinSubjectMapper.class),
                bankAccountMapper,
                cashAccountMapper,
                mock(FinBankJournalMapper.class),
                mock(FinCashJournalMapper.class),
                mock(FinInternalTransferMapper.class),
                mock(FinReconciliationMapper.class),
                mock(FinPeriodCloseMapper.class),
                mock(FinPeriodCloseCheckMapper.class),
                mock(FinPeriodReopenLogMapper.class),
                mock(FinPeriodOperationLogMapper.class),
                mock(BizVoucherLinkService.class)
        );

        InternalTransferReqVO reqVO = new InternalTransferReqVO();
        reqVO.setFromAccountId(10L);
        reqVO.setToAccountId(20L);
        reqVO.setAmount(new BigDecimal("20.00"));
        reqVO.setTxnDate(LocalDate.of(2026, 3, 18));

        assertThrows(IllegalArgumentException.class, () -> service.createInternalTransfer(reqVO));
    }

    @Test
    void shouldRejectDeleteTransferWhenVoucherStillExists() {
        FinInternalTransferMapper transferMapper = mock(FinInternalTransferMapper.class);
        FinVoucherMapper voucherMapper = mock(FinVoucherMapper.class);

        FinInternalTransferDO transfer = new FinInternalTransferDO();
        transfer.setId(88L);
        transfer.setBookId(1L);
        transfer.setVoucherId(900L);
        transfer.setStatus("SUCCESS");
        when(transferMapper.selectById(88L)).thenReturn(transfer);

        FinVoucherDO voucher = new FinVoucherDO();
        voucher.setId(900L);
        voucher.setBookId(1L);
        when(voucherMapper.selectById(900L)).thenReturn(voucher);

        FinanceFundsService service = service(
                mock(FinBookMapper.class),
                mock(FinPeriodMapper.class),
                voucherMapper,
                mock(FinSubjectMapper.class),
                mock(FinBankAccountMapper.class),
                mock(FinCashAccountMapper.class),
                mock(FinBankJournalMapper.class),
                mock(FinCashJournalMapper.class),
                transferMapper,
                mock(FinReconciliationMapper.class),
                mock(FinPeriodCloseMapper.class),
                mock(FinPeriodCloseCheckMapper.class),
                mock(FinPeriodReopenLogMapper.class),
                mock(FinPeriodOperationLogMapper.class),
                mock(BizVoucherLinkService.class)
        );

        assertThrows(IllegalStateException.class, () -> service.deleteInternalTransfer(88L, 7L));
        verify(transferMapper, never()).updateById(any(FinInternalTransferDO.class));
    }

    @Test
    void shouldRejectJournalWhenAccountDisabled() {
        FinBankAccountMapper bankAccountMapper = mock(FinBankAccountMapper.class);

        FinBankAccountDO account = new FinBankAccountDO();
        account.setId(10L);
        account.setBookId(1L);
        account.setCurrentBalance(new BigDecimal("100.00"));
        account.setStatus("DISABLE");
        when(bankAccountMapper.selectById(10L)).thenReturn(account);

        FinanceFundsService service = service(
                mock(FinBookMapper.class),
                mock(FinPeriodMapper.class),
                mock(FinVoucherMapper.class),
                mock(FinSubjectMapper.class),
                bankAccountMapper,
                mock(FinCashAccountMapper.class),
                mock(FinBankJournalMapper.class),
                mock(FinCashJournalMapper.class),
                mock(FinInternalTransferMapper.class),
                mock(FinReconciliationMapper.class),
                mock(FinPeriodCloseMapper.class),
                mock(FinPeriodCloseCheckMapper.class),
                mock(FinPeriodReopenLogMapper.class),
                mock(FinPeriodOperationLogMapper.class),
                mock(BizVoucherLinkService.class)
        );

        JournalCreateReqVO reqVO = new JournalCreateReqVO();
        reqVO.setAccountId(10L);
        reqVO.setTxnDate(LocalDate.of(2026, 3, 18));
        reqVO.setDirection("INCOME");
        reqVO.setAmount(new BigDecimal("10.00"));

        assertThrows(IllegalStateException.class, () -> service.createBankJournal(reqVO));
    }

    @Test
    void shouldRejectJournalWriteWhenPeriodClosed() {
        FinBankAccountMapper bankAccountMapper = mock(FinBankAccountMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinBankJournalMapper bankJournalMapper = mock(FinBankJournalMapper.class);

        FinBankAccountDO account = new FinBankAccountDO();
        account.setId(10L);
        account.setBookId(1L);
        account.setCurrentBalance(new BigDecimal("100.00"));
        account.setStatus("ENABLE");
        when(bankAccountMapper.selectById(10L)).thenReturn(account);

        FinPeriodDO closedPeriod = new FinPeriodDO();
        closedPeriod.setId(3L);
        closedPeriod.setBookId(1L);
        closedPeriod.setStartDate(LocalDate.of(2026, 3, 1));
        closedPeriod.setEndDate(LocalDate.of(2026, 3, 31));
        closedPeriod.setCloseStatus("CLOSED");
        when(periodMapper.selectOne(any())).thenReturn(closedPeriod);

        FinanceFundsService service = service(
                mock(FinBookMapper.class),
                periodMapper,
                mock(FinVoucherMapper.class),
                mock(FinSubjectMapper.class),
                bankAccountMapper,
                mock(FinCashAccountMapper.class),
                bankJournalMapper,
                mock(FinCashJournalMapper.class),
                mock(FinInternalTransferMapper.class),
                mock(FinReconciliationMapper.class),
                mock(FinPeriodCloseMapper.class),
                mock(FinPeriodCloseCheckMapper.class),
                mock(FinPeriodReopenLogMapper.class),
                mock(FinPeriodOperationLogMapper.class),
                mock(BizVoucherLinkService.class)
        );

        JournalCreateReqVO reqVO = new JournalCreateReqVO();
        reqVO.setAccountId(10L);
        reqVO.setTxnDate(LocalDate.of(2026, 3, 18));
        reqVO.setDirection("INCOME");
        reqVO.setAmount(new BigDecimal("10.00"));

        assertThrows(IllegalStateException.class, () -> service.createBankJournal(reqVO));
        verify(bankJournalMapper, never()).insert(any(com.agriculture.villagefinance.module.finance.dal.dataobject.FinBankJournalDO.class));
    }

    @Test
    void shouldRejectTransferWhenPeriodClosed() {
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinBankAccountMapper bankAccountMapper = mock(FinBankAccountMapper.class);
        FinCashAccountMapper cashAccountMapper = mock(FinCashAccountMapper.class);
        BizVoucherLinkService bizVoucherLinkService = mock(BizVoucherLinkService.class);

        FinBankAccountDO from = new FinBankAccountDO();
        from.setId(10L);
        from.setBookId(1L);
        from.setCurrentBalance(new BigDecimal("100.00"));
        from.setStatus("ENABLE");
        from.setSubjectId(1001L);
        FinCashAccountDO to = new FinCashAccountDO();
        to.setId(20L);
        to.setBookId(1L);
        to.setCurrentBalance(new BigDecimal("5.00"));
        to.setStatus("ENABLE");
        to.setSubjectId(1002L);

        when(bankAccountMapper.selectById(10L)).thenReturn(from);
        when(bankAccountMapper.selectById(20L)).thenReturn(null);
        when(cashAccountMapper.selectById(20L)).thenReturn(to);
        when(cashAccountMapper.selectById(10L)).thenReturn(null);

        FinPeriodDO closedPeriod = new FinPeriodDO();
        closedPeriod.setId(3L);
        closedPeriod.setBookId(1L);
        closedPeriod.setStartDate(LocalDate.of(2026, 3, 1));
        closedPeriod.setEndDate(LocalDate.of(2026, 3, 31));
        closedPeriod.setCloseStatus("CLOSED");
        when(periodMapper.selectOne(any())).thenReturn(closedPeriod);

        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);
        FinSubjectDO fromSubject = new FinSubjectDO();
        fromSubject.setId(1001L);
        fromSubject.setBookId(1L);
        fromSubject.setEnableFlag(1);
        FinSubjectDO toSubject = new FinSubjectDO();
        toSubject.setId(1002L);
        toSubject.setBookId(1L);
        toSubject.setEnableFlag(1);
        when(subjectMapper.selectById(1001L)).thenReturn(fromSubject);
        when(subjectMapper.selectById(1002L)).thenReturn(toSubject);

        FinanceFundsService service = service(
                mock(FinBookMapper.class),
                periodMapper,
                mock(FinVoucherMapper.class),
                subjectMapper,
                bankAccountMapper,
                cashAccountMapper,
                mock(FinBankJournalMapper.class),
                mock(FinCashJournalMapper.class),
                mock(FinInternalTransferMapper.class),
                mock(FinReconciliationMapper.class),
                mock(FinPeriodCloseMapper.class),
                mock(FinPeriodCloseCheckMapper.class),
                mock(FinPeriodReopenLogMapper.class),
                mock(FinPeriodOperationLogMapper.class) ,
                bizVoucherLinkService
        );

        InternalTransferReqVO reqVO = new InternalTransferReqVO();
        reqVO.setFromAccountId(10L);
        reqVO.setToAccountId(20L);
        reqVO.setAmount(new BigDecimal("20.00"));
        reqVO.setTxnDate(LocalDate.of(2026, 3, 18));

        assertThrows(IllegalStateException.class, () -> service.createInternalTransfer(reqVO));
        verify(bizVoucherLinkService, never()).createVoucher(any());
    }

    @Test
    void shouldAllowWriteAfterReopenPeriod() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);
        FinPeriodReopenLogMapper reopenLogMapper = mock(FinPeriodReopenLogMapper.class);
        FinPeriodOperationLogMapper opLogMapper = mock(FinPeriodOperationLogMapper.class);
        FinBankAccountMapper bankAccountMapper = mock(FinBankAccountMapper.class);
        FinBankJournalMapper bankJournalMapper = mock(FinBankJournalMapper.class);

        FinBookDO book = new FinBookDO();
        book.setId(1L);
        when(bookMapper.selectById(1L)).thenReturn(book);

        FinPeriodDO period = new FinPeriodDO();
        period.setId(3L);
        period.setBookId(1L);
        period.setCloseStatus("CLOSED");
        when(periodMapper.selectById(3L)).thenReturn(period);
        when(periodMapper.selectOne(any())).thenReturn(period);
        doAnswer(invocation -> {
            com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodReopenLogDO log = invocation.getArgument(0);
            log.setId(66L);
            return 1;
        }).when(reopenLogMapper).insert(any(com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodReopenLogDO.class));

        FinBankAccountDO account = new FinBankAccountDO();
        account.setId(10L);
        account.setBookId(1L);
        account.setCurrentBalance(new BigDecimal("100.00"));
        account.setStatus("ENABLE");
        when(bankAccountMapper.selectById(10L)).thenReturn(account);
        doAnswer(invocation -> {
            com.agriculture.villagefinance.module.finance.dal.dataobject.FinBankJournalDO journal = invocation.getArgument(0);
            journal.setId(99L);
            return 1;
        }).when(bankJournalMapper).insert(any(com.agriculture.villagefinance.module.finance.dal.dataobject.FinBankJournalDO.class));

        FinanceFundsService service = service(
                bookMapper,
                periodMapper,
                mock(FinVoucherMapper.class),
                mock(FinSubjectMapper.class),
                bankAccountMapper,
                mock(FinCashAccountMapper.class),
                bankJournalMapper,
                mock(FinCashJournalMapper.class),
                mock(FinInternalTransferMapper.class),
                mock(FinReconciliationMapper.class),
                mock(FinPeriodCloseMapper.class),
                mock(FinPeriodCloseCheckMapper.class),
                reopenLogMapper,
                opLogMapper,
                mock(BizVoucherLinkService.class)
        );

        PeriodReopenReqVO reopenReqVO = new PeriodReopenReqVO();
        reopenReqVO.setLedgerId(1L);
        reopenReqVO.setPeriodId(3L);
        reopenReqVO.setOperatorId(8L);
        reopenReqVO.setReason("杈圭晫鍥炲綊娴嬭瘯");
        service.reopenPeriod(reopenReqVO);

        JournalCreateReqVO journalReqVO = new JournalCreateReqVO();
        journalReqVO.setAccountId(10L);
        journalReqVO.setTxnDate(LocalDate.of(2026, 3, 18));
        journalReqVO.setDirection("INCOME");
        journalReqVO.setAmount(new BigDecimal("10.00"));
        JournalListRespVO respVO = service.createBankJournal(journalReqVO);

        assertEquals(99L, respVO.getJournalId());
    }

    @Test
    void shouldRejectInvalidMonthCloseStateTransition() {
        FinBookMapper bookMapper = mock(FinBookMapper.class);
        FinPeriodMapper periodMapper = mock(FinPeriodMapper.class);

        FinBookDO book = new FinBookDO();
        book.setId(1L);
        when(bookMapper.selectById(1L)).thenReturn(book);

        FinPeriodDO closedPeriod = new FinPeriodDO();
        closedPeriod.setId(3L);
        closedPeriod.setBookId(1L);
        closedPeriod.setCloseStatus("CLOSED");
        when(periodMapper.selectById(3L)).thenReturn(closedPeriod);

        FinanceFundsService service = service(
                bookMapper,
                periodMapper,
                mock(FinVoucherMapper.class),
                mock(FinSubjectMapper.class),
                mock(FinBankAccountMapper.class),
                mock(FinCashAccountMapper.class),
                mock(FinBankJournalMapper.class),
                mock(FinCashJournalMapper.class),
                mock(FinInternalTransferMapper.class),
                mock(FinReconciliationMapper.class),
                mock(FinPeriodCloseMapper.class),
                mock(FinPeriodCloseCheckMapper.class),
                mock(FinPeriodReopenLogMapper.class),
                mock(FinPeriodOperationLogMapper.class),
                mock(BizVoucherLinkService.class)
        );

        PeriodCloseReqVO reqVO = new PeriodCloseReqVO();
        reqVO.setLedgerId(1L);
        reqVO.setPeriodId(3L);

        assertThrows(IllegalStateException.class, () -> service.closePeriod(reqVO));
    }

    private static FinanceFundsService service(FinBookMapper bookMapper,
                                               FinPeriodMapper periodMapper,
                                               FinVoucherMapper voucherMapper,
                                               FinSubjectMapper subjectMapper,
                                               FinBankAccountMapper bankAccountMapper,
                                               FinCashAccountMapper cashAccountMapper,
                                               FinBankJournalMapper bankJournalMapper,
                                               FinCashJournalMapper cashJournalMapper,
                                               FinInternalTransferMapper transferMapper,
                                               FinReconciliationMapper reconciliationMapper,
                                               FinPeriodCloseMapper closeMapper,
                                               FinPeriodCloseCheckMapper closeCheckMapper,
                                               FinPeriodReopenLogMapper reopenLogMapper,
                                               FinPeriodOperationLogMapper opLogMapper,
                                               BizVoucherLinkService bizVoucherLinkService) {
        return new FinanceFundsServiceImpl(
                bookMapper,
                periodMapper,
                voucherMapper,
                subjectMapper,
                bankAccountMapper,
                cashAccountMapper,
                bankJournalMapper,
                cashJournalMapper,
                transferMapper,
                reconciliationMapper,
                closeMapper,
                closeCheckMapper,
                reopenLogMapper,
                opLogMapper ,
                bizVoucherLinkService
        );
    }
}

