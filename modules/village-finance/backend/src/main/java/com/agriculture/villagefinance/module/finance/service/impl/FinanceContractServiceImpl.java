package com.agriculture.villagefinance.module.finance.service.impl;

import com.agriculture.villagefinance.module.finance.controller.vo.ContractAcceptanceCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractAcceptanceRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractAttachmentCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractAttachmentRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractChangeCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractChangeRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractOperationLogRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractPageRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractPaymentCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractPaymentRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractRenewalCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractRenewalRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractTerminationCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractTerminationRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractUpdateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.JournalCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.JournalListRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherActionRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherEntryReqVO;
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
import com.agriculture.villagefinance.module.finance.service.FinanceContractService;
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
public class FinanceContractServiceImpl implements FinanceContractService {

    private static final String STATUS_NORMAL = "NORMAL";
    private static final String STATUS_COMPLETED = "COMPLETED";
    private static final String STATUS_TERMINATED = "TERMINATED";
    private static final String STATUS_DELETED = "DELETED";
    private static final String PAYMENT_TYPE_RECEIPT = "RECEIPT";
    private static final String PAYMENT_TYPE_PAYMENT = "PAYMENT";
    private static final String PAYMENT_STATUS_NORMAL = "NORMAL";
    private static final String PERIOD_CLOSED = "CLOSED";
    private static final String ACCOUNT_TYPE_BANK = "BANK";
    private static final String ACCOUNT_TYPE_CASH = "CASH";
    private static final String RENEWAL_STATUS_DRAFT = "DRAFT";
    private static final String ACCEPTANCE_PASS = "PASS";
    private static final String BIZ_TYPE_MAIN = "MAIN";
    private static final int ENABLE_FLAG = 1;

    private final FinBookMapper finBookMapper;
    private final FinContractMainMapper finContractMainMapper;
    private final FinContractChangeMapper finContractChangeMapper;
    private final FinContractAcceptanceMapper finContractAcceptanceMapper;
    private final FinContractTerminationMapper finContractTerminationMapper;
    private final FinContractRenewalMapper finContractRenewalMapper;
    private final FinContractPaymentMapper finContractPaymentMapper;
    private final FinContractAttachmentMapper finContractAttachmentMapper;
    private final FinContractOperationLogMapper finContractOperationLogMapper;
    private final FinPeriodMapper finPeriodMapper;
    private final FinSubjectMapper finSubjectMapper;
    private final FinBankAccountMapper finBankAccountMapper;
    private final FinCashAccountMapper finCashAccountMapper;
    private final FinBankJournalMapper finBankJournalMapper;
    private final FinCashJournalMapper finCashJournalMapper;
    private final FinanceFundsService financeFundsService;
    private final BizVoucherLinkService bizVoucherLinkService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ContractRespVO createContract(ContractCreateReqVO reqVO) {
        requireLedger(reqVO.getLedgerId());
        requireContractNoUnique(reqVO.getContractNo(), null);
        requireNonNegative(reqVO.getContractAmount(), "contractAmount cannot be negative");
        validateDateRange(reqVO.getStartDate(), reqVO.getEndDate());

        FinContractMainDO contract = new FinContractMainDO();
        contract.setContractNo(reqVO.getContractNo().trim());
        contract.setContractName(reqVO.getContractName().trim());
        contract.setContractType(reqVO.getContractType().trim());
        contract.setContractAmount(reqVO.getContractAmount());
        contract.setSignDate(reqVO.getSignDate());
        contract.setStartDate(reqVO.getStartDate());
        contract.setEndDate(reqVO.getEndDate());
        contract.setCounterpartyUnit(reqVO.getCounterpartyUnit());
        contract.setCounterpartyPerson(reqVO.getCounterpartyPerson());
        contract.setOrgId(reqVO.getOrgId());
        contract.setBookId(reqVO.getLedgerId());
        contract.setStatus(STATUS_NORMAL);
        contract.setEnableFlag(ENABLE_FLAG);
        contract.setCreatedBy(defaultOperator(reqVO.getOperatorId()));
        contract.setCreatedAt(LocalDateTime.now());
        contract.setRemark(reqVO.getRemark());
        finContractMainMapper.insert(contract);
        writeOperationLog(contract.getId(), "CREATE", "Create contract", defaultOperator(reqVO.getOperatorId()),
                null, contractSnapshot(contract), reqVO.getRemark());
        return toContractResp(contract);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ContractRespVO updateContract(ContractUpdateReqVO reqVO) {
        FinContractMainDO contract = requireActiveContract(reqVO.getContractId());
        requireNonNegative(reqVO.getContractAmount(), "contractAmount cannot be negative");
        validateDateRange(reqVO.getStartDate(), reqVO.getEndDate());
        String beforeJson = contractSnapshot(contract);

        contract.setContractName(reqVO.getContractName().trim());
        contract.setContractType(reqVO.getContractType().trim());
        contract.setContractAmount(reqVO.getContractAmount());
        contract.setSignDate(reqVO.getSignDate());
        contract.setStartDate(reqVO.getStartDate());
        contract.setEndDate(reqVO.getEndDate());
        contract.setCounterpartyUnit(reqVO.getCounterpartyUnit());
        contract.setCounterpartyPerson(reqVO.getCounterpartyPerson());
        if (StringUtils.hasText(reqVO.getStatus())) {
            contract.setStatus(reqVO.getStatus().trim().toUpperCase(Locale.ROOT));
        }
        if (reqVO.getEnableFlag() != null) {
            contract.setEnableFlag(reqVO.getEnableFlag());
        }
        contract.setUpdatedBy(defaultOperator(reqVO.getOperatorId()));
        contract.setUpdatedAt(LocalDateTime.now());
        contract.setRemark(reqVO.getRemark());
        finContractMainMapper.updateById(contract);

        writeOperationLog(contract.getId(), "UPDATE", "Update contract", defaultOperator(reqVO.getOperatorId()),
                beforeJson, contractSnapshot(contract), reqVO.getRemark());
        return toContractResp(contract);
    }

    @Override
    public ContractPageRespVO getContractPage(Integer pageNo, Integer pageSize, Long ledgerId,
                                              String contractName, String contractType, String status) {
        LambdaQueryWrapper<FinContractMainDO> wrapper = new LambdaQueryWrapper<FinContractMainDO>()
                .orderByDesc(FinContractMainDO::getId);
        if (ledgerId != null) {
            wrapper.eq(FinContractMainDO::getBookId, ledgerId);
        }
        if (StringUtils.hasText(contractName)) {
            wrapper.like(FinContractMainDO::getContractName, contractName.trim());
        }
        if (StringUtils.hasText(contractType)) {
            wrapper.eq(FinContractMainDO::getContractType, contractType.trim());
        }
        if (StringUtils.hasText(status)) {
            wrapper.eq(FinContractMainDO::getStatus, status.trim().toUpperCase(Locale.ROOT));
        } else {
            wrapper.ne(FinContractMainDO::getStatus, STATUS_DELETED);
        }
        long total = finContractMainMapper.selectCount(wrapper);
        List<FinContractMainDO> contracts = applyPagination(finContractMainMapper.selectList(wrapper), pageNo, pageSize);
        ContractPageRespVO page = new ContractPageRespVO();
        page.setTotal(total);
        page.setRecords(contracts.stream().map(this::toContractResp).toList());
        return page;
    }

    @Override
    public ContractRespVO getContract(Long contractId) {
        return toContractResp(requireActiveContract(contractId));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteContract(Long contractId, Long operatorId) {
        FinContractMainDO contract = requireActiveContract(contractId);
        rejectDeleteWhenProtected(contractId);
        String beforeJson = contractSnapshot(contract);
        contract.setStatus(STATUS_DELETED);
        contract.setEnableFlag(0);
        contract.setUpdatedBy(defaultOperator(operatorId));
        contract.setUpdatedAt(LocalDateTime.now());
        finContractMainMapper.updateById(contract);
        writeOperationLog(contractId, "DELETE", "Delete contract (logical)",
                defaultOperator(operatorId), beforeJson, contractSnapshot(contract), null);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ContractChangeRespVO createChange(ContractChangeCreateReqVO reqVO) {
        FinContractMainDO contract = requireActiveContract(reqVO.getContractId());
        String beforeJson = contractSnapshot(contract);
        BigDecimal afterAmount = reqVO.getAfterAmount() == null
                ? contract.getContractAmount()
                : requireNonNegative(reqVO.getAfterAmount(), "afterAmount cannot be negative");
        LocalDate afterEndDate = reqVO.getAfterEndDate() == null ? contract.getEndDate() : reqVO.getAfterEndDate();
        validateDateRange(contract.getStartDate(), afterEndDate);

        FinContractChangeDO change = new FinContractChangeDO();
        change.setContractId(contract.getId());
        change.setChangeType(reqVO.getChangeType().trim());
        change.setChangeDate(reqVO.getChangeDate());
        change.setBeforeAmount(contract.getContractAmount());
        change.setAfterAmount(afterAmount);
        change.setBeforeEndDate(contract.getEndDate());
        change.setAfterEndDate(afterEndDate);
        change.setChangeContent(reqVO.getChangeContent());
        change.setCreatedBy(defaultOperator(reqVO.getOperatorId()));
        change.setCreatedAt(LocalDateTime.now());
        change.setRemark(reqVO.getRemark());
        finContractChangeMapper.insert(change);

        contract.setContractAmount(afterAmount);
        contract.setEndDate(afterEndDate);
        contract.setUpdatedBy(defaultOperator(reqVO.getOperatorId()));
        contract.setUpdatedAt(LocalDateTime.now());
        finContractMainMapper.updateById(contract);
        writeOperationLog(contract.getId(), "CHANGE", "Create contract change", defaultOperator(reqVO.getOperatorId()),
                beforeJson, contractSnapshot(contract), reqVO.getRemark());
        return toChangeResp(change);
    }

    @Override
    public List<ContractChangeRespVO> getChangeList(Long contractId) {
        requireActiveContract(contractId);
        return finContractChangeMapper.selectList(new LambdaQueryWrapper<FinContractChangeDO>()
                        .eq(FinContractChangeDO::getContractId, contractId)
                        .orderByDesc(FinContractChangeDO::getId))
                .stream().map(this::toChangeResp).toList();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ContractAcceptanceRespVO createAcceptance(ContractAcceptanceCreateReqVO reqVO) {
        FinContractMainDO contract = requireActiveContract(reqVO.getContractId());
        String beforeJson = contractSnapshot(contract);
        BigDecimal amount = reqVO.getAcceptanceAmount() == null
                ? BigDecimal.ZERO
                : requireNonNegative(reqVO.getAcceptanceAmount(), "acceptanceAmount cannot be negative");
        String result = StringUtils.hasText(reqVO.getAcceptanceResult())
                ? reqVO.getAcceptanceResult().trim().toUpperCase(Locale.ROOT)
                : ACCEPTANCE_PASS;

        FinContractAcceptanceDO acceptance = new FinContractAcceptanceDO();
        acceptance.setContractId(contract.getId());
        acceptance.setAcceptanceDate(reqVO.getAcceptanceDate());
        acceptance.setAcceptanceResult(result);
        acceptance.setAcceptanceAmount(amount);
        acceptance.setAcceptanceDesc(reqVO.getAcceptanceDesc());
        acceptance.setOperatorId(defaultOperator(reqVO.getOperatorId()));
        acceptance.setCreatedAt(LocalDateTime.now());
        acceptance.setRemark(reqVO.getRemark());
        finContractAcceptanceMapper.insert(acceptance);
        if (ACCEPTANCE_PASS.equals(result)) {
            contract.setStatus(STATUS_COMPLETED);
            contract.setUpdatedBy(defaultOperator(reqVO.getOperatorId()));
            contract.setUpdatedAt(LocalDateTime.now());
            finContractMainMapper.updateById(contract);
        }
        writeOperationLog(contract.getId(), "ACCEPT", "Create contract acceptance",
                defaultOperator(reqVO.getOperatorId()), beforeJson, contractSnapshot(contract), reqVO.getRemark());
        return toAcceptanceResp(acceptance);
    }

    @Override
    public List<ContractAcceptanceRespVO> getAcceptanceList(Long contractId) {
        requireActiveContract(contractId);
        return finContractAcceptanceMapper.selectList(new LambdaQueryWrapper<FinContractAcceptanceDO>()
                        .eq(FinContractAcceptanceDO::getContractId, contractId)
                        .orderByDesc(FinContractAcceptanceDO::getId))
                .stream().map(this::toAcceptanceResp).toList();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ContractPaymentRespVO createReceipt(ContractPaymentCreateReqVO reqVO) {
        return createContractPayment(reqVO, PAYMENT_TYPE_RECEIPT, FinanceVoucherType.CONTRACT_RECEIPT);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ContractPaymentRespVO createPayment(ContractPaymentCreateReqVO reqVO) {
        return createContractPayment(reqVO, PAYMENT_TYPE_PAYMENT, FinanceVoucherType.CONTRACT_PAYMENT);
    }

    @Override
    public List<ContractPaymentRespVO> getPaymentList(Long contractId, String paymentType) {
        requireActiveContract(contractId);
        LambdaQueryWrapper<FinContractPaymentDO> wrapper = new LambdaQueryWrapper<FinContractPaymentDO>()
                .eq(FinContractPaymentDO::getContractId, contractId)
                .orderByDesc(FinContractPaymentDO::getPaymentDate)
                .orderByDesc(FinContractPaymentDO::getId);
        if (StringUtils.hasText(paymentType)) {
            wrapper.eq(FinContractPaymentDO::getPaymentType, paymentType.trim().toUpperCase(Locale.ROOT));
        }
        return finContractPaymentMapper.selectList(wrapper).stream().map(this::toPaymentResp).toList();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ContractTerminationRespVO createTermination(ContractTerminationCreateReqVO reqVO) {
        FinContractMainDO contract = requireActiveContract(reqVO.getContractId());
        long exist = finContractTerminationMapper.selectCount(new LambdaQueryWrapper<FinContractTerminationDO>()
                .eq(FinContractTerminationDO::getContractId, contract.getId()));
        if (exist > 0) {
            throw new IllegalStateException("Contract already has a termination record");
        }
        String beforeJson = contractSnapshot(contract);
        BigDecimal settlement = reqVO.getSettlementAmount() == null
                ? BigDecimal.ZERO
                : requireNonNegative(reqVO.getSettlementAmount(), "settlementAmount cannot be negative");

        FinContractTerminationDO termination = new FinContractTerminationDO();
        termination.setContractId(contract.getId());
        termination.setTerminationDate(reqVO.getTerminationDate());
        termination.setTerminationType(reqVO.getTerminationType().trim());
        termination.setTerminationReason(reqVO.getTerminationReason());
        termination.setSettlementAmount(settlement);
        termination.setOperatorId(defaultOperator(reqVO.getOperatorId()));
        termination.setCreatedAt(LocalDateTime.now());
        termination.setRemark(reqVO.getRemark());
        finContractTerminationMapper.insert(termination);

        contract.setStatus(STATUS_TERMINATED);
        contract.setEndDate(reqVO.getTerminationDate());
        contract.setUpdatedBy(defaultOperator(reqVO.getOperatorId()));
        contract.setUpdatedAt(LocalDateTime.now());
        finContractMainMapper.updateById(contract);
        writeOperationLog(contract.getId(), "TERMINATE", "Create contract termination",
                defaultOperator(reqVO.getOperatorId()), beforeJson, contractSnapshot(contract), reqVO.getRemark());
        return toTerminationResp(termination);
    }

    @Override
    public List<ContractTerminationRespVO> getTerminationList(Long contractId) {
        requireActiveContract(contractId);
        return finContractTerminationMapper.selectList(new LambdaQueryWrapper<FinContractTerminationDO>()
                        .eq(FinContractTerminationDO::getContractId, contractId)
                        .orderByDesc(FinContractTerminationDO::getId))
                .stream().map(this::toTerminationResp).toList();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ContractRenewalRespVO createRenewal(ContractRenewalCreateReqVO reqVO) {
        FinContractMainDO contract = requireActiveContract(reqVO.getContractId());
        validateDateRange(reqVO.getRenewalStartDate(), reqVO.getRenewalEndDate());
        String beforeJson = contractSnapshot(contract);
        long count = finContractRenewalMapper.selectCount(new LambdaQueryWrapper<FinContractRenewalDO>()
                .eq(FinContractRenewalDO::getContractId, contract.getId()));
        BigDecimal renewalAmount = reqVO.getRenewalAmount() == null
                ? contract.getContractAmount()
                : requireNonNegative(reqVO.getRenewalAmount(), "renewalAmount cannot be negative");

        FinContractRenewalDO renewal = new FinContractRenewalDO();
        renewal.setContractId(contract.getId());
        renewal.setRenewalNo("RENEW-" + contract.getId() + "-" + String.format("%03d", count + 1));
        renewal.setRenewalDate(reqVO.getRenewalDate());
        renewal.setRenewalStartDate(reqVO.getRenewalStartDate());
        renewal.setRenewalEndDate(reqVO.getRenewalEndDate());
        renewal.setRenewalAmount(renewalAmount);
        renewal.setRenewalContent(reqVO.getRenewalContent());
        renewal.setStatus(RENEWAL_STATUS_DRAFT);
        renewal.setCreatedBy(defaultOperator(reqVO.getOperatorId()));
        renewal.setCreatedAt(LocalDateTime.now());
        renewal.setRemark(reqVO.getRemark());
        finContractRenewalMapper.insert(renewal);

        contract.setStatus(STATUS_NORMAL);
        contract.setContractAmount(renewalAmount);
        if (reqVO.getRenewalEndDate() != null) {
            contract.setEndDate(reqVO.getRenewalEndDate());
        }
        contract.setUpdatedBy(defaultOperator(reqVO.getOperatorId()));
        contract.setUpdatedAt(LocalDateTime.now());
        finContractMainMapper.updateById(contract);
        writeOperationLog(contract.getId(), "RENEW", "Create contract renewal",
                defaultOperator(reqVO.getOperatorId()), beforeJson, contractSnapshot(contract), reqVO.getRemark());
        return toRenewalResp(renewal);
    }

    @Override
    public List<ContractRenewalRespVO> getRenewalList(Long contractId) {
        requireActiveContract(contractId);
        return finContractRenewalMapper.selectList(new LambdaQueryWrapper<FinContractRenewalDO>()
                        .eq(FinContractRenewalDO::getContractId, contractId)
                        .orderByDesc(FinContractRenewalDO::getId))
                .stream().map(this::toRenewalResp).toList();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ContractAttachmentRespVO createAttachment(ContractAttachmentCreateReqVO reqVO) {
        FinContractMainDO contract = requireActiveContract(reqVO.getContractId());
        if (reqVO.getFileSize() != null && reqVO.getFileSize() < 0) {
            throw new IllegalArgumentException("fileSize cannot be negative");
        }
        FinContractAttachmentDO attachment = new FinContractAttachmentDO();
        attachment.setContractId(contract.getId());
        attachment.setBizType(StringUtils.hasText(reqVO.getBizType()) ? reqVO.getBizType().trim().toUpperCase(Locale.ROOT) : BIZ_TYPE_MAIN);
        attachment.setFileName(reqVO.getFileName().trim());
        attachment.setFileUrl(reqVO.getFileUrl().trim());
        attachment.setFileType(reqVO.getFileType());
        attachment.setFileSize(reqVO.getFileSize());
        attachment.setUploadedBy(defaultOperator(reqVO.getOperatorId()));
        attachment.setUploadedAt(LocalDateTime.now());
        attachment.setRemark(reqVO.getRemark());
        finContractAttachmentMapper.insert(attachment);
        writeOperationLog(contract.getId(), "ATTACH", "Upload contract attachment: " + attachment.getFileName(),
                defaultOperator(reqVO.getOperatorId()), null, "{attachmentId:" + attachment.getId() + "}", reqVO.getRemark());
        return toAttachmentResp(attachment);
    }

    @Override
    public List<ContractAttachmentRespVO> getAttachmentList(Long contractId, String bizType) {
        requireActiveContract(contractId);
        LambdaQueryWrapper<FinContractAttachmentDO> wrapper = new LambdaQueryWrapper<FinContractAttachmentDO>()
                .eq(FinContractAttachmentDO::getContractId, contractId)
                .orderByDesc(FinContractAttachmentDO::getId);
        if (StringUtils.hasText(bizType)) {
            wrapper.eq(FinContractAttachmentDO::getBizType, bizType.trim().toUpperCase(Locale.ROOT));
        }
        return finContractAttachmentMapper.selectList(wrapper).stream().map(this::toAttachmentResp).toList();
    }

    @Override
    public List<ContractOperationLogRespVO> getOperationLogList(Long contractId) {
        requireContract(contractId);
        return finContractOperationLogMapper.selectList(new LambdaQueryWrapper<FinContractOperationLogDO>()
                        .eq(FinContractOperationLogDO::getContractId, contractId)
                        .orderByDesc(FinContractOperationLogDO::getOperationTime)
                        .orderByDesc(FinContractOperationLogDO::getId))
                .stream().map(this::toOperationLogResp).toList();
    }

    private ContractPaymentRespVO createContractPayment(ContractPaymentCreateReqVO reqVO,
                                                        String paymentType,
                                                        String voucherType) {
        FinContractMainDO contract = requireWritableContract(reqVO.getContractId());
        requirePositiveAmount(reqVO.getAmount(), "amount必须大于0");
        FinPeriodDO period = requireWritablePeriodByDate(contract.getBookId(), reqVO.getPaymentDate());
        AccountRef accountRef = resolveAccount(reqVO, contract.getBookId());
        FinSubjectDO counterpartySubject = requireSubject(reqVO.getCounterpartySubjectId(), contract.getBookId());

        FinContractPaymentDO payment = new FinContractPaymentDO();
        payment.setContractId(contract.getId());
        payment.setPaymentType(paymentType);
        payment.setPaymentDate(reqVO.getPaymentDate());
        payment.setAmount(reqVO.getAmount());
        payment.setBankAccountId(ACCOUNT_TYPE_BANK.equals(accountRef.accountType()) ? accountRef.accountId() : null);
        payment.setCashAccountId(ACCOUNT_TYPE_CASH.equals(accountRef.accountType()) ? accountRef.accountId() : null);
        payment.setStatus(PAYMENT_STATUS_NORMAL);
        payment.setCreatedBy(defaultOperator(reqVO.getOperatorId()));
        payment.setCreatedAt(LocalDateTime.now());
        payment.setRemark(reqVO.getRemark());
        finContractPaymentMapper.insert(payment);

        JournalListRespVO journalResp = createPaymentJournal(reqVO, payment, accountRef, paymentType, contract.getContractNo());
        Long journalId = journalResp.getJournalId();
        bindJournalBiz(journalId, accountRef.accountType(), voucherType, payment.getId());

        VoucherActionRespVO voucher = createPaymentVoucher(reqVO, payment, contract, accountRef,
                counterpartySubject, paymentType, voucherType, period.getId());
        payment.setJournalId(journalId);
        payment.setVoucherId(voucher.getVoucherId());
        finContractPaymentMapper.updateById(payment);

        writeOperationLog(contract.getId(),
                PAYMENT_TYPE_RECEIPT.equals(paymentType) ? "RECEIPT" : "PAYMENT",
                PAYMENT_TYPE_RECEIPT.equals(paymentType) ? "Create contract receipt" : "Create contract payment",
                defaultOperator(reqVO.getOperatorId()),
                null,
                "{paymentId:" + payment.getId() + ",journalId:" + journalId + ",voucherId:" + voucher.getVoucherId() + "}",
                reqVO.getRemark());
        return toPaymentResp(payment);
    }

    private JournalListRespVO createPaymentJournal(ContractPaymentCreateReqVO reqVO,
                                                   FinContractPaymentDO payment,
                                                   AccountRef accountRef,
                                                   String paymentType,
                                                   String contractNo) {
        JournalCreateReqVO journalReq = new JournalCreateReqVO();
        journalReq.setAccountId(accountRef.accountId());
        journalReq.setTxnDate(reqVO.getPaymentDate());
        journalReq.setAmount(reqVO.getAmount());
        journalReq.setDirection(PAYMENT_TYPE_RECEIPT.equals(paymentType) ? "INCOME" : "EXPENSE");
        journalReq.setSummary(buildPaymentSummary(reqVO.getSummary(), contractNo, paymentType, payment.getId()));
        journalReq.setOperatorId(defaultOperator(reqVO.getOperatorId()));
        if (ACCOUNT_TYPE_BANK.equals(accountRef.accountType())) {
            return financeFundsService.createBankJournal(journalReq);
        }
        return financeFundsService.createCashJournal(journalReq);
    }

    private VoucherActionRespVO createPaymentVoucher(ContractPaymentCreateReqVO reqVO,
                                                     FinContractPaymentDO payment,
                                                     FinContractMainDO contract,
                                                     AccountRef accountRef,
                                                     FinSubjectDO counterpartySubject,
                                                     String paymentType,
                                                     String voucherType,
                                                     Long periodId) {
        VoucherEntryReqVO debit = new VoucherEntryReqVO();
        VoucherEntryReqVO credit = new VoucherEntryReqVO();
        String summary = buildPaymentSummary(reqVO.getSummary(), contract.getContractNo(), paymentType, payment.getId());

        if (PAYMENT_TYPE_RECEIPT.equals(paymentType)) {
            debit.setSubjectId(accountRef.subjectId());
            debit.setDebitAmount(reqVO.getAmount());
            debit.setCreditAmount(BigDecimal.ZERO);
            debit.setSummary(summary);
            debit.setSortOrder(1);

            credit.setSubjectId(counterpartySubject.getId());
            credit.setDebitAmount(BigDecimal.ZERO);
            credit.setCreditAmount(reqVO.getAmount());
            credit.setSummary(summary);
            credit.setSortOrder(2);
        } else {
            debit.setSubjectId(counterpartySubject.getId());
            debit.setDebitAmount(reqVO.getAmount());
            debit.setCreditAmount(BigDecimal.ZERO);
            debit.setSummary(summary);
            debit.setSortOrder(1);

            credit.setSubjectId(accountRef.subjectId());
            credit.setDebitAmount(BigDecimal.ZERO);
            credit.setCreditAmount(reqVO.getAmount());
            credit.setSummary(summary);
            credit.setSortOrder(2);
        }

        BizVoucherCreateCmd cmd = new BizVoucherCreateCmd();
        cmd.setLedgerId(contract.getBookId());
        cmd.setPeriodId(periodId);
        cmd.setVoucherDate(reqVO.getPaymentDate());
        cmd.setVoucherType(voucherType);
        cmd.setBizId(payment.getId());
        cmd.setSummary(summary);
        cmd.setRemark(reqVO.getRemark());
        cmd.setOperatorId(defaultOperator(reqVO.getOperatorId()));
        cmd.setEntries(List.of(debit, credit));
        return bizVoucherLinkService.createVoucher(cmd);
    }

    private void bindJournalBiz(Long journalId, String accountType, String bizType, Long bizId) {
        if (ACCOUNT_TYPE_BANK.equals(accountType)) {
            FinBankJournalDO journal = finBankJournalMapper.selectById(journalId);
            if (journal == null) {
                throw new IllegalStateException("银行日记账不存在");
            }
            journal.setBizType(bizType);
            journal.setBizId(bizId);
            finBankJournalMapper.updateById(journal);
            return;
        }
        FinCashJournalDO journal = finCashJournalMapper.selectById(journalId);
        if (journal == null) {
            throw new IllegalStateException("现金日记账不存在");
        }
        journal.setBizType(bizType);
        journal.setBizId(bizId);
        finCashJournalMapper.updateById(journal);
    }

    private AccountRef resolveAccount(ContractPaymentCreateReqVO reqVO, Long ledgerId) {
        boolean hasBank = reqVO.getBankAccountId() != null;
        boolean hasCash = reqVO.getCashAccountId() != null;
        if (hasBank == hasCash) {
            throw new IllegalArgumentException("bankAccountId与cashAccountId必须且仅能传一个");
        }
        if (hasBank) {
            FinBankAccountDO bankAccount = finBankAccountMapper.selectById(reqVO.getBankAccountId());
            if (bankAccount == null) {
                throw new IllegalArgumentException("银行账户不存在");
            }
            if (!Objects.equals(bankAccount.getBookId(), ledgerId)) {
                throw new IllegalArgumentException("合同与银行账户账套不一致");
            }
            if (!"ENABLE".equalsIgnoreCase(bankAccount.getStatus())) {
                throw new IllegalStateException("银行账户不可用");
            }
            if (bankAccount.getSubjectId() == null) {
                throw new IllegalArgumentException("银行账户缺少会计科目映射");
            }
            requireSubject(bankAccount.getSubjectId(), ledgerId);
            return new AccountRef(ACCOUNT_TYPE_BANK, bankAccount.getId(), bankAccount.getSubjectId());
        }
        FinCashAccountDO cashAccount = finCashAccountMapper.selectById(reqVO.getCashAccountId());
        if (cashAccount == null) {
            throw new IllegalArgumentException("现金账户不存在");
        }
        if (!Objects.equals(cashAccount.getBookId(), ledgerId)) {
            throw new IllegalArgumentException("合同与现金账户账套不一致");
        }
        if (!"ENABLE".equalsIgnoreCase(cashAccount.getStatus())) {
            throw new IllegalStateException("现金账户不可用");
        }
        if (cashAccount.getSubjectId() == null) {
            throw new IllegalArgumentException("现金账户缺少会计科目映射");
        }
        requireSubject(cashAccount.getSubjectId(), ledgerId);
        return new AccountRef(ACCOUNT_TYPE_CASH, cashAccount.getId(), cashAccount.getSubjectId());
    }

    private String buildPaymentSummary(String summary, String contractNo, String paymentType, Long paymentId) {
        if (StringUtils.hasText(summary)) {
            return summary.trim();
        }
        String action = PAYMENT_TYPE_RECEIPT.equals(paymentType) ? "收款" : "付款";
        return "合同" + action + ": " + contractNo + " #" + paymentId;
    }

    private void writeOperationLog(Long contractId, String operationType, String operationDesc, Long operatorId,
                                   String beforeJson, String afterJson, String remark) {
        FinContractOperationLogDO logDO = new FinContractOperationLogDO();
        logDO.setContractId(contractId);
        logDO.setOperationType(operationType);
        logDO.setOperationDesc(operationDesc);
        logDO.setOperatorId(defaultOperator(operatorId));
        logDO.setOperationTime(LocalDateTime.now());
        logDO.setBeforeJson(beforeJson);
        logDO.setAfterJson(afterJson);
        logDO.setRemark(remark);
        finContractOperationLogMapper.insert(logDO);
    }

    private void rejectDeleteWhenProtected(Long contractId) {
        if (finContractChangeMapper.selectCount(new LambdaQueryWrapper<FinContractChangeDO>()
                .eq(FinContractChangeDO::getContractId, contractId)) > 0) {
            throw new IllegalStateException("Contract has change records and cannot be deleted");
        }
        if (finContractAcceptanceMapper.selectCount(new LambdaQueryWrapper<FinContractAcceptanceDO>()
                .eq(FinContractAcceptanceDO::getContractId, contractId)) > 0) {
            throw new IllegalStateException("Contract has acceptance records and cannot be deleted");
        }
        if (finContractTerminationMapper.selectCount(new LambdaQueryWrapper<FinContractTerminationDO>()
                .eq(FinContractTerminationDO::getContractId, contractId)) > 0) {
            throw new IllegalStateException("Contract has termination records and cannot be deleted");
        }
        if (finContractRenewalMapper.selectCount(new LambdaQueryWrapper<FinContractRenewalDO>()
                .eq(FinContractRenewalDO::getContractId, contractId)) > 0) {
            throw new IllegalStateException("Contract has renewal records and cannot be deleted");
        }
        if (finContractAttachmentMapper.selectCount(new LambdaQueryWrapper<FinContractAttachmentDO>()
                .eq(FinContractAttachmentDO::getContractId, contractId)) > 0) {
            throw new IllegalStateException("Contract has attachments and cannot be deleted");
        }
        if (finContractPaymentMapper.selectCount(new LambdaQueryWrapper<FinContractPaymentDO>()
                .eq(FinContractPaymentDO::getContractId, contractId)) > 0) {
            throw new IllegalStateException("Contract has payment records and cannot be deleted");
        }
    }

    private FinContractMainDO requireContract(Long contractId) {
        FinContractMainDO contract = finContractMainMapper.selectById(contractId);
        if (contract == null) {
            throw new IllegalArgumentException("Contract does not exist");
        }
        return contract;
    }

    private FinContractMainDO requireActiveContract(Long contractId) {
        FinContractMainDO contract = requireContract(contractId);
        if (STATUS_DELETED.equalsIgnoreCase(contract.getStatus())) {
            throw new IllegalStateException("Contract has been deleted");
        }
        return contract;
    }

    private FinContractMainDO requireWritableContract(Long contractId) {
        FinContractMainDO contract = requireActiveContract(contractId);
        if (STATUS_TERMINATED.equalsIgnoreCase(contract.getStatus())) {
            throw new IllegalStateException("Contract has been terminated");
        }
        if (contract.getEnableFlag() == null || contract.getEnableFlag() != ENABLE_FLAG) {
            throw new IllegalStateException("Contract is disabled");
        }
        return contract;
    }

    private FinBookDO requireLedger(Long ledgerId) {
        FinBookDO ledger = finBookMapper.selectById(ledgerId);
        if (ledger == null) {
            throw new IllegalArgumentException("Ledger does not exist");
        }
        return ledger;
    }

    private FinPeriodDO requireWritablePeriodByDate(Long ledgerId, LocalDate bizDate) {
        FinPeriodDO period = finPeriodMapper.selectOne(new LambdaQueryWrapper<FinPeriodDO>()
                .eq(FinPeriodDO::getBookId, ledgerId)
                .le(FinPeriodDO::getStartDate, bizDate)
                .ge(FinPeriodDO::getEndDate, bizDate)
                .last("limit 1"));
        if (period == null) {
            throw new IllegalArgumentException("业务日期无匹配会计期间");
        }
        if (PERIOD_CLOSED.equalsIgnoreCase(period.getCloseStatus())) {
            throw new IllegalStateException("会计期间已结账，禁止合同收付款写入");
        }
        return period;
    }

    private FinSubjectDO requireSubject(Long subjectId, Long ledgerId) {
        FinSubjectDO subject = finSubjectMapper.selectById(subjectId);
        if (subject == null || !Objects.equals(subject.getBookId(), ledgerId)) {
            throw new IllegalArgumentException("会计科目不存在");
        }
        if (subject.getEnableFlag() == null || subject.getEnableFlag() != ENABLE_FLAG) {
            throw new IllegalArgumentException("会计科目不可用");
        }
        return subject;
    }

    private void requireContractNoUnique(String contractNo, Long excludeId) {
        if (!StringUtils.hasText(contractNo)) {
            throw new IllegalArgumentException("contractNo is required");
        }
        LambdaQueryWrapper<FinContractMainDO> wrapper = new LambdaQueryWrapper<FinContractMainDO>()
                .eq(FinContractMainDO::getContractNo, contractNo.trim());
        if (excludeId != null) {
            wrapper.ne(FinContractMainDO::getId, excludeId);
        }
        if (finContractMainMapper.selectCount(wrapper) > 0) {
            throw new IllegalArgumentException("contractNo already exists");
        }
    }

    private BigDecimal requireNonNegative(BigDecimal amount, String message) {
        if (amount == null || amount.compareTo(BigDecimal.ZERO) < 0) {
            throw new IllegalArgumentException(message);
        }
        return amount;
    }

    private BigDecimal requirePositiveAmount(BigDecimal amount, String message) {
        if (amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException(message);
        }
        return amount;
    }

    private void validateDateRange(LocalDate startDate, LocalDate endDate) {
        if (startDate != null && endDate != null && endDate.isBefore(startDate)) {
            throw new IllegalArgumentException("endDate cannot be earlier than startDate");
        }
    }

    private String contractSnapshot(FinContractMainDO contract) {
        return "{id:" + contract.getId()
                + ",contractNo:" + contract.getContractNo()
                + ",contractAmount:" + contract.getContractAmount()
                + ",status:" + contract.getStatus()
                + ",endDate:" + contract.getEndDate()
                + "}";
    }

    private Long defaultOperator(Long operatorId) {
        return operatorId == null ? 0L : operatorId;
    }

    private ContractRespVO toContractResp(FinContractMainDO contract) {
        ContractRespVO resp = new ContractRespVO();
        resp.setContractId(contract.getId());
        resp.setContractNo(contract.getContractNo());
        resp.setContractName(contract.getContractName());
        resp.setContractType(contract.getContractType());
        resp.setContractAmount(contract.getContractAmount());
        resp.setSignDate(contract.getSignDate());
        resp.setStartDate(contract.getStartDate());
        resp.setEndDate(contract.getEndDate());
        resp.setCounterpartyUnit(contract.getCounterpartyUnit());
        resp.setCounterpartyPerson(contract.getCounterpartyPerson());
        resp.setOrgId(contract.getOrgId());
        resp.setLedgerId(contract.getBookId());
        resp.setStatus(contract.getStatus());
        resp.setEnableFlag(contract.getEnableFlag());
        resp.setRemark(contract.getRemark());
        return resp;
    }

    private ContractChangeRespVO toChangeResp(FinContractChangeDO change) {
        ContractChangeRespVO resp = new ContractChangeRespVO();
        resp.setChangeId(change.getId());
        resp.setContractId(change.getContractId());
        resp.setChangeType(change.getChangeType());
        resp.setChangeDate(change.getChangeDate());
        resp.setBeforeAmount(change.getBeforeAmount());
        resp.setAfterAmount(change.getAfterAmount());
        resp.setBeforeEndDate(change.getBeforeEndDate());
        resp.setAfterEndDate(change.getAfterEndDate());
        resp.setChangeContent(change.getChangeContent());
        resp.setVoucherId(change.getVoucherId());
        resp.setCreatedAt(change.getCreatedAt());
        resp.setRemark(change.getRemark());
        return resp;
    }

    private ContractAcceptanceRespVO toAcceptanceResp(FinContractAcceptanceDO acceptance) {
        ContractAcceptanceRespVO resp = new ContractAcceptanceRespVO();
        resp.setAcceptanceId(acceptance.getId());
        resp.setContractId(acceptance.getContractId());
        resp.setAcceptanceDate(acceptance.getAcceptanceDate());
        resp.setAcceptanceResult(acceptance.getAcceptanceResult());
        resp.setAcceptanceAmount(acceptance.getAcceptanceAmount());
        resp.setAcceptanceDesc(acceptance.getAcceptanceDesc());
        resp.setOperatorId(acceptance.getOperatorId());
        resp.setCreatedAt(acceptance.getCreatedAt());
        resp.setRemark(acceptance.getRemark());
        return resp;
    }

    private ContractTerminationRespVO toTerminationResp(FinContractTerminationDO termination) {
        ContractTerminationRespVO resp = new ContractTerminationRespVO();
        resp.setTerminationId(termination.getId());
        resp.setContractId(termination.getContractId());
        resp.setTerminationDate(termination.getTerminationDate());
        resp.setTerminationType(termination.getTerminationType());
        resp.setTerminationReason(termination.getTerminationReason());
        resp.setSettlementAmount(termination.getSettlementAmount());
        resp.setVoucherId(termination.getVoucherId());
        resp.setOperatorId(termination.getOperatorId());
        resp.setCreatedAt(termination.getCreatedAt());
        resp.setRemark(termination.getRemark());
        return resp;
    }

    private ContractRenewalRespVO toRenewalResp(FinContractRenewalDO renewal) {
        ContractRenewalRespVO resp = new ContractRenewalRespVO();
        resp.setRenewalId(renewal.getId());
        resp.setContractId(renewal.getContractId());
        resp.setRenewalNo(renewal.getRenewalNo());
        resp.setRenewalDate(renewal.getRenewalDate());
        resp.setRenewalStartDate(renewal.getRenewalStartDate());
        resp.setRenewalEndDate(renewal.getRenewalEndDate());
        resp.setRenewalAmount(renewal.getRenewalAmount());
        resp.setRenewalContent(renewal.getRenewalContent());
        resp.setStatus(renewal.getStatus());
        resp.setCreatedAt(renewal.getCreatedAt());
        resp.setRemark(renewal.getRemark());
        return resp;
    }

    private ContractAttachmentRespVO toAttachmentResp(FinContractAttachmentDO attachment) {
        ContractAttachmentRespVO resp = new ContractAttachmentRespVO();
        resp.setAttachmentId(attachment.getId());
        resp.setContractId(attachment.getContractId());
        resp.setBizType(attachment.getBizType());
        resp.setFileName(attachment.getFileName());
        resp.setFileUrl(attachment.getFileUrl());
        resp.setFileType(attachment.getFileType());
        resp.setFileSize(attachment.getFileSize());
        resp.setUploadedBy(attachment.getUploadedBy());
        resp.setUploadedAt(attachment.getUploadedAt());
        resp.setRemark(attachment.getRemark());
        return resp;
    }

    private ContractOperationLogRespVO toOperationLogResp(FinContractOperationLogDO log) {
        ContractOperationLogRespVO resp = new ContractOperationLogRespVO();
        resp.setLogId(log.getId());
        resp.setContractId(log.getContractId());
        resp.setOperationType(log.getOperationType());
        resp.setOperationDesc(log.getOperationDesc());
        resp.setOperatorId(log.getOperatorId());
        resp.setOperationTime(log.getOperationTime());
        resp.setBeforeJson(log.getBeforeJson());
        resp.setAfterJson(log.getAfterJson());
        resp.setRemark(log.getRemark());
        return resp;
    }

    private ContractPaymentRespVO toPaymentResp(FinContractPaymentDO payment) {
        ContractPaymentRespVO resp = new ContractPaymentRespVO();
        resp.setPaymentId(payment.getId());
        resp.setContractId(payment.getContractId());
        resp.setPaymentType(payment.getPaymentType());
        resp.setPaymentDate(payment.getPaymentDate());
        resp.setAmount(payment.getAmount());
        resp.setBankAccountId(payment.getBankAccountId());
        resp.setCashAccountId(payment.getCashAccountId());
        resp.setJournalId(payment.getJournalId());
        resp.setVoucherId(payment.getVoucherId());
        resp.setStatus(payment.getStatus());
        resp.setCreatedAt(payment.getCreatedAt());
        resp.setRemark(payment.getRemark());
        return resp;
    }

    private <T> List<T> applyPagination(List<T> source, Integer pageNo, Integer pageSize) {
        if (pageNo == null || pageSize == null || pageNo <= 0 || pageSize <= 0) {
            return source;
        }
        int from = Math.max((pageNo - 1) * pageSize, 0);
        if (from >= source.size()) {
            return List.of();
        }
        int to = Math.min(from + pageSize, source.size());
        return source.subList(from, to);
    }

    private record AccountRef(String accountType, Long accountId, Long subjectId) {
    }
}
