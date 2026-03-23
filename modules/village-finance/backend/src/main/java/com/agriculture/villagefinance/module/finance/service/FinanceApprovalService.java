package com.agriculture.villagefinance.module.finance.service;

import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalHistoryRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalInstanceRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalInstanceStartReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalProcessCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalProcessRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalProcessUpdateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalTaskActionReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalTaskRespVO;

import java.util.List;

public interface FinanceApprovalService {

    ApprovalProcessRespVO createProcessDefinition(ApprovalProcessCreateReqVO reqVO);

    ApprovalProcessRespVO updateProcessDefinition(ApprovalProcessUpdateReqVO reqVO);

    List<ApprovalProcessRespVO> getProcessDefinitionList(String bizType, Integer enableFlag);

    ApprovalProcessRespVO enableProcessDefinition(Long processId, Long operatorId);

    ApprovalProcessRespVO disableProcessDefinition(Long processId, Long operatorId);

    ApprovalInstanceRespVO startProcessInstance(ApprovalInstanceStartReqVO reqVO);

    ApprovalInstanceRespVO getProcessInstance(Long instanceId);

    List<ApprovalInstanceRespVO> getProcessInstanceList(String bizType, Long bizId, String approveStatus);

    List<ApprovalTaskRespVO> getTodoTasks(Long approverId);

    List<ApprovalTaskRespVO> getDoneTasks(Long approverId);

    ApprovalTaskRespVO handleTask(Long taskId, ApprovalTaskActionReqVO reqVO);

    List<ApprovalHistoryRespVO> getProcessHistory(Long instanceId);
}
