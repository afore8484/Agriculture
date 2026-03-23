package com.agriculture.villagefinance.module.finance.service;

import com.agriculture.villagefinance.module.finance.controller.vo.ContractAcceptanceCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractAttachmentCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractChangeCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractPaymentCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractRenewalCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractTerminationCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.JournalListRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherActionRespVO;
import com.agriculture.villagefinance.module.finance.constant.FinanceVoucherType;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinBankAccountDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinBankJournalDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinBookDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinCashAccountDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinCashJournalDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinContractAcceptanceDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinContractAttachmentDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinContractChangeDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinContractMainDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinContractOperationLogDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinContractPaymentDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinContractRenewalDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinContractTerminationDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinSubjectDO;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinBankAccountMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinBankJournalMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinBookMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinCashAccountMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinCashJournalMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinContractAcceptanceMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinContractAttachmentMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinContractChangeMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinContractMainMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinContractOperationLogMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinContractPaymentMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinContractRenewalMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinContractTerminationMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinSubjectMapper;
import com.agriculture.villagefinance.module.finance.service.BizVoucherLinkService;
import com.agriculture.villagefinance.module.finance.service.dto.BizVoucherCreateCmd;
import com.agriculture.villagefinance.module.finance.service.impl.FinanceContractServiceImpl;
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

class FinanceContractServiceImplTest {

    @Test
    void shouldCreateContractMain() {
        TestContext c = newContext();
        mockLedger(c);
        when(c.contractMainMapper.selectCount(any())).thenReturn(0L);
        doAnswer(invocation -> {
            FinContractMainDO row = invocation.getArgument(0);
            row.setId(100L);
            return 1;
        }).when(c.contractMainMapper).insert(any(FinContractMainDO.class));

        ContractCreateReqVO reqVO = new ContractCreateReqVO();
        reqVO.setContractNo("CT-001");
        reqVO.setContractName("Road Repair");
        reqVO.setContractType("PROCUREMENT");
        reqVO.setContractAmount(new BigDecimal("100000.00"));
        reqVO.setSignDate(LocalDate.of(2026, 3, 1));
        reqVO.setStartDate(LocalDate.of(2026, 3, 2));
        reqVO.setEndDate(LocalDate.of(2026, 12, 31));
        reqVO.setOrgId(10L);
        reqVO.setLedgerId(1L);
        reqVO.setOperatorId(99L);

        assertEquals(100L, c.service.createContract(reqVO).getContractId());
    }

    @Test
    void shouldRejectDeleteContractWhenBusinessExists() {
        TestContext c = newContext();
        mockActiveContract(c, "NORMAL");
        when(c.changeMapper.selectCount(any())).thenReturn(1L);

        assertThrows(IllegalStateException.class, () -> c.service.deleteContract(100L, 9L));
        verify(c.contractMainMapper, never()).updateById(any(FinContractMainDO.class));
    }

    @Test
    void shouldCreateContractChange() {
        TestContext c = newContext();
        FinContractMainDO contract = mockActiveContract(c, "NORMAL");
        doAnswer(invocation -> {
            FinContractChangeDO row = invocation.getArgument(0);
            row.setId(201L);
            return 1;
        }).when(c.changeMapper).insert(any(FinContractChangeDO.class));

        ContractChangeCreateReqVO reqVO = new ContractChangeCreateReqVO();
        reqVO.setContractId(100L);
        reqVO.setChangeType("AMOUNT");
        reqVO.setChangeDate(LocalDate.of(2026, 3, 10));
        reqVO.setAfterAmount(new BigDecimal("120000.00"));
        reqVO.setOperatorId(9L);

        assertEquals(201L, c.service.createChange(reqVO).getChangeId());
        ArgumentCaptor<FinContractMainDO> captor = ArgumentCaptor.forClass(FinContractMainDO.class);
        verify(c.contractMainMapper).updateById(captor.capture());
        assertEquals(new BigDecimal("120000.00"), captor.getValue().getContractAmount());
        assertEquals(contract.getId(), captor.getValue().getId());
    }

    @Test
    void shouldCreateContractAcceptance() {
        TestContext c = newContext();
        mockActiveContract(c, "NORMAL");
        doAnswer(invocation -> {
            FinContractAcceptanceDO row = invocation.getArgument(0);
            row.setId(301L);
            return 1;
        }).when(c.acceptanceMapper).insert(any(FinContractAcceptanceDO.class));

        ContractAcceptanceCreateReqVO reqVO = new ContractAcceptanceCreateReqVO();
        reqVO.setContractId(100L);
        reqVO.setAcceptanceDate(LocalDate.of(2026, 3, 20));
        reqVO.setAcceptanceAmount(new BigDecimal("120000.00"));
        reqVO.setAcceptanceResult("PASS");
        reqVO.setOperatorId(9L);

        assertEquals(301L, c.service.createAcceptance(reqVO).getAcceptanceId());
    }

    @Test
    void shouldCreateContractTermination() {
        TestContext c = newContext();
        mockActiveContract(c, "NORMAL");
        when(c.terminationMapper.selectCount(any())).thenReturn(0L);
        doAnswer(invocation -> {
            FinContractTerminationDO row = invocation.getArgument(0);
            row.setId(401L);
            return 1;
        }).when(c.terminationMapper).insert(any(FinContractTerminationDO.class));

        ContractTerminationCreateReqVO reqVO = new ContractTerminationCreateReqVO();
        reqVO.setContractId(100L);
        reqVO.setTerminationDate(LocalDate.of(2026, 4, 1));
        reqVO.setTerminationType("MUTUAL");
        reqVO.setSettlementAmount(new BigDecimal("1000.00"));
        reqVO.setOperatorId(9L);

        assertEquals(401L, c.service.createTermination(reqVO).getTerminationId());
    }

    @Test
    void shouldCreateContractRenewal() {
        TestContext c = newContext();
        mockActiveContract(c, "TERMINATED");
        when(c.renewalMapper.selectCount(any())).thenReturn(0L);
        doAnswer(invocation -> {
            FinContractRenewalDO row = invocation.getArgument(0);
            row.setId(501L);
            return 1;
        }).when(c.renewalMapper).insert(any(FinContractRenewalDO.class));

        ContractRenewalCreateReqVO reqVO = new ContractRenewalCreateReqVO();
        reqVO.setContractId(100L);
        reqVO.setRenewalDate(LocalDate.of(2026, 4, 2));
        reqVO.setRenewalStartDate(LocalDate.of(2026, 4, 2));
        reqVO.setRenewalEndDate(LocalDate.of(2027, 4, 1));
        reqVO.setRenewalAmount(new BigDecimal("90000.00"));
        reqVO.setOperatorId(9L);

        assertEquals(501L, c.service.createRenewal(reqVO).getRenewalId());
    }

    @Test
    void shouldUploadAttachmentAndLog() {
        TestContext c = newContext();
        mockActiveContract(c, "NORMAL");
        doAnswer(invocation -> {
            FinContractAttachmentDO row = invocation.getArgument(0);
            row.setId(601L);
            return 1;
        }).when(c.attachmentMapper).insert(any(FinContractAttachmentDO.class));

        ContractAttachmentCreateReqVO reqVO = new ContractAttachmentCreateReqVO();
        reqVO.setContractId(100L);
        reqVO.setFileName("scan.pdf");
        reqVO.setFileUrl("https://files/scan.pdf");
        reqVO.setOperatorId(9L);

        assertEquals(601L, c.service.createAttachment(reqVO).getAttachmentId());
        verify(c.logMapper).insert(any(FinContractOperationLogDO.class));
    }

    @Test
    void shouldCreateContractReceipt() {
        TestContext c = newContext();
        mockActiveContract(c, "NORMAL");
        mockOpenPeriod(c);
        mockBankAccount(c);
        mockSubject(c, 2001L);
        mockSubject(c, 2201L);
        mockReceiptFlow(c, 7001L, 9001L, 8001L);

        ContractPaymentCreateReqVO reqVO = new ContractPaymentCreateReqVO();
        reqVO.setContractId(100L);
        reqVO.setPaymentDate(LocalDate.of(2026, 3, 25));
        reqVO.setAmount(new BigDecimal("2000.00"));
        reqVO.setBankAccountId(3001L);
        reqVO.setCounterpartySubjectId(2201L);
        reqVO.setOperatorId(9L);

        assertEquals(7001L, c.service.createReceipt(reqVO).getPaymentId());
    }

    @Test
    void shouldCreateContractPayment() {
        TestContext c = newContext();
        mockActiveContract(c, "NORMAL");
        mockOpenPeriod(c);
        mockCashAccount(c);
        mockSubject(c, 1001L);
        mockSubject(c, 6601L);
        mockPaymentFlow(c, 7002L, 9002L, 8002L);

        ContractPaymentCreateReqVO reqVO = new ContractPaymentCreateReqVO();
        reqVO.setContractId(100L);
        reqVO.setPaymentDate(LocalDate.of(2026, 3, 26));
        reqVO.setAmount(new BigDecimal("1200.00"));
        reqVO.setCashAccountId(4001L);
        reqVO.setCounterpartySubjectId(6601L);
        reqVO.setOperatorId(9L);

        assertEquals(7002L, c.service.createPayment(reqVO).getPaymentId());
    }

    @Test
    void shouldLinkContractReceiptVoucher() {
        TestContext c = newContext();
        mockActiveContract(c, "NORMAL");
        mockOpenPeriod(c);
        mockBankAccount(c);
        mockSubject(c, 2001L);
        mockSubject(c, 2201L);
        mockReceiptFlow(c, 7101L, 9101L, 8101L);

        ContractPaymentCreateReqVO reqVO = new ContractPaymentCreateReqVO();
        reqVO.setContractId(100L);
        reqVO.setPaymentDate(LocalDate.of(2026, 3, 25));
        reqVO.setAmount(new BigDecimal("3000.00"));
        reqVO.setBankAccountId(3001L);
        reqVO.setCounterpartySubjectId(2201L);

        c.service.createReceipt(reqVO);
        ArgumentCaptor<BizVoucherCreateCmd> cmdCaptor = ArgumentCaptor.forClass(BizVoucherCreateCmd.class);
        verify(c.bizVoucherLinkService).createVoucher(cmdCaptor.capture());
        assertEquals(FinanceVoucherType.CONTRACT_RECEIPT, cmdCaptor.getValue().getVoucherType());

        ArgumentCaptor<FinContractPaymentDO> paymentCaptor = ArgumentCaptor.forClass(FinContractPaymentDO.class);
        verify(c.paymentMapper).updateById(paymentCaptor.capture());
        FinContractPaymentDO updated = paymentCaptor.getValue();
        assertEquals(8101L, updated.getVoucherId());
        assertEquals(9101L, updated.getJournalId());
    }

    @Test
    void shouldLinkContractPaymentVoucher() {
        TestContext c = newContext();
        mockActiveContract(c, "NORMAL");
        mockOpenPeriod(c);
        mockCashAccount(c);
        mockSubject(c, 1001L);
        mockSubject(c, 6601L);
        mockPaymentFlow(c, 7201L, 9201L, 8201L);

        ContractPaymentCreateReqVO reqVO = new ContractPaymentCreateReqVO();
        reqVO.setContractId(100L);
        reqVO.setPaymentDate(LocalDate.of(2026, 3, 26));
        reqVO.setAmount(new BigDecimal("1800.00"));
        reqVO.setCashAccountId(4001L);
        reqVO.setCounterpartySubjectId(6601L);

        c.service.createPayment(reqVO);
        ArgumentCaptor<BizVoucherCreateCmd> cmdCaptor = ArgumentCaptor.forClass(BizVoucherCreateCmd.class);
        verify(c.bizVoucherLinkService).createVoucher(cmdCaptor.capture());
        assertEquals(FinanceVoucherType.CONTRACT_PAYMENT, cmdCaptor.getValue().getVoucherType());

        ArgumentCaptor<FinContractPaymentDO> paymentCaptor = ArgumentCaptor.forClass(FinContractPaymentDO.class);
        verify(c.paymentMapper).updateById(paymentCaptor.capture());
        FinContractPaymentDO updated = paymentCaptor.getValue();
        assertEquals(8201L, updated.getVoucherId());
        assertEquals(9201L, updated.getJournalId());
    }

    @Test
    void shouldRejectContractWriteWhenPeriodClosed() {
        TestContext c = newContext();
        mockActiveContract(c, "NORMAL");
        mockClosedPeriod(c);
        mockBankAccount(c);
        mockSubject(c, 2001L);
        mockSubject(c, 2201L);

        ContractPaymentCreateReqVO reqVO = new ContractPaymentCreateReqVO();
        reqVO.setContractId(100L);
        reqVO.setPaymentDate(LocalDate.of(2026, 3, 27));
        reqVO.setAmount(new BigDecimal("1000.00"));
        reqVO.setBankAccountId(3001L);
        reqVO.setCounterpartySubjectId(2201L);

        assertThrows(IllegalStateException.class, () -> c.service.createReceipt(reqVO));
        verify(c.paymentMapper, never()).insert(any(FinContractPaymentDO.class));
    }

    @Test
    void shouldRejectDeleteContractWhenVoucherLinked() {
        TestContext c = newContext();
        mockActiveContract(c, "NORMAL");
        when(c.paymentMapper.selectCount(any())).thenReturn(1L);

        assertThrows(IllegalStateException.class, () -> c.service.deleteContract(100L, 9L));
        verify(c.contractMainMapper, never()).updateById(any(FinContractMainDO.class));
    }

    private static void mockLedger(TestContext c) {
        FinBookDO ledger = new FinBookDO();
        ledger.setId(1L);
        when(c.bookMapper.selectById(1L)).thenReturn(ledger);
    }

    private static void mockOpenPeriod(TestContext c) {
        FinPeriodDO period = new FinPeriodDO();
        period.setId(5001L);
        period.setBookId(1L);
        period.setCloseStatus("OPEN");
        when(c.periodMapper.selectOne(any())).thenReturn(period);
    }

    private static void mockClosedPeriod(TestContext c) {
        FinPeriodDO period = new FinPeriodDO();
        period.setId(5002L);
        period.setBookId(1L);
        period.setCloseStatus("CLOSED");
        when(c.periodMapper.selectOne(any())).thenReturn(period);
    }

    private static void mockSubject(TestContext c, Long subjectId) {
        FinSubjectDO subject = new FinSubjectDO();
        subject.setId(subjectId);
        subject.setBookId(1L);
        subject.setEnableFlag(1);
        when(c.subjectMapper.selectById(subjectId)).thenReturn(subject);
    }

    private static void mockBankAccount(TestContext c) {
        FinBankAccountDO account = new FinBankAccountDO();
        account.setId(3001L);
        account.setBookId(1L);
        account.setStatus("ENABLE");
        account.setSubjectId(2001L);
        when(c.bankAccountMapper.selectById(3001L)).thenReturn(account);
    }

    private static void mockCashAccount(TestContext c) {
        FinCashAccountDO account = new FinCashAccountDO();
        account.setId(4001L);
        account.setBookId(1L);
        account.setStatus("ENABLE");
        account.setSubjectId(1001L);
        when(c.cashAccountMapper.selectById(4001L)).thenReturn(account);
    }

    private static void mockReceiptFlow(TestContext c, Long paymentId, Long journalId, Long voucherId) {
        doAnswer(invocation -> {
            FinContractPaymentDO row = invocation.getArgument(0);
            row.setId(paymentId);
            return 1;
        }).when(c.paymentMapper).insert(any(FinContractPaymentDO.class));

        JournalListRespVO journalRespVO = new JournalListRespVO();
        journalRespVO.setJournalId(journalId);
        when(c.fundsService.createBankJournal(any())).thenReturn(journalRespVO);

        FinBankJournalDO journal = new FinBankJournalDO();
        journal.setId(journalId);
        when(c.bankJournalMapper.selectById(journalId)).thenReturn(journal);

        VoucherActionRespVO voucher = new VoucherActionRespVO();
        voucher.setVoucherId(voucherId);
        when(c.bizVoucherLinkService.createVoucher(any())).thenReturn(voucher);
    }

    private static void mockPaymentFlow(TestContext c, Long paymentId, Long journalId, Long voucherId) {
        doAnswer(invocation -> {
            FinContractPaymentDO row = invocation.getArgument(0);
            row.setId(paymentId);
            return 1;
        }).when(c.paymentMapper).insert(any(FinContractPaymentDO.class));

        JournalListRespVO journalRespVO = new JournalListRespVO();
        journalRespVO.setJournalId(journalId);
        when(c.fundsService.createCashJournal(any())).thenReturn(journalRespVO);

        FinCashJournalDO journal = new FinCashJournalDO();
        journal.setId(journalId);
        when(c.cashJournalMapper.selectById(journalId)).thenReturn(journal);

        VoucherActionRespVO voucher = new VoucherActionRespVO();
        voucher.setVoucherId(voucherId);
        when(c.bizVoucherLinkService.createVoucher(any())).thenReturn(voucher);
    }

    private static FinContractMainDO mockActiveContract(TestContext c, String status) {
        FinContractMainDO contract = new FinContractMainDO();
        contract.setId(100L);
        contract.setContractNo("CT-001");
        contract.setContractName("Road Repair");
        contract.setContractType("PROCUREMENT");
        contract.setContractAmount(new BigDecimal("100000.00"));
        contract.setSignDate(LocalDate.of(2026, 3, 1));
        contract.setStartDate(LocalDate.of(2026, 3, 2));
        contract.setEndDate(LocalDate.of(2026, 12, 31));
        contract.setBookId(1L);
        contract.setOrgId(10L);
        contract.setEnableFlag(1);
        contract.setStatus(status);
        when(c.contractMainMapper.selectById(100L)).thenReturn(contract);
        return contract;
    }

    private static TestContext newContext() {
        TestContext c = new TestContext();
        c.bookMapper = mock(FinBookMapper.class);
        c.contractMainMapper = mock(FinContractMainMapper.class);
        c.changeMapper = mock(FinContractChangeMapper.class);
        c.acceptanceMapper = mock(FinContractAcceptanceMapper.class);
        c.terminationMapper = mock(FinContractTerminationMapper.class);
        c.renewalMapper = mock(FinContractRenewalMapper.class);
        c.paymentMapper = mock(FinContractPaymentMapper.class);
        c.attachmentMapper = mock(FinContractAttachmentMapper.class);
        c.logMapper = mock(FinContractOperationLogMapper.class);
        c.periodMapper = mock(FinPeriodMapper.class);
        c.subjectMapper = mock(FinSubjectMapper.class);
        c.bankAccountMapper = mock(FinBankAccountMapper.class);
        c.cashAccountMapper = mock(FinCashAccountMapper.class);
        c.bankJournalMapper = mock(FinBankJournalMapper.class);
        c.cashJournalMapper = mock(FinCashJournalMapper.class);
        c.fundsService = mock(FinanceFundsService.class);
        c.bizVoucherLinkService = mock(BizVoucherLinkService.class);
        c.service = new FinanceContractServiceImpl(
                c.bookMapper,
                c.contractMainMapper,
                c.changeMapper,
                c.acceptanceMapper,
                c.terminationMapper,
                c.renewalMapper,
                c.paymentMapper,
                c.attachmentMapper,
                c.logMapper,
                c.periodMapper,
                c.subjectMapper,
                c.bankAccountMapper,
                c.cashAccountMapper,
                c.bankJournalMapper,
                c.cashJournalMapper,
                c.fundsService,
                c.bizVoucherLinkService
        );
        return c;
    }

    private static class TestContext {
        private FinanceContractService service;
        private FinBookMapper bookMapper;
        private FinContractMainMapper contractMainMapper;
        private FinContractChangeMapper changeMapper;
        private FinContractAcceptanceMapper acceptanceMapper;
        private FinContractTerminationMapper terminationMapper;
        private FinContractRenewalMapper renewalMapper;
        private FinContractPaymentMapper paymentMapper;
        private FinContractAttachmentMapper attachmentMapper;
        private FinContractOperationLogMapper logMapper;
        private FinPeriodMapper periodMapper;
        private FinSubjectMapper subjectMapper;
        private FinBankAccountMapper bankAccountMapper;
        private FinCashAccountMapper cashAccountMapper;
        private FinBankJournalMapper bankJournalMapper;
        private FinCashJournalMapper cashJournalMapper;
        private FinanceFundsService fundsService;
        private BizVoucherLinkService bizVoucherLinkService;
    }
}
