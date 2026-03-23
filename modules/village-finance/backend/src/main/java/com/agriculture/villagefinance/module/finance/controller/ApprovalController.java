package com.agriculture.villagefinance.module.finance.controller;

import com.agriculture.villagefinance.common.pojo.CommonResult;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalHistoryRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalInstanceRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalInstanceStartReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalProcessCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalProcessRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalProcessUpdateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalTaskActionReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalTaskRespVO;
import com.agriculture.villagefinance.module.finance.service.FinanceApprovalService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
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
@RequestMapping({"/api/village-finance/approvals", "/api/approval"})
public class ApprovalController {

    private final FinanceApprovalService financeApprovalService;

    @PostMapping("/process-definitions")
    public CommonResult<ApprovalProcessRespVO> createProcessDefinition(@Valid @RequestBody ApprovalProcessCreateReqVO reqVO) {
        return CommonResult.success(financeApprovalService.createProcessDefinition(reqVO));
    }

    @PutMapping("/process-definitions/{processId}")
    public CommonResult<ApprovalProcessRespVO> updateProcessDefinition(@PathVariable Long processId,
                                                                       @Valid @RequestBody ApprovalProcessUpdateReqVO reqVO) {
        reqVO.setProcessId(processId);
        return CommonResult.success(financeApprovalService.updateProcessDefinition(reqVO));
    }

    @GetMapping("/process-definitions")
    public CommonResult<List<ApprovalProcessRespVO>> getProcessDefinitions(@RequestParam(required = false) String bizType,
                                                                           @RequestParam(required = false) Integer enableFlag) {
        return CommonResult.success(financeApprovalService.getProcessDefinitionList(bizType, enableFlag));
    }

    @PostMapping("/process-definitions/{processId}/enable")
    public CommonResult<ApprovalProcessRespVO> enableProcessDefinition(@PathVariable Long processId,
                                                                       @RequestParam(required = false) Long operatorId) {
        return CommonResult.success(financeApprovalService.enableProcessDefinition(processId, operatorId));
    }

    @PostMapping("/process-definitions/{processId}/disable")
    public CommonResult<ApprovalProcessRespVO> disableProcessDefinition(@PathVariable Long processId,
                                                                        @RequestParam(required = false) Long operatorId) {
        return CommonResult.success(financeApprovalService.disableProcessDefinition(processId, operatorId));
    }

    @PostMapping("/instances/start")
    public CommonResult<ApprovalInstanceRespVO> startProcessInstance(@Valid @RequestBody ApprovalInstanceStartReqVO reqVO) {
        return CommonResult.success(financeApprovalService.startProcessInstance(reqVO));
    }

    @GetMapping("/instances/{instanceId}")
    public CommonResult<ApprovalInstanceRespVO> getProcessInstance(@PathVariable Long instanceId) {
        return CommonResult.success(financeApprovalService.getProcessInstance(instanceId));
    }

    @GetMapping("/instances")
    public CommonResult<List<ApprovalInstanceRespVO>> getProcessInstances(@RequestParam(required = false) String bizType,
                                                                          @RequestParam(required = false) Long bizId,
                                                                          @RequestParam(required = false) String approveStatus) {
        return CommonResult.success(financeApprovalService.getProcessInstanceList(bizType, bizId, approveStatus));
    }

    @GetMapping("/tasks/todo")
    public CommonResult<List<ApprovalTaskRespVO>> getTodoTasks(@RequestParam Long approverId) {
        return CommonResult.success(financeApprovalService.getTodoTasks(approverId));
    }

    @GetMapping("/tasks/done")
    public CommonResult<List<ApprovalTaskRespVO>> getDoneTasks(@RequestParam Long approverId) {
        return CommonResult.success(financeApprovalService.getDoneTasks(approverId));
    }

    @PostMapping("/tasks/{taskId}/actions")
    public CommonResult<ApprovalTaskRespVO> handleTask(@PathVariable Long taskId,
                                                       @Valid @RequestBody ApprovalTaskActionReqVO reqVO) {
        return CommonResult.success(financeApprovalService.handleTask(taskId, reqVO));
    }

    @GetMapping("/instances/{instanceId}/history")
    public CommonResult<List<ApprovalHistoryRespVO>> getProcessHistory(@PathVariable Long instanceId) {
        return CommonResult.success(financeApprovalService.getProcessHistory(instanceId));
    }
}
