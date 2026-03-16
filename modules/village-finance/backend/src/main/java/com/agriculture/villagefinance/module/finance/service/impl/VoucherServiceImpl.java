package com.agriculture.villagefinance.module.finance.service.impl;

import com.agriculture.villagefinance.module.finance.controller.vo.VoucherActionRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherAttachmentRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherAuditReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherDeleteRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherDetailRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherEntryReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherEntryRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherListRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherRecycleRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherUnauditReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherUpdateReqVO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinBookDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinSubjectDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinVoucherAttachmentDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinVoucherAuditLogDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinVoucherDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinVoucherEntryDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinVoucherOperationLogDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinVoucherRecycleDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinVoucherRecycleEntryDO;
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
import com.agriculture.villagefinance.module.finance.service.VoucherService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class VoucherServiceImpl implements VoucherService {

    private static final String STATUS_DRAFT = "DRAFT";
    private static final String STATUS_AUDITED = "AUDITED";

    private final FinBookMapper finBookMapper;
    private final FinPeriodMapper finPeriodMapper;
    private final FinSubjectMapper finSubjectMapper;
    private final FinVoucherMapper finVoucherMapper;
    private final FinVoucherEntryMapper finVoucherEntryMapper;
    private final FinVoucherAttachmentMapper finVoucherAttachmentMapper;
    private final FinVoucherAuditLogMapper finVoucherAuditLogMapper;
    private final FinVoucherOperationLogMapper finVoucherOperationLogMapper;
    private final FinVoucherRecycleMapper finVoucherRecycleMapper;
    private final FinVoucherRecycleEntryMapper finVoucherRecycleEntryMapper;
    private final ObjectMapper objectMapper;

    @Override
    public List<VoucherListRespVO> getVouchers(Long ledgerId, Long periodId, String voucherNo, String auditStatus,
                                               LocalDate startDate, LocalDate endDate, Integer pageNum, Integer pageSize) {
        LambdaQueryWrapper<FinVoucherDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FinVoucherDO::getBookId, ledgerId)
                .orderByDesc(FinVoucherDO::getVoucherDate)
                .orderByDesc(FinVoucherDO::getId);
        if (periodId != null) {
            wrapper.eq(FinVoucherDO::getPeriodId, periodId);
        }
        if (StringUtils.hasText(voucherNo)) {
            wrapper.like(FinVoucherDO::getVoucherNo, voucherNo.trim());
        }
        if (StringUtils.hasText(auditStatus)) {
            wrapper.eq(FinVoucherDO::getStatus, auditStatus.trim().toUpperCase());
        }
        if (startDate != null) {
            wrapper.ge(FinVoucherDO::getVoucherDate, startDate);
        }
        if (endDate != null) {
            wrapper.le(FinVoucherDO::getVoucherDate, endDate);
        }
        List<FinVoucherDO> vouchers = applyPagination(finVoucherMapper.selectList(wrapper), pageNum, pageSize);
        return vouchers.stream().map(this::toVoucherListVO).toList();
    }

    @Override
    public VoucherDetailRespVO getVoucher(Long voucherId) {
        FinVoucherDO voucher = requireVoucher(voucherId);
        List<FinVoucherEntryDO> entries = finVoucherEntryMapper.selectList(new LambdaQueryWrapper<FinVoucherEntryDO>()
                .eq(FinVoucherEntryDO::getVoucherId, voucherId)
                .orderByAsc(FinVoucherEntryDO::getLineNo));
        List<FinVoucherAttachmentDO> attachments = finVoucherAttachmentMapper.selectList(new LambdaQueryWrapper<FinVoucherAttachmentDO>()
                .eq(FinVoucherAttachmentDO::getVoucherId, voucherId)
                .orderByAsc(FinVoucherAttachmentDO::getId));
        return buildVoucherDetail(voucher, entries, attachments);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public VoucherActionRespVO createVoucher(VoucherCreateReqVO reqVO) {
        FinBookDO book = requireBook(reqVO.getLedgerId());
        FinPeriodDO period = requirePeriod(reqVO.getPeriodId(), reqVO.getLedgerId());
        validateEntries(reqVO.getEntries());
        LocalDateTime now = LocalDateTime.now();
        FinVoucherDO voucher = new FinVoucherDO();
        voucher.setVoucherNo(generateVoucherNo(book, period, reqVO.getVoucherDate()));
        voucher.setVoucherDate(reqVO.getVoucherDate());
        voucher.setVoucherType(StringUtils.hasText(reqVO.getVoucherType()) ? reqVO.getVoucherType() : "MANUAL");
        voucher.setBookId(reqVO.getLedgerId());
        voucher.setPeriodId(reqVO.getPeriodId());
        voucher.setAttachmentCount(reqVO.getAttachmentIds() == null ? 0 : reqVO.getAttachmentIds().size());
        voucher.setTotalDebit(sumAmount(reqVO.getEntries(), true));
        voucher.setTotalCredit(sumAmount(reqVO.getEntries(), false));
        voucher.setStatus(STATUS_DRAFT);
        voucher.setCreatedBy(reqVO.getCreatedBy());
        voucher.setCreatedAt(now);
        voucher.setRemark(reqVO.getRemark());
        finVoucherMapper.insert(voucher);
        saveEntries(voucher.getId(), reqVO.getSummary(), reqVO.getEntries());
        writeOperationLog(voucher.getId(), "CREATE", reqVO.getCreatedBy(), null, voucherSnapshotJson(voucher.getId()), "新增凭证");
        return actionResp(voucher);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public VoucherActionRespVO updateVoucher(Long voucherId, VoucherUpdateReqVO reqVO) {
        FinVoucherDO voucher = requireVoucher(voucherId);
        ensureDraft(voucher, "仅未审核凭证允许修改");
        validateEntries(reqVO.getEntries());
        String beforeJson = voucherSnapshotJson(voucherId);
        voucher.setVoucherDate(reqVO.getVoucherDate() != null ? reqVO.getVoucherDate() : voucher.getVoucherDate());
        if (StringUtils.hasText(reqVO.getVoucherType())) {
            voucher.setVoucherType(reqVO.getVoucherType());
        }
        voucher.setAttachmentCount(reqVO.getAttachmentIds() == null ? voucher.getAttachmentCount() : reqVO.getAttachmentIds().size());
        voucher.setTotalDebit(sumAmount(reqVO.getEntries(), true));
        voucher.setTotalCredit(sumAmount(reqVO.getEntries(), false));
        voucher.setRemark(reqVO.getRemark());
        finVoucherMapper.updateById(voucher);
        finVoucherEntryMapper.delete(new LambdaQueryWrapper<FinVoucherEntryDO>().eq(FinVoucherEntryDO::getVoucherId, voucherId));
        saveEntries(voucherId, reqVO.getSummary(), reqVO.getEntries());
        writeOperationLog(voucherId, "UPDATE", reqVO.getOperatorId(), beforeJson, voucherSnapshotJson(voucherId), "修改凭证");
        return actionResp(voucher);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public VoucherActionRespVO auditVoucher(Long voucherId, VoucherAuditReqVO reqVO) {
        FinVoucherDO voucher = requireVoucher(voucherId);
        ensureDraft(voucher, "仅未审核凭证允许审核");
        voucher.setStatus(STATUS_AUDITED);
        voucher.setAuditedBy(reqVO.getOperatorId());
        voucher.setAuditedAt(LocalDateTime.now());
        finVoucherMapper.updateById(voucher);
        writeAuditLog(voucherId, "AUDIT", reqVO.getOperatorId(), reqVO.getAuditRemark());
        writeOperationLog(voucherId, "AUDIT", reqVO.getOperatorId(), null, voucherSnapshotJson(voucherId), "审核凭证");
        return actionResp(voucher);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public VoucherActionRespVO unauditVoucher(Long voucherId, VoucherUnauditReqVO reqVO) {
        FinVoucherDO voucher = requireVoucher(voucherId);
        if (!STATUS_AUDITED.equalsIgnoreCase(voucher.getStatus())) {
            throw new IllegalStateException("仅已审核凭证允许反审核");
        }
        voucher.setStatus(STATUS_DRAFT);
        voucher.setAuditedBy(null);
        voucher.setAuditedAt(null);
        finVoucherMapper.updateById(voucher);
        writeAuditLog(voucherId, "UNAUDIT", reqVO.getOperatorId(), reqVO.getReason());
        writeOperationLog(voucherId, "UNAUDIT", reqVO.getOperatorId(), null, voucherSnapshotJson(voucherId), "反审核凭证");
        return actionResp(voucher);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public VoucherDeleteRespVO deleteVoucher(Long voucherId, String reason, Long operatorId) {
        FinVoucherDO voucher = requireVoucher(voucherId);
        ensureDraft(voucher, "仅未审核凭证允许删除");
        List<FinVoucherEntryDO> entries = finVoucherEntryMapper.selectList(new LambdaQueryWrapper<FinVoucherEntryDO>()
                .eq(FinVoucherEntryDO::getVoucherId, voucherId)
                .orderByAsc(FinVoucherEntryDO::getLineNo));
        FinVoucherRecycleDO recycle = new FinVoucherRecycleDO();
        recycle.setOriginalVoucherId(voucher.getId());
        recycle.setVoucherNo(voucher.getVoucherNo());
        recycle.setVoucherDate(voucher.getVoucherDate());
        recycle.setVoucherType(voucher.getVoucherType());
        recycle.setBookId(voucher.getBookId());
        recycle.setPeriodId(voucher.getPeriodId());
        recycle.setTotalDebit(voucher.getTotalDebit());
        recycle.setTotalCredit(voucher.getTotalCredit());
        recycle.setDeleteReason(reason);
        recycle.setDeletedBy(defaultOperator(operatorId));
        recycle.setDeletedAt(LocalDateTime.now());
        recycle.setRestoreFlag(0);
        recycle.setPurgeFlag(0);
        recycle.setVoucherSnapshot(toJson(buildVoucherDetail(voucher, entries, List.of())));
        recycle.setRemark(voucher.getRemark());
        finVoucherRecycleMapper.insert(recycle);
        for (FinVoucherEntryDO entry : entries) {
            FinVoucherRecycleEntryDO recycleEntry = new FinVoucherRecycleEntryDO();
            recycleEntry.setRecycleId(recycle.getId());
            recycleEntry.setLineNo(entry.getLineNo());
            recycleEntry.setSubjectId(entry.getSubjectId());
            recycleEntry.setSummary(entry.getSummary());
            recycleEntry.setDebitAmount(entry.getDebitAmount());
            recycleEntry.setCreditAmount(entry.getCreditAmount());
            recycleEntry.setAssistJson(toJson(Map.of("auxType", entry.getAuxType(), "auxId", entry.getAuxId())));
            recycleEntry.setRemark(entry.getRemark());
            finVoucherRecycleEntryMapper.insert(recycleEntry);
        }
        writeOperationLog(voucherId, "DELETE", defaultOperator(operatorId), voucherSnapshotJson(voucherId), null, "删除并进入回收站");
        finVoucherEntryMapper.delete(new LambdaQueryWrapper<FinVoucherEntryDO>().eq(FinVoucherEntryDO::getVoucherId, voucherId));
        finVoucherAttachmentMapper.delete(new LambdaQueryWrapper<FinVoucherAttachmentDO>().eq(FinVoucherAttachmentDO::getVoucherId, voucherId));
        finVoucherMapper.deleteById(voucherId);
        VoucherDeleteRespVO respVO = new VoucherDeleteRespVO();
        respVO.setVoucherId(voucherId);
        respVO.setDeletedFlag(Boolean.TRUE);
        return respVO;
    }

    @Override
    public List<VoucherRecycleRespVO> getRecycleVouchers(Long ledgerId, Integer pageNum, Integer pageSize) {
        LambdaQueryWrapper<FinVoucherRecycleDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FinVoucherRecycleDO::getBookId, ledgerId)
                .eq(FinVoucherRecycleDO::getPurgeFlag, 0)
                .eq(FinVoucherRecycleDO::getRestoreFlag, 0)
                .orderByDesc(FinVoucherRecycleDO::getDeletedAt);
        return applyPagination(finVoucherRecycleMapper.selectList(wrapper), pageNum, pageSize).stream()
                .map(item -> {
                    VoucherRecycleRespVO vo = new VoucherRecycleRespVO();
                    vo.setVoucherId(item.getOriginalVoucherId());
                    vo.setVoucherNo(item.getVoucherNo());
                    vo.setDeletedTime(item.getDeletedAt());
                    return vo;
                }).toList();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public VoucherActionRespVO restoreVoucher(Long voucherId, Long operatorId) {
        FinVoucherRecycleDO recycle = requireRecycleVoucher(voucherId);
        FinVoucherDO voucher = new FinVoucherDO();
        voucher.setVoucherNo(recycle.getVoucherNo());
        voucher.setVoucherDate(recycle.getVoucherDate());
        voucher.setVoucherType(recycle.getVoucherType());
        voucher.setBookId(recycle.getBookId());
        voucher.setPeriodId(recycle.getPeriodId());
        voucher.setAttachmentCount(0);
        voucher.setTotalDebit(recycle.getTotalDebit());
        voucher.setTotalCredit(recycle.getTotalCredit());
        voucher.setStatus(STATUS_DRAFT);
        voucher.setCreatedBy(defaultOperator(operatorId));
        voucher.setCreatedAt(LocalDateTime.now());
        voucher.setRemark(recycle.getRemark());
        finVoucherMapper.insert(voucher);
        List<FinVoucherRecycleEntryDO> recycleEntries = finVoucherRecycleEntryMapper.selectList(new LambdaQueryWrapper<FinVoucherRecycleEntryDO>()
                .eq(FinVoucherRecycleEntryDO::getRecycleId, recycle.getId())
                .orderByAsc(FinVoucherRecycleEntryDO::getLineNo));
        for (FinVoucherRecycleEntryDO recycleEntry : recycleEntries) {
            FinVoucherEntryDO entry = new FinVoucherEntryDO();
            entry.setVoucherId(voucher.getId());
            entry.setLineNo(recycleEntry.getLineNo());
            entry.setSubjectId(recycleEntry.getSubjectId());
            entry.setSummary(recycleEntry.getSummary());
            entry.setDebitAmount(recycleEntry.getDebitAmount());
            entry.setCreditAmount(recycleEntry.getCreditAmount());
            entry.setSortOrder(recycleEntry.getLineNo());
            entry.setRemark(recycleEntry.getRemark());
            finVoucherEntryMapper.insert(entry);
        }
        recycle.setRestoreFlag(1);
        finVoucherRecycleMapper.updateById(recycle);
        writeOperationLog(voucher.getId(), "RESTORE", defaultOperator(operatorId), null, voucherSnapshotJson(voucher.getId()), "回收站还原凭证");
        return actionResp(voucher);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public VoucherDeleteRespVO purgeRecycleVoucher(Long voucherId, Long operatorId) {
        FinVoucherRecycleDO recycle = requireRecycleVoucher(voucherId);
        finVoucherRecycleEntryMapper.delete(new LambdaQueryWrapper<FinVoucherRecycleEntryDO>()
                .eq(FinVoucherRecycleEntryDO::getRecycleId, recycle.getId()));
        finVoucherRecycleMapper.deleteById(recycle.getId());
        FinVoucherOperationLogDO logDO = new FinVoucherOperationLogDO();
        logDO.setVoucherId(voucherId);
        logDO.setOperationType("PURGE");
        logDO.setOperatorId(defaultOperator(operatorId));
        logDO.setOperationTime(LocalDateTime.now());
        logDO.setOperationDesc("彻底删除回收站凭证");
        logDO.setBeforeJson(recycle.getVoucherSnapshot());
        finVoucherOperationLogMapper.insert(logDO);
        VoucherDeleteRespVO respVO = new VoucherDeleteRespVO();
        respVO.setVoucherId(voucherId);
        respVO.setDeletedFlag(Boolean.TRUE);
        return respVO;
    }

    private FinBookDO requireBook(Long ledgerId) {
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

    private FinVoucherDO requireVoucher(Long voucherId) {
        FinVoucherDO voucher = finVoucherMapper.selectById(voucherId);
        if (voucher == null) {
            throw new IllegalArgumentException("凭证不存在");
        }
        return voucher;
    }

    private FinVoucherRecycleDO requireRecycleVoucher(Long originalVoucherId) {
        FinVoucherRecycleDO recycle = finVoucherRecycleMapper.selectOne(new LambdaQueryWrapper<FinVoucherRecycleDO>()
                .eq(FinVoucherRecycleDO::getOriginalVoucherId, originalVoucherId)
                .eq(FinVoucherRecycleDO::getPurgeFlag, 0)
                .orderByDesc(FinVoucherRecycleDO::getId)
                .last("limit 1"));
        if (recycle == null) {
            throw new IllegalArgumentException("回收站凭证不存在");
        }
        return recycle;
    }

    private void ensureDraft(FinVoucherDO voucher, String message) {
        if (!STATUS_DRAFT.equalsIgnoreCase(voucher.getStatus())) {
            throw new IllegalStateException(message);
        }
    }

    private void validateEntries(List<VoucherEntryReqVO> entries) {
        if (entries == null || entries.isEmpty()) {
            throw new IllegalArgumentException("凭证明细不能为空");
        }
        BigDecimal debit = sumAmount(entries, true);
        BigDecimal credit = sumAmount(entries, false);
        if (debit.compareTo(BigDecimal.ZERO) <= 0 || credit.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("借贷金额必须大于0");
        }
        if (debit.compareTo(credit) != 0) {
            throw new IllegalArgumentException("借贷金额必须平衡");
        }
        Set<Long> subjectIds = entries.stream().map(VoucherEntryReqVO::getSubjectId).collect(Collectors.toSet());
        List<FinSubjectDO> subjects = finSubjectMapper.selectBatchIds(subjectIds);
        if (subjects.size() != subjectIds.size()) {
            throw new IllegalArgumentException("存在无效会计科目");
        }
    }

    private BigDecimal sumAmount(List<VoucherEntryReqVO> entries, boolean debit) {
        return entries.stream()
                .map(item -> debit ? item.getDebitAmount() : item.getCreditAmount())
                .filter(Objects::nonNull)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    private void saveEntries(Long voucherId, String voucherSummary, List<VoucherEntryReqVO> entries) {
        for (int i = 0; i < entries.size(); i++) {
            VoucherEntryReqVO item = entries.get(i);
            FinVoucherEntryDO entry = new FinVoucherEntryDO();
            entry.setVoucherId(voucherId);
            entry.setLineNo(i + 1);
            entry.setSubjectId(item.getSubjectId());
            entry.setSummary(StringUtils.hasText(item.getSummary()) ? item.getSummary() : voucherSummary);
            entry.setDebitAmount(item.getDebitAmount());
            entry.setCreditAmount(item.getCreditAmount());
            entry.setAuxType(item.getAuxType());
            entry.setAuxId(item.getAuxId());
            entry.setSortOrder(item.getSortOrder() == null ? i + 1 : item.getSortOrder());
            entry.setRemark(item.getRemark());
            finVoucherEntryMapper.insert(entry);
        }
    }

    private VoucherDetailRespVO buildVoucherDetail(FinVoucherDO voucher, List<FinVoucherEntryDO> entries,
                                                   List<FinVoucherAttachmentDO> attachments) {
        Map<Long, FinSubjectDO> subjectMap = loadSubjectMap(entries);
        VoucherDetailRespVO vo = new VoucherDetailRespVO();
        vo.setVoucherId(voucher.getId());
        vo.setVoucherNo(voucher.getVoucherNo());
        vo.setVoucherDate(voucher.getVoucherDate());
        vo.setVoucherType(voucher.getVoucherType());
        vo.setLedgerId(voucher.getBookId());
        vo.setPeriodId(voucher.getPeriodId());
        vo.setAttachmentCount(voucher.getAttachmentCount());
        vo.setTotalDebit(voucher.getTotalDebit());
        vo.setTotalCredit(voucher.getTotalCredit());
        vo.setAuditStatus(voucher.getStatus());
        vo.setRemark(voucher.getRemark());
        vo.setEntries(entries.stream().map(entry -> toVoucherEntryVO(entry, subjectMap.get(entry.getSubjectId()))).toList());
        vo.setAttachments(attachments.stream().map(this::toAttachmentVO).toList());
        return vo;
    }

    private Map<Long, FinSubjectDO> loadSubjectMap(List<FinVoucherEntryDO> entries) {
        Set<Long> subjectIds = entries.stream().map(FinVoucherEntryDO::getSubjectId).filter(Objects::nonNull).collect(Collectors.toSet());
        if (subjectIds.isEmpty()) {
            return Map.of();
        }
        return finSubjectMapper.selectBatchIds(subjectIds).stream()
                .collect(Collectors.toMap(FinSubjectDO::getId, item -> item, (a, b) -> a, LinkedHashMap::new));
    }

    private VoucherEntryRespVO toVoucherEntryVO(FinVoucherEntryDO entry, FinSubjectDO subject) {
        VoucherEntryRespVO vo = new VoucherEntryRespVO();
        vo.setEntryId(entry.getId());
        vo.setLineNo(entry.getLineNo());
        vo.setSubjectId(entry.getSubjectId());
        if (subject != null) {
            vo.setSubjectCode(subject.getSubjectCode());
            vo.setSubjectName(subject.getSubjectName());
        }
        vo.setSummary(entry.getSummary());
        vo.setDebitAmount(entry.getDebitAmount());
        vo.setCreditAmount(entry.getCreditAmount());
        return vo;
    }

    private VoucherAttachmentRespVO toAttachmentVO(FinVoucherAttachmentDO attachment) {
        VoucherAttachmentRespVO vo = new VoucherAttachmentRespVO();
        vo.setAttachmentId(attachment.getId());
        vo.setFileName(attachment.getFileName());
        vo.setFileUrl(attachment.getFileUrl());
        return vo;
    }

    private VoucherListRespVO toVoucherListVO(FinVoucherDO voucher) {
        VoucherListRespVO vo = new VoucherListRespVO();
        vo.setVoucherId(voucher.getId());
        vo.setVoucherNo(voucher.getVoucherNo());
        vo.setVoucherDate(voucher.getVoucherDate());
        vo.setTotalAmount(voucher.getTotalDebit());
        vo.setAuditStatus(voucher.getStatus());
        return vo;
    }

    private VoucherActionRespVO actionResp(FinVoucherDO voucher) {
        VoucherActionRespVO vo = new VoucherActionRespVO();
        vo.setVoucherId(voucher.getId());
        vo.setVoucherNo(voucher.getVoucherNo());
        vo.setStatus(voucher.getStatus());
        vo.setAuditTime(voucher.getAuditedAt());
        return vo;
    }

    private String generateVoucherNo(FinBookDO book, FinPeriodDO period, LocalDate voucherDate) {
        long count = finVoucherMapper.selectCount(new LambdaQueryWrapper<FinVoucherDO>()
                .eq(FinVoucherDO::getBookId, book.getId())
                .eq(FinVoucherDO::getPeriodId, period.getId()));
        String dateToken = voucherDate == null
                ? String.format("%d%02d", period.getPeriodYear(), period.getPeriodNo())
                : String.format("%d%02d", voucherDate.getYear(), voucherDate.getMonthValue());
        return book.getBookCode() + "-" + dateToken + "-" + String.format("%04d", count + 1);
    }

    private void writeAuditLog(Long voucherId, String action, Long operatorId, String remark) {
        FinVoucherAuditLogDO logDO = new FinVoucherAuditLogDO();
        logDO.setVoucherId(voucherId);
        logDO.setAuditAction(action);
        logDO.setAuditorId(operatorId);
        logDO.setAuditTime(LocalDateTime.now());
        logDO.setRemark(remark);
        finVoucherAuditLogMapper.insert(logDO);
    }

    private void writeOperationLog(Long voucherId, String operationType, Long operatorId,
                                   String beforeJson, String afterJson, String operationDesc) {
        FinVoucherOperationLogDO logDO = new FinVoucherOperationLogDO();
        logDO.setVoucherId(voucherId);
        logDO.setOperationType(operationType);
        logDO.setOperatorId(defaultOperator(operatorId));
        logDO.setOperationTime(LocalDateTime.now());
        logDO.setOperationDesc(operationDesc);
        logDO.setBeforeJson(beforeJson);
        logDO.setAfterJson(afterJson);
        finVoucherOperationLogMapper.insert(logDO);
    }

    private String voucherSnapshotJson(Long voucherId) {
        return toJson(getVoucher(voucherId));
    }

    private String toJson(Object value) {
        try {
            return objectMapper.writeValueAsString(value);
        } catch (JsonProcessingException e) {
            throw new IllegalStateException("凭证快照序列化失败");
        }
    }

    private Long defaultOperator(Long operatorId) {
        return operatorId == null ? 0L : operatorId;
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
}
