package com.agriculture.villagefinance.module.finance.controller;

import com.agriculture.villagefinance.common.pojo.CommonResult;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractAcceptanceCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractAcceptanceRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractAttachmentCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractAttachmentRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractChangeCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractChangeRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractOperationLogRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractPageRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractRenewalCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractRenewalRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractTerminationCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractTerminationRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ContractUpdateReqVO;
import com.agriculture.villagefinance.module.finance.service.FinanceContractService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping({"/api/village-finance/contracts", "/api/contract"})
public class ContractController {

    private final FinanceContractService financeContractService;

    @GetMapping("")
    public CommonResult<ContractPageRespVO> page(@RequestParam Integer pageNo,
                                                 @RequestParam Integer pageSize,
                                                 @RequestParam(required = false) Long ledgerId,
                                                 @RequestParam(required = false) String contractName,
                                                 @RequestParam(required = false) String contractType,
                                                 @RequestParam(required = false) String status) {
        return CommonResult.success(financeContractService.getContractPage(
                pageNo, pageSize, ledgerId, contractName, contractType, status));
    }

    @GetMapping("/page")
    public CommonResult<ContractPageRespVO> pageCompat(@RequestParam Integer pageNo,
                                                       @RequestParam Integer pageSize,
                                                       @RequestParam(required = false) Long ledgerId,
                                                       @RequestParam(required = false) String contractName,
                                                       @RequestParam(required = false) String contractType,
                                                       @RequestParam(required = false) String status) {
        return page(pageNo, pageSize, ledgerId, contractName, contractType, status);
    }

    @PostMapping("")
    public CommonResult<ContractRespVO> create(@Valid @RequestBody ContractCreateReqVO reqVO) {
        return CommonResult.success(financeContractService.createContract(reqVO));
    }

    @PostMapping("/create")
    public CommonResult<ContractRespVO> createCompat(@Valid @RequestBody ContractCreateReqVO reqVO) {
        return create(reqVO);
    }

    @PutMapping("/update")
    public CommonResult<ContractRespVO> update(@Valid @RequestBody ContractUpdateReqVO reqVO) {
        return CommonResult.success(financeContractService.updateContract(reqVO));
    }

    @GetMapping("/detail")
    public CommonResult<ContractRespVO> detail(@RequestParam Long contractId) {
        return CommonResult.success(financeContractService.getContract(contractId));
    }

    @GetMapping("/{contractId}")
    public CommonResult<ContractRespVO> detailByPath(@PathVariable Long contractId) {
        return CommonResult.success(financeContractService.getContract(contractId));
    }

    @DeleteMapping("/delete")
    public CommonResult<Boolean> delete(@RequestParam Long contractId,
                                        @RequestParam(required = false) Long operatorId) {
        financeContractService.deleteContract(contractId, operatorId);
        return CommonResult.success(true);
    }

    @PostMapping("/change")
    public CommonResult<ContractChangeRespVO> createChange(@Valid @RequestBody ContractChangeCreateReqVO reqVO) {
        return CommonResult.success(financeContractService.createChange(reqVO));
    }

    @GetMapping("/change/list")
    public CommonResult<List<ContractChangeRespVO>> getChangeList(@RequestParam Long contractId) {
        return CommonResult.success(financeContractService.getChangeList(contractId));
    }

    @PostMapping("/accept")
    public CommonResult<ContractAcceptanceRespVO> createAcceptance(@Valid @RequestBody ContractAcceptanceCreateReqVO reqVO) {
        return CommonResult.success(financeContractService.createAcceptance(reqVO));
    }

    @GetMapping("/accept/list")
    public CommonResult<List<ContractAcceptanceRespVO>> getAcceptanceList(@RequestParam Long contractId) {
        return CommonResult.success(financeContractService.getAcceptanceList(contractId));
    }

    @PostMapping("/terminate")
    public CommonResult<ContractTerminationRespVO> createTermination(@Valid @RequestBody ContractTerminationCreateReqVO reqVO) {
        return CommonResult.success(financeContractService.createTermination(reqVO));
    }

    @GetMapping("/terminate/list")
    public CommonResult<List<ContractTerminationRespVO>> getTerminationList(@RequestParam Long contractId) {
        return CommonResult.success(financeContractService.getTerminationList(contractId));
    }

    @PostMapping("/renew")
    public CommonResult<ContractRenewalRespVO> createRenewal(@Valid @RequestBody ContractRenewalCreateReqVO reqVO) {
        return CommonResult.success(financeContractService.createRenewal(reqVO));
    }

    @GetMapping("/renew/list")
    public CommonResult<List<ContractRenewalRespVO>> getRenewalList(@RequestParam Long contractId) {
        return CommonResult.success(financeContractService.getRenewalList(contractId));
    }

    @PostMapping("/attachment/upload")
    public CommonResult<ContractAttachmentRespVO> uploadAttachment(@Valid @RequestBody ContractAttachmentCreateReqVO reqVO) {
        return CommonResult.success(financeContractService.createAttachment(reqVO));
    }

    @GetMapping("/attachment/list")
    public CommonResult<List<ContractAttachmentRespVO>> getAttachmentList(@RequestParam Long contractId,
                                                                          @RequestParam(required = false) String bizType) {
        return CommonResult.success(financeContractService.getAttachmentList(contractId, bizType));
    }

    @GetMapping("/operation-log/list")
    public CommonResult<List<ContractOperationLogRespVO>> getOperationLogs(@RequestParam Long contractId) {
        return CommonResult.success(financeContractService.getOperationLogList(contractId));
    }
}
