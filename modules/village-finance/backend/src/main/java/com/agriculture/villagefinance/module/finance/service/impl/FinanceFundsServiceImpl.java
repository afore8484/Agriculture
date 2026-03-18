package com.agriculture.villagefinance.module.finance.service.impl;

import com.agriculture.villagefinance.module.finance.controller.vo.BankAccountCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.BankAccountRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.BankAccountUpdateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.CashAccountCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.CashAccountRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.CashAccountUpdateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.InternalTransferReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.InternalTransferRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.JournalCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.JournalListRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.PendingVoucherRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.PeriodCloseReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.PeriodCloseRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.PeriodReopenReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.PeriodReopenRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ReconciliationRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.TrialBalanceRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherActionRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherEntryReqVO;
import com.agriculture.villagefinance.module.finance.constant.FinanceVoucherType;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinBankAccountDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinBankJournalDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinBookDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinCashAccountDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinCashJournalDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinInternalTransferDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodCloseCheckDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodCloseDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodOperationLogDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodReopenLogDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinReconciliationDO;
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
import com.agriculture.villagefinance.module.finance.service.BizVoucherLinkService;
import com.agriculture.villagefinance.module.finance.service.FinanceFundsService;
import com.agriculture.villagefinance.module.finance.service.dto.BizVoucherCreateCmd;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Locale;
import java.util.Objects;

@Service
@RequiredArgsConstructor
public class FinanceFundsServiceImpl implements FinanceFundsService {

    private static final String STATUS_ENABLE = "ENABLE";
    private static final String STATUS_AUDITED = "AUDITED";
    private static final String PERIOD_OPEN = "OPEN";
    private static final String PERIOD_CLOSED = "CLOSED";

    private final FinBookMapper finBookMapper;
    private final FinPeriodMapper finPeriodMapper;
    private final FinVoucherMapper finVoucherMapper;
    private final FinSubjectMapper finSubjectMapper;
    private final FinBankAccountMapper finBankAccountMapper;
    private final FinCashAccountMapper finCashAccountMapper;
    private final FinBankJournalMapper finBankJournalMapper;
    private final FinCashJournalMapper finCashJournalMapper;
    private final FinInternalTransferMapper finInternalTransferMapper;
    private final FinReconciliationMapper finReconciliationMapper;
    private final FinPeriodCloseMapper finPeriodCloseMapper;
    private final FinPeriodCloseCheckMapper finPeriodCloseCheckMapper;
    private final FinPeriodReopenLogMapper finPeriodReopenLogMapper;
    private final FinPeriodOperationLogMapper finPeriodOperationLogMapper;
    private final BizVoucherLinkService bizVoucherLinkService;

    @Override
    public List<CashAccountRespVO> getCashAccounts(Long ledgerId, String status) {
        requireLedger(ledgerId);
        LambdaQueryWrapper<FinCashAccountDO> wrapper = new LambdaQueryWrapper<FinCashAccountDO>()
                .eq(FinCashAccountDO::getBookId, ledgerId)
                .orderByAsc(FinCashAccountDO::getId);
        if (StringUtils.hasText(status)) {
            wrapper.eq(FinCashAccountDO::getStatus, status.trim().toUpperCase(Locale.ROOT));
        }
        return finCashAccountMapper.selectList(wrapper).stream().map(this::toCashAccountResp).toList();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CashAccountRespVO createCashAccount(CashAccountCreateReqVO reqVO) {
        requireLedger(reqVO.getLedgerId());
        requirePositiveAmount(reqVO.getInitBalance(), "initBalance必须大于等于0");
        requireSubject(reqVO.getSubjectId(), reqVO.getLedgerId());
        FinCashAccountDO account = new FinCashAccountDO();
        account.setBookId(reqVO.getLedgerId());
        account.setAccountName(reqVO.getAccountName().trim());
        account.setSubjectId(reqVO.getSubjectId());
        account.setInitBalance(reqVO.getInitBalance());
        account.setCurrentBalance(reqVO.getInitBalance());
        account.setStatus(STATUS_ENABLE);
        account.setRemark(reqVO.getRemark());
        account.setCreatedAt(LocalDateTime.now());
        account.setUpdatedAt(LocalDateTime.now());
        finCashAccountMapper.insert(account);
        return toCashAccountResp(account);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CashAccountRespVO updateCashAccount(Long accountId, CashAccountUpdateReqVO reqVO) {
        FinCashAccountDO account = requireCashAccount(accountId);
        requireSubject(reqVO.getSubjectId(), account.getBookId());
        account.setAccountName(reqVO.getAccountName().trim());
        account.setSubjectId(reqVO.getSubjectId());
        account.setRemark(reqVO.getRemark());
        account.setUpdatedAt(LocalDateTime.now());
        finCashAccountMapper.updateById(account);
        return toCashAccountResp(account);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CashAccountRespVO enableCashAccount(Long accountId) {
        return changeCashAccountStatus(accountId, STATUS_ENABLE);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CashAccountRespVO disableCashAccount(Long accountId) {
        return changeCashAccountStatus(accountId, "DISABLE");
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteCashAccount(Long accountId) {
        FinCashAccountDO account = requireCashAccount(accountId);
        rejectDeleteWhenAccountInUse("CASH", account.getId());
        finCashAccountMapper.deleteById(accountId);
    }

    @Override
    public List<BankAccountRespVO> getBankAccounts(Long ledgerId, String status) {
        requireLedger(ledgerId);
        LambdaQueryWrapper<FinBankAccountDO> wrapper = new LambdaQueryWrapper<FinBankAccountDO>()
                .eq(FinBankAccountDO::getBookId, ledgerId)
                .orderByAsc(FinBankAccountDO::getId);
        if (StringUtils.hasText(status)) {
            wrapper.eq(FinBankAccountDO::getStatus, status.trim().toUpperCase(Locale.ROOT));
        }
        return finBankAccountMapper.selectList(wrapper).stream().map(this::toBankAccountResp).toList();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public BankAccountRespVO createBankAccount(BankAccountCreateReqVO reqVO) {
        requireLedger(reqVO.getLedgerId());
        requirePositiveAmount(reqVO.getInitBalance(), "initBalance必须大于等于0");
        requireSubject(reqVO.getSubjectId(), reqVO.getLedgerId());
        FinBankAccountDO account = new FinBankAccountDO();
        account.setBookId(reqVO.getLedgerId());
        account.setAccountName(reqVO.getAccountName().trim());
        account.setBankName(reqVO.getBankName().trim());
        account.setAccountNo(reqVO.getAccountNo().trim());
        account.setSubjectId(reqVO.getSubjectId());
        account.setInitBalance(reqVO.getInitBalance());
        account.setCurrentBalance(reqVO.getInitBalance());
        account.setStatus(STATUS_ENABLE);
        account.setRemark(reqVO.getRemark());
        account.setCreatedAt(LocalDateTime.now());
        account.setUpdatedAt(LocalDateTime.now());
        finBankAccountMapper.insert(account);
        return toBankAccountResp(account);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public BankAccountRespVO updateBankAccount(Long accountId, BankAccountUpdateReqVO reqVO) {
        FinBankAccountDO account = requireBankAccount(accountId);
        requireSubject(reqVO.getSubjectId(), account.getBookId());
        account.setAccountName(reqVO.getAccountName().trim());
        account.setSubjectId(reqVO.getSubjectId());
        account.setRemark(reqVO.getRemark());
        account.setUpdatedAt(LocalDateTime.now());
        finBankAccountMapper.updateById(account);
        return toBankAccountResp(account);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public BankAccountRespVO enableBankAccount(Long accountId) {
        return changeBankAccountStatus(accountId, STATUS_ENABLE);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public BankAccountRespVO disableBankAccount(Long accountId) {
        return changeBankAccountStatus(accountId, "DISABLE");
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteBankAccount(Long accountId) {
        FinBankAccountDO account = requireBankAccount(accountId);
        rejectDeleteWhenAccountInUse("BANK", account.getId());
        finBankAccountMapper.deleteById(accountId);
    }

    @Override
    public List<JournalListRespVO> getBankJournals(Long accountId, LocalDate startDate, LocalDate endDate, Integer pageNum, Integer pageSize) {
        requireBankAccount(accountId);
        LambdaQueryWrapper<FinBankJournalDO> wrapper = new LambdaQueryWrapper<FinBankJournalDO>()
                .eq(FinBankJournalDO::getAccountId, accountId)
                .orderByDesc(FinBankJournalDO::getTxnDate)
                .orderByDesc(FinBankJournalDO::getId);
        if (startDate != null) {
            wrapper.ge(FinBankJournalDO::getTxnDate, startDate);
        }
        if (endDate != null) {
            wrapper.le(FinBankJournalDO::getTxnDate, endDate);
        }
        return applyPagination(finBankJournalMapper.selectList(wrapper), pageNum, pageSize).stream().map(this::toJournalResp).toList();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public JournalListRespVO createBankJournal(JournalCreateReqVO reqVO) {
        FinBankAccountDO account = requireBankAccount(reqVO.getAccountId());
        requireAccountEnabled(account.getStatus(), "账户已停用，禁止新增银行日记账");
        requireOpenPeriodByDate(account.getBookId(), reqVO.getTxnDate());
        JournalCalc calc = parseDirection(reqVO.getDirection(), reqVO.getAmount());
        account.setCurrentBalance(account.getCurrentBalance().add(calc.signedAmount()));
        account.setUpdatedAt(LocalDateTime.now());
        finBankAccountMapper.updateById(account);

        FinBankJournalDO journal = new FinBankJournalDO();
        journal.setAccountId(account.getId());
        journal.setTxnDate(reqVO.getTxnDate());
        journal.setSummary(reqVO.getSummary());
        journal.setDirection(calc.direction());
        journal.setAmount(reqVO.getAmount());
        journal.setIncomeAmount(calc.incomeAmount());
        journal.setExpenseAmount(calc.expenseAmount());
        journal.setBalance(account.getCurrentBalance());
        journal.setStatus("RECORDED");
        journal.setCreatedBy(reqVO.getOperatorId());
        journal.setCreatedAt(LocalDateTime.now());
        finBankJournalMapper.insert(journal);
        return toJournalResp(journal);
    }

    @Override
    public List<JournalListRespVO> getCashJournals(Long accountId, LocalDate startDate, LocalDate endDate, Integer pageNum, Integer pageSize) {
        requireCashAccount(accountId);
        LambdaQueryWrapper<FinCashJournalDO> wrapper = new LambdaQueryWrapper<FinCashJournalDO>()
                .eq(FinCashJournalDO::getAccountId, accountId)
                .orderByDesc(FinCashJournalDO::getTxnDate)
                .orderByDesc(FinCashJournalDO::getId);
        if (startDate != null) {
            wrapper.ge(FinCashJournalDO::getTxnDate, startDate);
        }
        if (endDate != null) {
            wrapper.le(FinCashJournalDO::getTxnDate, endDate);
        }
        return applyPagination(finCashJournalMapper.selectList(wrapper), pageNum, pageSize).stream().map(this::toJournalResp).toList();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public JournalListRespVO createCashJournal(JournalCreateReqVO reqVO) {
        FinCashAccountDO account = requireCashAccount(reqVO.getAccountId());
        requireAccountEnabled(account.getStatus(), "账户已停用，禁止新增现金日记账");
        requireOpenPeriodByDate(account.getBookId(), reqVO.getTxnDate());
        JournalCalc calc = parseDirection(reqVO.getDirection(), reqVO.getAmount());
        account.setCurrentBalance(account.getCurrentBalance().add(calc.signedAmount()));
        account.setUpdatedAt(LocalDateTime.now());
        finCashAccountMapper.updateById(account);

        FinCashJournalDO journal = new FinCashJournalDO();
        journal.setAccountId(account.getId());
        journal.setTxnDate(reqVO.getTxnDate());
        journal.setSummary(reqVO.getSummary());
        journal.setDirection(calc.direction());
        journal.setAmount(reqVO.getAmount());
        journal.setIncomeAmount(calc.incomeAmount());
        journal.setExpenseAmount(calc.expenseAmount());
        journal.setBalance(account.getCurrentBalance());
        journal.setStatus("RECORDED");
        journal.setCreatedBy(reqVO.getOperatorId());
        journal.setCreatedAt(LocalDateTime.now());
        finCashJournalMapper.insert(journal);
        return toJournalResp(journal);
    }

    @Override
    public List<InternalTransferRespVO> getInternalTransfers(Long fromAccountId, Long toAccountId, LocalDate startDate, LocalDate endDate) {
        LambdaQueryWrapper<FinInternalTransferDO> wrapper = new LambdaQueryWrapper<FinInternalTransferDO>()
                .orderByDesc(FinInternalTransferDO::getTxnDate)
                .orderByDesc(FinInternalTransferDO::getId);
        if (fromAccountId != null) {
            wrapper.eq(FinInternalTransferDO::getFromAccountId, fromAccountId);
        }
        if (toAccountId != null) {
            wrapper.eq(FinInternalTransferDO::getToAccountId, toAccountId);
        }
        if (startDate != null) {
            wrapper.ge(FinInternalTransferDO::getTxnDate, startDate);
        }
        if (endDate != null) {
            wrapper.le(FinInternalTransferDO::getTxnDate, endDate);
        }
        return finInternalTransferMapper.selectList(wrapper).stream().map(this::toTransferResp).toList();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public InternalTransferRespVO createInternalTransfer(InternalTransferReqVO reqVO) {
        if (reqVO.getAmount() == null || reqVO.getAmount().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("amount必须大于0");
        }
        if (Objects.equals(reqVO.getFromAccountId(), reqVO.getToAccountId())) {
            throw new IllegalArgumentException("转出和转入账户不能相同");
        }
        AccountRef from = requireAccount(reqVO.getFromAccountId());
        AccountRef to = requireAccount(reqVO.getToAccountId());
        if (!Objects.equals(from.bookId(), to.bookId())) {
            throw new IllegalArgumentException("内部转账仅支持同账套账户");
        }
        if (from.balance().compareTo(reqVO.getAmount()) < 0) {
            throw new IllegalArgumentException("转出账户余额不足");
        }
        if (!STATUS_ENABLE.equalsIgnoreCase(from.status()) || !STATUS_ENABLE.equalsIgnoreCase(to.status())) {
            throw new IllegalArgumentException("转账账户不可用");
        }
        if (from.subjectId() == null || to.subjectId() == null) {
            throw new IllegalArgumentException("账户缺少会计科目映射");
        }

        requireSubject(from.subjectId(), from.bookId());
        requireSubject(to.subjectId(), to.bookId());

        updateAccountBalance(from, reqVO.getAmount().negate());
        updateAccountBalance(to, reqVO.getAmount());

        FinInternalTransferDO transfer = new FinInternalTransferDO();
        transfer.setBookId(from.bookId());
        transfer.setFromAccountId(from.id());
        transfer.setFromAccountType(from.type());
        transfer.setToAccountId(to.id());
        transfer.setToAccountType(to.type());
        transfer.setTxnDate(reqVO.getTxnDate());
        transfer.setAmount(reqVO.getAmount());
        transfer.setStatus("SUCCESS");
        transfer.setOperatorId(reqVO.getOperatorId());
        transfer.setCreatedAt(LocalDateTime.now());
        transfer.setRemark(reqVO.getRemark());
        finInternalTransferMapper.insert(transfer);

        VoucherActionRespVO voucher = createTransferVoucher(transfer, from, to, reqVO);
        transfer.setVoucherId(voucher.getVoucherId());
        finInternalTransferMapper.updateById(transfer);

        writeTransferJournals(transfer, from, to, reqVO.getAmount(), reqVO.getTxnDate(), reqVO.getOperatorId());
        return toTransferResp(transfer);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public InternalTransferRespVO deleteInternalTransfer(Long transferId, Long operatorId) {
        FinInternalTransferDO transfer = finInternalTransferMapper.selectById(transferId);
        if (transfer == null) {
            throw new IllegalArgumentException("内部转账不存在");
        }
        if (transfer.getVoucherId() != null && finVoucherMapper.selectById(transfer.getVoucherId()) != null) {
            throw new IllegalStateException("内部转账已关联凭证，禁止删除");
        }
        transfer.setStatus("DELETED");
        transfer.setOperatorId(operatorId == null ? transfer.getOperatorId() : operatorId);
        finInternalTransferMapper.updateById(transfer);
        return toTransferResp(transfer);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public List<ReconciliationRespVO> getReconciliations(Long ledgerId, Long periodId, String accountType) {
        requireLedger(ledgerId);
        FinPeriodDO period = requirePeriod(periodId, ledgerId);
        String type = StringUtils.hasText(accountType) ? accountType.trim().toUpperCase(Locale.ROOT) : "BANK";

        finReconciliationMapper.delete(new LambdaQueryWrapper<FinReconciliationDO>()
                .eq(FinReconciliationDO::getBookId, ledgerId)
                .eq(FinReconciliationDO::getPeriodId, periodId)
                .eq(FinReconciliationDO::getAccountType, type));

        if ("BANK".equals(type)) {
            List<FinBankAccountDO> accounts = finBankAccountMapper.selectList(new LambdaQueryWrapper<FinBankAccountDO>()
                    .eq(FinBankAccountDO::getBookId, ledgerId)
                    .eq(FinBankAccountDO::getStatus, STATUS_ENABLE)
                    .orderByAsc(FinBankAccountDO::getId));
            for (FinBankAccountDO account : accounts) {
                BigDecimal journalDelta = bankJournalDelta(account.getId(), period.getStartDate(), period.getEndDate());
                saveReconciliation(ledgerId, periodId, "BANK", account.getId(), account.getAccountName(), account.getCurrentBalance(), account.getInitBalance().add(journalDelta));
            }
        } else if ("CASH".equals(type)) {
            List<FinCashAccountDO> accounts = finCashAccountMapper.selectList(new LambdaQueryWrapper<FinCashAccountDO>()
                    .eq(FinCashAccountDO::getBookId, ledgerId)
                    .eq(FinCashAccountDO::getStatus, STATUS_ENABLE)
                    .orderByAsc(FinCashAccountDO::getId));
            for (FinCashAccountDO account : accounts) {
                BigDecimal journalDelta = cashJournalDelta(account.getId(), period.getStartDate(), period.getEndDate());
                saveReconciliation(ledgerId, periodId, "CASH", account.getId(), account.getAccountName(), account.getCurrentBalance(), account.getInitBalance().add(journalDelta));
            }
        } else {
            throw new IllegalArgumentException("accountType仅支持BANK或CASH");
        }

        return finReconciliationMapper.selectList(new LambdaQueryWrapper<FinReconciliationDO>()
                        .eq(FinReconciliationDO::getBookId, ledgerId)
                        .eq(FinReconciliationDO::getPeriodId, periodId)
                        .eq(FinReconciliationDO::getAccountType, type)
                        .orderByAsc(FinReconciliationDO::getAccountId))
                .stream().map(this::toReconciliationResp).toList();
    }

    @Override
    public List<PendingVoucherRespVO> getPendingVouchers(Long ledgerId, Long periodId) {
        requireLedger(ledgerId);
        requirePeriod(periodId, ledgerId);
        return finVoucherMapper.selectList(new LambdaQueryWrapper<FinVoucherDO>()
                        .eq(FinVoucherDO::getBookId, ledgerId)
                        .eq(FinVoucherDO::getPeriodId, periodId)
                        .ne(FinVoucherDO::getStatus, STATUS_AUDITED)
                        .orderByAsc(FinVoucherDO::getVoucherDate)
                        .orderByAsc(FinVoucherDO::getId))
                .stream().map(this::toPendingVoucherResp).toList();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public TrialBalanceRespVO trialBalance(Long ledgerId, Long periodId, Long templateId) {
        requireLedger(ledgerId);
        requirePeriod(periodId, ledgerId);

        int pendingCount = countPendingVouchers(ledgerId, periodId);
        FinPeriodCloseCheckDO check = new FinPeriodCloseCheckDO();
        check.setCloseId(null);
        check.setBookId(ledgerId);
        check.setPeriodId(periodId);
        check.setCheckCode("PENDING_VOUCHER");
        check.setCheckName("未审核凭证检查");
        check.setCheckResult(pendingCount == 0 ? "PASS" : "FAIL");
        check.setErrorCount(pendingCount);
        check.setDetailJson("{\"templateId\":" + (templateId == null ? "null" : templateId) + "}");
        check.setCreatedAt(LocalDateTime.now());
        finPeriodCloseCheckMapper.insert(check);

        TrialBalanceRespVO resp = new TrialBalanceRespVO();
        resp.setTrialId(check.getId());
        resp.setCheckResult(check.getCheckResult());
        resp.setErrorCount(check.getErrorCount());
        return resp;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public PeriodCloseRespVO closePeriod(PeriodCloseReqVO reqVO) {
        requireLedger(reqVO.getLedgerId());
        FinPeriodDO period = requirePeriod(reqVO.getPeriodId(), reqVO.getLedgerId());
        if (PERIOD_CLOSED.equalsIgnoreCase(period.getCloseStatus())) {
            throw new IllegalStateException("当前期间已结账");
        }

        int pendingCount = countPendingVouchers(reqVO.getLedgerId(), reqVO.getPeriodId());
        if (pendingCount > 0) {
            throw new IllegalStateException("存在未审核凭证，禁止月结");
        }

        period.setCloseStatus(PERIOD_CLOSED);
        period.setCloseTime(LocalDateTime.now());
        period.setUpdatedAt(LocalDateTime.now());
        finPeriodMapper.updateById(period);

        FinPeriodCloseDO close = new FinPeriodCloseDO();
        close.setBookId(reqVO.getLedgerId());
        close.setPeriodId(reqVO.getPeriodId());
        close.setCloseNo(buildCloseNo(reqVO.getLedgerId(), reqVO.getPeriodId()));
        close.setCloseType(StringUtils.hasText(reqVO.getCloseType()) ? reqVO.getCloseType() : "MONTH");
        close.setCloseStatus("SUCCESS");
        close.setCloseTime(LocalDateTime.now());
        close.setPendingVoucherCount(0);
        close.setOperatorId(reqVO.getOperatorId());
        close.setRemark(reqVO.getRemark());
        finPeriodCloseMapper.insert(close);

        writePeriodOpLog(reqVO.getPeriodId(), "CLOSE", reqVO.getOperatorId(), PERIOD_OPEN, PERIOD_CLOSED, "执行月结");

        PeriodCloseRespVO resp = new PeriodCloseRespVO();
        resp.setCloseId(close.getId());
        resp.setCloseStatus(close.getCloseStatus());
        resp.setCloseTime(close.getCloseTime());
        return resp;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public PeriodReopenRespVO reopenPeriod(PeriodReopenReqVO reqVO) {
        requireLedger(reqVO.getLedgerId());
        FinPeriodDO period = requirePeriod(reqVO.getPeriodId(), reqVO.getLedgerId());
        if (!PERIOD_CLOSED.equalsIgnoreCase(period.getCloseStatus())) {
            throw new IllegalStateException("仅已结账期间允许反结账");
        }

        period.setCloseStatus(PERIOD_OPEN);
        period.setCloseTime(null);
        period.setUpdatedAt(LocalDateTime.now());
        finPeriodMapper.updateById(period);

        FinPeriodReopenLogDO logDO = new FinPeriodReopenLogDO();
        logDO.setBookId(reqVO.getLedgerId());
        logDO.setPeriodId(reqVO.getPeriodId());
        logDO.setReopenNo(buildReopenNo(reqVO.getLedgerId(), reqVO.getPeriodId()));
        logDO.setReason(reqVO.getReason());
        logDO.setOperatorId(reqVO.getOperatorId());
        logDO.setOperateTime(LocalDateTime.now());
        logDO.setPeriodStatus(PERIOD_OPEN);
        finPeriodReopenLogMapper.insert(logDO);

        writePeriodOpLog(reqVO.getPeriodId(), "REOPEN", reqVO.getOperatorId(), PERIOD_CLOSED, PERIOD_OPEN, "执行反结账");

        PeriodReopenRespVO resp = new PeriodReopenRespVO();
        resp.setReopenId(logDO.getId());
        resp.setPeriodStatus(logDO.getPeriodStatus());
        resp.setOperateTime(logDO.getOperateTime());
        return resp;
    }

    private void saveReconciliation(Long ledgerId, Long periodId, String accountType, Long accountId, String accountName,
                                    BigDecimal bookBalance, BigDecimal bankBalance) {
        FinReconciliationDO row = new FinReconciliationDO();
        row.setBookId(ledgerId);
        row.setPeriodId(periodId);
        row.setAccountType(accountType);
        row.setAccountId(accountId);
        row.setAccountName(accountName);
        row.setBookBalance(bookBalance);
        row.setBankBalance(bankBalance);
        row.setDiffAmount(bookBalance.subtract(bankBalance));
        row.setGeneratedAt(LocalDateTime.now());
        finReconciliationMapper.insert(row);
    }

    private BigDecimal bankJournalDelta(Long accountId, LocalDate startDate, LocalDate endDate) {
        List<FinBankJournalDO> journals = finBankJournalMapper.selectList(new LambdaQueryWrapper<FinBankJournalDO>()
                .eq(FinBankJournalDO::getAccountId, accountId)
                .ge(FinBankJournalDO::getTxnDate, startDate)
                .le(FinBankJournalDO::getTxnDate, endDate));
        return journals.stream().map(item -> item.getIncomeAmount().subtract(item.getExpenseAmount()))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    private BigDecimal cashJournalDelta(Long accountId, LocalDate startDate, LocalDate endDate) {
        List<FinCashJournalDO> journals = finCashJournalMapper.selectList(new LambdaQueryWrapper<FinCashJournalDO>()
                .eq(FinCashJournalDO::getAccountId, accountId)
                .ge(FinCashJournalDO::getTxnDate, startDate)
                .le(FinCashJournalDO::getTxnDate, endDate));
        return journals.stream().map(item -> item.getIncomeAmount().subtract(item.getExpenseAmount()))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    private int countPendingVouchers(Long ledgerId, Long periodId) {
        return Math.toIntExact(finVoucherMapper.selectCount(new LambdaQueryWrapper<FinVoucherDO>()
                .eq(FinVoucherDO::getBookId, ledgerId)
                .eq(FinVoucherDO::getPeriodId, periodId)
                .ne(FinVoucherDO::getStatus, STATUS_AUDITED)));
    }

    private String buildCloseNo(Long ledgerId, Long periodId) {
        long count = finPeriodCloseMapper.selectCount(new LambdaQueryWrapper<FinPeriodCloseDO>()
                .eq(FinPeriodCloseDO::getBookId, ledgerId)
                .eq(FinPeriodCloseDO::getPeriodId, periodId));
        return "CLOSE-" + ledgerId + "-" + periodId + "-" + String.format("%03d", count + 1);
    }

    private String buildReopenNo(Long ledgerId, Long periodId) {
        long count = finPeriodReopenLogMapper.selectCount(new LambdaQueryWrapper<FinPeriodReopenLogDO>()
                .eq(FinPeriodReopenLogDO::getBookId, ledgerId)
                .eq(FinPeriodReopenLogDO::getPeriodId, periodId));
        return "REOPEN-" + ledgerId + "-" + periodId + "-" + String.format("%03d", count + 1);
    }

    private void writePeriodOpLog(Long periodId, String operationType, Long operatorId, String beforeStatus,
                                  String afterStatus, String desc) {
        FinPeriodOperationLogDO logDO = new FinPeriodOperationLogDO();
        logDO.setPeriodId(periodId);
        logDO.setOperationType(operationType);
        logDO.setOperatorId(operatorId);
        logDO.setOperationTime(LocalDateTime.now());
        logDO.setBeforeStatus(beforeStatus);
        logDO.setAfterStatus(afterStatus);
        logDO.setOperationDesc(desc);
        finPeriodOperationLogMapper.insert(logDO);
    }

    private void writeTransferJournals(FinInternalTransferDO transfer, AccountRef from, AccountRef to,
                                       BigDecimal amount, LocalDate txnDate, Long operatorId) {
        if ("BANK".equals(from.type())) {
            FinBankAccountDO acc = requireBankAccount(from.id());
            FinBankJournalDO journal = new FinBankJournalDO();
            journal.setAccountId(acc.getId());
            journal.setTxnDate(txnDate);
            journal.setSummary("内部转账转出");
            journal.setDirection("EXPENSE");
            journal.setAmount(amount);
            journal.setIncomeAmount(BigDecimal.ZERO);
            journal.setExpenseAmount(amount);
            journal.setBalance(acc.getCurrentBalance());
            journal.setBizType("INTERNAL_TRANSFER");
            journal.setBizId(transfer.getId());
            journal.setStatus("RECORDED");
            journal.setCreatedBy(operatorId);
            journal.setCreatedAt(LocalDateTime.now());
            finBankJournalMapper.insert(journal);
        } else {
            FinCashAccountDO acc = requireCashAccount(from.id());
            FinCashJournalDO journal = new FinCashJournalDO();
            journal.setAccountId(acc.getId());
            journal.setTxnDate(txnDate);
            journal.setSummary("内部转账转出");
            journal.setDirection("EXPENSE");
            journal.setAmount(amount);
            journal.setIncomeAmount(BigDecimal.ZERO);
            journal.setExpenseAmount(amount);
            journal.setBalance(acc.getCurrentBalance());
            journal.setBizType("INTERNAL_TRANSFER");
            journal.setBizId(transfer.getId());
            journal.setStatus("RECORDED");
            journal.setCreatedBy(operatorId);
            journal.setCreatedAt(LocalDateTime.now());
            finCashJournalMapper.insert(journal);
        }

        if ("BANK".equals(to.type())) {
            FinBankAccountDO acc = requireBankAccount(to.id());
            FinBankJournalDO journal = new FinBankJournalDO();
            journal.setAccountId(acc.getId());
            journal.setTxnDate(txnDate);
            journal.setSummary("内部转账转入");
            journal.setDirection("INCOME");
            journal.setAmount(amount);
            journal.setIncomeAmount(amount);
            journal.setExpenseAmount(BigDecimal.ZERO);
            journal.setBalance(acc.getCurrentBalance());
            journal.setBizType("INTERNAL_TRANSFER");
            journal.setBizId(transfer.getId());
            journal.setStatus("RECORDED");
            journal.setCreatedBy(operatorId);
            journal.setCreatedAt(LocalDateTime.now());
            finBankJournalMapper.insert(journal);
        } else {
            FinCashAccountDO acc = requireCashAccount(to.id());
            FinCashJournalDO journal = new FinCashJournalDO();
            journal.setAccountId(acc.getId());
            journal.setTxnDate(txnDate);
            journal.setSummary("内部转账转入");
            journal.setDirection("INCOME");
            journal.setAmount(amount);
            journal.setIncomeAmount(amount);
            journal.setExpenseAmount(BigDecimal.ZERO);
            journal.setBalance(acc.getCurrentBalance());
            journal.setBizType("INTERNAL_TRANSFER");
            journal.setBizId(transfer.getId());
            journal.setStatus("RECORDED");
            journal.setCreatedBy(operatorId);
            journal.setCreatedAt(LocalDateTime.now());
            finCashJournalMapper.insert(journal);
        }
    }

    private VoucherActionRespVO createTransferVoucher(FinInternalTransferDO transfer, AccountRef from, AccountRef to,
                                                      InternalTransferReqVO reqVO) {
        FinPeriodDO period = requireOpenPeriodByDate(transfer.getBookId(), reqVO.getTxnDate());
        VoucherEntryReqVO debit = new VoucherEntryReqVO();
        debit.setSubjectId(to.subjectId());
        debit.setSummary(buildTransferSummary(from, to));
        debit.setDebitAmount(reqVO.getAmount());
        debit.setCreditAmount(BigDecimal.ZERO);
        debit.setSortOrder(1);

        VoucherEntryReqVO credit = new VoucherEntryReqVO();
        credit.setSubjectId(from.subjectId());
        credit.setSummary(buildTransferSummary(from, to));
        credit.setDebitAmount(BigDecimal.ZERO);
        credit.setCreditAmount(reqVO.getAmount());
        credit.setSortOrder(2);

        BizVoucherCreateCmd cmd = new BizVoucherCreateCmd();
        cmd.setLedgerId(transfer.getBookId());
        cmd.setPeriodId(period.getId());
        cmd.setVoucherDate(reqVO.getTxnDate());
        cmd.setVoucherType(FinanceVoucherType.TRANSFER);
        cmd.setBizId(transfer.getId());
        cmd.setSummary(buildTransferSummary(from, to));
        cmd.setRemark(reqVO.getRemark());
        cmd.setOperatorId(defaultOperator(reqVO.getOperatorId()));
        cmd.setEntries(List.of(debit, credit));
        return bizVoucherLinkService.createVoucher(cmd);
    }

    private FinPeriodDO requireOpenPeriodByDate(Long bookId, LocalDate txnDate) {
        FinPeriodDO period = finPeriodMapper.selectOne(new LambdaQueryWrapper<FinPeriodDO>()
                .eq(FinPeriodDO::getBookId, bookId)
                .le(FinPeriodDO::getStartDate, txnDate)
                .ge(FinPeriodDO::getEndDate, txnDate)
                .last("limit 1"));
        if (period == null) {
            throw new IllegalArgumentException("转账日期无匹配会计期间");
        }
        if (PERIOD_CLOSED.equalsIgnoreCase(period.getCloseStatus())) {
            throw new IllegalStateException("会计期间已结账，禁止转账记账");
        }
        return period;
    }

    private String buildTransferSummary(AccountRef from, AccountRef to) {
        return "内部转账: " + from.type() + "-" + from.id() + " -> " + to.type() + "-" + to.id();
    }

    private BankAccountRespVO changeBankAccountStatus(Long accountId, String status) {
        FinBankAccountDO account = requireBankAccount(accountId);
        account.setStatus(status);
        account.setUpdatedAt(LocalDateTime.now());
        finBankAccountMapper.updateById(account);
        return toBankAccountResp(account);
    }

    private CashAccountRespVO changeCashAccountStatus(Long accountId, String status) {
        FinCashAccountDO account = requireCashAccount(accountId);
        account.setStatus(status);
        account.setUpdatedAt(LocalDateTime.now());
        finCashAccountMapper.updateById(account);
        return toCashAccountResp(account);
    }

    private void rejectDeleteWhenAccountInUse(String accountType, Long accountId) {
        long journalCount;
        if ("BANK".equals(accountType)) {
            journalCount = finBankJournalMapper.selectCount(new LambdaQueryWrapper<FinBankJournalDO>()
                    .eq(FinBankJournalDO::getAccountId, accountId));
        } else {
            journalCount = finCashJournalMapper.selectCount(new LambdaQueryWrapper<FinCashJournalDO>()
                    .eq(FinCashJournalDO::getAccountId, accountId));
        }
        if (journalCount > 0) {
            throw new IllegalStateException("账户存在日记账记录，禁止删除");
        }
        long transferCount = finInternalTransferMapper.selectCount(new LambdaQueryWrapper<FinInternalTransferDO>()
                .eq(FinInternalTransferDO::getFromAccountType, accountType)
                .eq(FinInternalTransferDO::getFromAccountId, accountId)
                .or(q -> q.eq(FinInternalTransferDO::getToAccountType, accountType)
                        .eq(FinInternalTransferDO::getToAccountId, accountId)));
        if (transferCount > 0) {
            throw new IllegalStateException("账户存在内部转账记录，禁止删除");
        }
    }

    private void updateAccountBalance(AccountRef account, BigDecimal delta) {
        if ("BANK".equals(account.type())) {
            FinBankAccountDO bank = requireBankAccount(account.id());
            bank.setCurrentBalance(bank.getCurrentBalance().add(delta));
            bank.setUpdatedAt(LocalDateTime.now());
            finBankAccountMapper.updateById(bank);
        } else {
            FinCashAccountDO cash = requireCashAccount(account.id());
            cash.setCurrentBalance(cash.getCurrentBalance().add(delta));
            cash.setUpdatedAt(LocalDateTime.now());
            finCashAccountMapper.updateById(cash);
        }
    }

    private AccountRef requireAccount(Long accountId) {
        FinBankAccountDO bank = finBankAccountMapper.selectById(accountId);
        if (bank != null) {
            return new AccountRef(bank.getId(), bank.getBookId(), "BANK", bank.getCurrentBalance(), bank.getStatus(), bank.getSubjectId());
        }
        FinCashAccountDO cash = finCashAccountMapper.selectById(accountId);
        if (cash != null) {
            return new AccountRef(cash.getId(), cash.getBookId(), "CASH", cash.getCurrentBalance(), cash.getStatus(), cash.getSubjectId());
        }
        throw new IllegalArgumentException("账户不存在");
    }

    private FinBookDO requireLedger(Long ledgerId) {
        FinBookDO book = finBookMapper.selectById(ledgerId);
        if (book == null) {
            throw new IllegalArgumentException("账套不存在");
        }
        return book;
    }

    private FinSubjectDO requireSubject(Long subjectId, Long ledgerId) {
        FinSubjectDO subject = finSubjectMapper.selectById(subjectId);
        if (subject == null || !Objects.equals(subject.getBookId(), ledgerId)) {
            throw new IllegalArgumentException("会计科目不存在");
        }
        if (subject.getEnableFlag() == null || subject.getEnableFlag() != 1) {
            throw new IllegalArgumentException("会计科目不可用");
        }
        return subject;
    }

    private FinPeriodDO requirePeriod(Long periodId, Long ledgerId) {
        FinPeriodDO period = finPeriodMapper.selectById(periodId);
        if (period == null || !Objects.equals(period.getBookId(), ledgerId)) {
            throw new IllegalArgumentException("会计期间不存在");
        }
        return period;
    }

    private FinBankAccountDO requireBankAccount(Long accountId) {
        FinBankAccountDO account = finBankAccountMapper.selectById(accountId);
        if (account == null) {
            throw new IllegalArgumentException("银行账户不存在");
        }
        return account;
    }

    private FinCashAccountDO requireCashAccount(Long accountId) {
        FinCashAccountDO account = finCashAccountMapper.selectById(accountId);
        if (account == null) {
            throw new IllegalArgumentException("现金账户不存在");
        }
        return account;
    }

    private void requirePositiveAmount(BigDecimal amount, String message) {
        if (amount == null || amount.compareTo(BigDecimal.ZERO) < 0) {
            throw new IllegalArgumentException(message);
        }
    }

    private void requireAccountEnabled(String status, String message) {
        if (!STATUS_ENABLE.equalsIgnoreCase(status)) {
            throw new IllegalStateException(message);
        }
    }

    private Long defaultOperator(Long operatorId) {
        return operatorId == null ? 0L : operatorId;
    }

    private JournalCalc parseDirection(String direction, BigDecimal amount) {
        if (amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("amount必须大于0");
        }
        String normalized = direction == null ? "" : direction.trim().toUpperCase(Locale.ROOT);
        if ("INCOME".equals(normalized)) {
            return new JournalCalc("INCOME", amount, BigDecimal.ZERO, amount);
        }
        if ("EXPENSE".equals(normalized)) {
            return new JournalCalc("EXPENSE", BigDecimal.ZERO, amount, amount.negate());
        }
        throw new IllegalArgumentException("direction仅支持INCOME或EXPENSE");
    }

    private CashAccountRespVO toCashAccountResp(FinCashAccountDO item) {
        CashAccountRespVO vo = new CashAccountRespVO();
        vo.setAccountId(item.getId());
        vo.setAccountName(item.getAccountName());
        vo.setSubjectId(item.getSubjectId());
        vo.setInitBalance(item.getInitBalance());
        vo.setCurrentBalance(item.getCurrentBalance());
        vo.setStatus(item.getStatus());
        return vo;
    }

    private BankAccountRespVO toBankAccountResp(FinBankAccountDO item) {
        BankAccountRespVO vo = new BankAccountRespVO();
        vo.setAccountId(item.getId());
        vo.setAccountName(item.getAccountName());
        vo.setBankName(item.getBankName());
        vo.setAccountNo(item.getAccountNo());
        vo.setSubjectId(item.getSubjectId());
        vo.setInitBalance(item.getInitBalance());
        vo.setCurrentBalance(item.getCurrentBalance());
        vo.setStatus(item.getStatus());
        return vo;
    }

    private JournalListRespVO toJournalResp(FinBankJournalDO item) {
        JournalListRespVO vo = new JournalListRespVO();
        vo.setJournalId(item.getId());
        vo.setTxnDate(item.getTxnDate());
        vo.setSummary(item.getSummary());
        vo.setIncomeAmount(item.getIncomeAmount());
        vo.setExpenseAmount(item.getExpenseAmount());
        vo.setBalance(item.getBalance());
        vo.setStatus(item.getStatus());
        return vo;
    }

    private JournalListRespVO toJournalResp(FinCashJournalDO item) {
        JournalListRespVO vo = new JournalListRespVO();
        vo.setJournalId(item.getId());
        vo.setTxnDate(item.getTxnDate());
        vo.setSummary(item.getSummary());
        vo.setIncomeAmount(item.getIncomeAmount());
        vo.setExpenseAmount(item.getExpenseAmount());
        vo.setBalance(item.getBalance());
        vo.setStatus(item.getStatus());
        return vo;
    }

    private InternalTransferRespVO toTransferResp(FinInternalTransferDO item) {
        InternalTransferRespVO vo = new InternalTransferRespVO();
        vo.setTransferId(item.getId());
        vo.setVoucherId(item.getVoucherId());
        vo.setTxnDate(item.getTxnDate());
        vo.setAmount(item.getAmount());
        vo.setStatus(item.getStatus());
        return vo;
    }

    private ReconciliationRespVO toReconciliationResp(FinReconciliationDO item) {
        ReconciliationRespVO vo = new ReconciliationRespVO();
        vo.setAccountName(item.getAccountName());
        vo.setBookBalance(item.getBookBalance());
        vo.setBankBalance(item.getBankBalance());
        vo.setDiffAmount(item.getDiffAmount());
        return vo;
    }

    private PendingVoucherRespVO toPendingVoucherResp(FinVoucherDO item) {
        PendingVoucherRespVO vo = new PendingVoucherRespVO();
        vo.setVoucherId(item.getId());
        vo.setVoucherNo(item.getVoucherNo());
        vo.setVoucherDate(item.getVoucherDate());
        vo.setAmount(item.getTotalDebit());
        return vo;
    }

    private <T> List<T> applyPagination(List<T> source, Integer pageNum, Integer pageSize) {
        if (pageNum == null || pageSize == null || pageNum <= 0 || pageSize <= 0) {
            return source;
        }
        int fromIndex = Math.max((pageNum - 1) * pageSize, 0);
        if (fromIndex >= source.size()) {
            return List.of();
        }
        int toIndex = Math.min(fromIndex + pageSize, source.size());
        return source.subList(fromIndex, toIndex);
    }

    private record JournalCalc(String direction, BigDecimal incomeAmount, BigDecimal expenseAmount, BigDecimal signedAmount) {
    }

    private record AccountRef(Long id, Long bookId, String type, BigDecimal balance, String status, Long subjectId) {
    }
}
