package com.agriculture.villagefinance.module.finance.controller;

import com.agriculture.villagefinance.common.pojo.CommonResult;
import com.agriculture.villagefinance.module.finance.controller.vo.SubjectTreeRespVO;
import com.agriculture.villagefinance.module.finance.service.FinanceFoundationQueryService;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Validated
@RestController
@RequestMapping("/api/village-finance/subjects")
@RequiredArgsConstructor
public class SubjectController {

    private final FinanceFoundationQueryService financeFoundationQueryService;

    @GetMapping("/tree")
    public CommonResult<List<SubjectTreeRespVO>> getSubjectTree(@RequestParam @NotNull Long ledgerId) {
        return CommonResult.success(financeFoundationQueryService.getSubjectTree(ledgerId));
    }
}
