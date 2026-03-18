package com.agriculture.villagefinance.module.finance.service.impl;

import com.agriculture.villagefinance.module.finance.constant.FinanceVoucherType;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherActionRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherCreateReqVO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinVoucherDO;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinVoucherMapper;
import com.agriculture.villagefinance.module.finance.service.BizVoucherLinkService;
import com.agriculture.villagefinance.module.finance.service.VoucherService;
import com.agriculture.villagefinance.module.finance.service.dto.BizVoucherCreateCmd;
import com.agriculture.villagefinance.module.finance.service.dto.BizVoucherTraceRespVO;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Objects;

@Service
@RequiredArgsConstructor
public class BizVoucherLinkServiceImpl implements BizVoucherLinkService {

    private final VoucherService voucherService;
    private final FinVoucherMapper finVoucherMapper;

    @Override
    public VoucherActionRespVO createVoucher(BizVoucherCreateCmd cmd) {
        validateCreateCmd(cmd);
        String voucherType = FinanceVoucherType.normalize(cmd.getVoucherType());
        FinanceVoucherType.validateAllowed(voucherType);
        if (!FinanceVoucherType.isManagedType(voucherType)) {
            throw new IllegalArgumentException("业务凭证必须使用受管来源类型");
        }
        ensureBizUnlinked(voucherType, cmd.getBizId(), cmd.getLedgerId());

        VoucherCreateReqVO reqVO = new VoucherCreateReqVO();
        reqVO.setLedgerId(cmd.getLedgerId());
        reqVO.setPeriodId(cmd.getPeriodId());
        reqVO.setVoucherDate(cmd.getVoucherDate());
        reqVO.setVoucherType(voucherType);
        reqVO.setBizId(cmd.getBizId());
        reqVO.setSummary(cmd.getSummary());
        reqVO.setRemark(cmd.getRemark());
        reqVO.setCreatedBy(defaultOperator(cmd.getOperatorId()));
        reqVO.setEntries(cmd.getEntries());

        VoucherActionRespVO respVO = voucherService.createVoucher(reqVO);
        FinVoucherDO persisted = requireVoucher(respVO.getVoucherId());
        if (!Objects.equals(persisted.getBookId(), cmd.getLedgerId())
                || !Objects.equals(persisted.getPeriodId(), cmd.getPeriodId())
                || !Objects.equals(persisted.getBizId(), cmd.getBizId())
                || !voucherType.equalsIgnoreCase(persisted.getVoucherType())) {
            throw new IllegalStateException("业务凭证关联校验失败");
        }
        return respVO;
    }

    @Override
    public BizVoucherTraceRespVO traceByVoucherId(Long voucherId) {
        return toTraceResp(requireVoucher(voucherId));
    }

    @Override
    public BizVoucherTraceRespVO queryVoucherByBiz(String voucherType, Long bizId) {
        if (bizId == null) {
            throw new IllegalArgumentException("bizId不能为空");
        }
        String normalizedType = FinanceVoucherType.normalize(voucherType);
        FinanceVoucherType.validateAllowed(normalizedType);
        FinVoucherDO voucher = finVoucherMapper.selectOne(new LambdaQueryWrapper<FinVoucherDO>()
                .eq(FinVoucherDO::getVoucherType, normalizedType)
                .eq(FinVoucherDO::getBizId, bizId)
                .orderByDesc(FinVoucherDO::getId)
                .last("limit 1"));
        if (voucher == null) {
            throw new IllegalArgumentException("业务凭证不存在");
        }
        return toTraceResp(voucher);
    }

    private void validateCreateCmd(BizVoucherCreateCmd cmd) {
        if (cmd == null) {
            throw new IllegalArgumentException("创建业务凭证参数不能为空");
        }
        if (cmd.getLedgerId() == null || cmd.getPeriodId() == null || cmd.getVoucherDate() == null) {
            throw new IllegalArgumentException("账套、期间、凭证日期不能为空");
        }
        if (cmd.getBizId() == null) {
            throw new IllegalArgumentException("业务单据ID不能为空");
        }
        if (cmd.getEntries() == null || cmd.getEntries().isEmpty()) {
            throw new IllegalArgumentException("凭证分录不能为空");
        }
    }

    private void ensureBizUnlinked(String voucherType, Long bizId, Long ledgerId) {
        long count = finVoucherMapper.selectCount(new LambdaQueryWrapper<FinVoucherDO>()
                .eq(FinVoucherDO::getVoucherType, voucherType)
                .eq(FinVoucherDO::getBizId, bizId)
                .eq(FinVoucherDO::getBookId, ledgerId));
        if (count > 0) {
            throw new IllegalStateException("业务单据已关联凭证");
        }
    }

    private FinVoucherDO requireVoucher(Long voucherId) {
        FinVoucherDO voucher = finVoucherMapper.selectById(voucherId);
        if (voucher == null) {
            throw new IllegalArgumentException("凭证不存在");
        }
        return voucher;
    }

    private Long defaultOperator(Long operatorId) {
        return operatorId == null ? 0L : operatorId;
    }

    private BizVoucherTraceRespVO toTraceResp(FinVoucherDO voucher) {
        BizVoucherTraceRespVO vo = new BizVoucherTraceRespVO();
        vo.setVoucherId(voucher.getId());
        vo.setVoucherNo(voucher.getVoucherNo());
        vo.setVoucherType(voucher.getVoucherType());
        vo.setBizId(voucher.getBizId());
        vo.setLedgerId(voucher.getBookId());
        vo.setPeriodId(voucher.getPeriodId());
        vo.setStatus(voucher.getStatus());
        vo.setVoucherDate(voucher.getVoucherDate());
        return vo;
    }
}
