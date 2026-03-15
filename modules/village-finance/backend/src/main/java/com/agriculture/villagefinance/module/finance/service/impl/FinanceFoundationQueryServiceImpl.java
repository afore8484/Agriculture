package com.agriculture.villagefinance.module.finance.service.impl;

import com.agriculture.villagefinance.module.finance.controller.vo.LedgerRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.PeriodRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.SubjectTreeRespVO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinBookDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinPeriodDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinSubjectDO;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinBookMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinSubjectMapper;
import com.agriculture.villagefinance.module.finance.service.FinanceFoundationQueryService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class FinanceFoundationQueryServiceImpl implements FinanceFoundationQueryService {

    private final FinBookMapper finBookMapper;
    private final FinPeriodMapper finPeriodMapper;
    private final FinSubjectMapper finSubjectMapper;

    @Override
    public List<LedgerRespVO> getLedgers(String orgCode, String status) {
        LambdaQueryWrapper<FinBookDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByAsc(FinBookDO::getId);
        if (StringUtils.hasText(orgCode)) {
            wrapper.eq(FinBookDO::getOrgCode, orgCode);
        }
        if (StringUtils.hasText(status)) {
            wrapper.eq(FinBookDO::getStatus, status);
        }
        return finBookMapper.selectList(wrapper).stream().map(item -> {
            LedgerRespVO vo = new LedgerRespVO();
            vo.setLedgerId(item.getId());
            vo.setLedgerName(item.getBookName());
            vo.setStatus(item.getStatus());
            return vo;
        }).toList();
    }

    @Override
    public List<PeriodRespVO> getPeriods(Long ledgerId, Integer year) {
        LambdaQueryWrapper<FinPeriodDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FinPeriodDO::getBookId, ledgerId)
                .orderByAsc(FinPeriodDO::getPeriodYear, FinPeriodDO::getPeriodNo);
        if (year != null) {
            wrapper.eq(FinPeriodDO::getPeriodYear, year);
        }
        return finPeriodMapper.selectList(wrapper).stream().map(item -> {
            PeriodRespVO vo = new PeriodRespVO();
            vo.setPeriodId(item.getId());
            vo.setPeriodName(item.getPeriodYear() + "-" + String.format("%02d", item.getPeriodNo()));
            vo.setCloseStatus(item.getCloseStatus());
            return vo;
        }).toList();
    }

    @Override
    public List<SubjectTreeRespVO> getSubjectTree(Long ledgerId) {
        LambdaQueryWrapper<FinSubjectDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FinSubjectDO::getBookId, ledgerId)
                .eq(FinSubjectDO::getEnableFlag, 1)
                .orderByAsc(FinSubjectDO::getSubjectCode);
        List<FinSubjectDO> subjects = finSubjectMapper.selectList(wrapper);
        Map<String, SubjectTreeRespVO> nodeMap = new LinkedHashMap<>();
        List<SubjectTreeRespVO> roots = new ArrayList<>();
        subjects.stream()
                .sorted(Comparator.comparing(FinSubjectDO::getSubjectCode))
                .forEach(subject -> nodeMap.put(subject.getSubjectCode(), toSubjectNode(subject)));
        subjects.stream()
                .sorted(Comparator.comparing(FinSubjectDO::getSubjectCode))
                .forEach(subject -> {
                    SubjectTreeRespVO node = nodeMap.get(subject.getSubjectCode());
                    if (!StringUtils.hasText(subject.getParentCode()) || !nodeMap.containsKey(subject.getParentCode())) {
                        roots.add(node);
                        return;
                    }
                    nodeMap.get(subject.getParentCode()).getChildren().add(node);
                });
        return roots;
    }

    private SubjectTreeRespVO toSubjectNode(FinSubjectDO subject) {
        SubjectTreeRespVO vo = new SubjectTreeRespVO();
        vo.setSubjectCode(subject.getSubjectCode());
        vo.setSubjectName(subject.getSubjectName());
        vo.setParentCode(subject.getParentCode());
        vo.setAssistFlag(subject.getAssistFlag() != null && subject.getAssistFlag() == 1);
        return vo;
    }
}
