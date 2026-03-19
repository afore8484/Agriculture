package com.agriculture.villagefinance.module.finance.service.impl;

import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalHistoryRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalInstanceRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalInstanceStartReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalProcessCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalProcessRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalProcessUpdateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalTaskActionReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalTaskRespVO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinApproveHistoryDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinApproveInstanceDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinApproveProcessDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinApproveTaskDO;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinApproveHistoryMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinApproveInstanceMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinApproveProcessMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinApproveTaskMapper;
import com.agriculture.villagefinance.module.finance.service.FinanceApprovalService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Locale;

@Service
@RequiredArgsConstructor
public class FinanceApprovalServiceImpl implements FinanceApprovalService {

    private static final int ENABLE_FLAG = 1;
    private static final int DISABLE_FLAG = 0;

    private static final String INSTANCE_STATUS_DRAFT = "DRAFT";
    private static final String INSTANCE_STATUS_PROCESSING = "PROCESSING";
    private static final String INSTANCE_STATUS_APPROVED = "APPROVED";
    private static final String INSTANCE_STATUS_REJECTED = "REJECTED";

    private static final String TASK_STATUS_PENDING = "PENDING";
    private static final String TASK_STATUS_DONE = "DONE";

    private static final String ACTION_SUBMIT = "SUBMIT";
    private static final String ACTION_APPROVE = "APPROVE";
    private static final String ACTION_REJECT = "REJECT";

    private final FinApproveProcessMapper finApproveProcessMapper;
    private final FinApproveInstanceMapper finApproveInstanceMapper;
    private final FinApproveTaskMapper finApproveTaskMapper;
    private final FinApproveHistoryMapper finApproveHistoryMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ApprovalProcessRespVO createProcessDefinition(ApprovalProcessCreateReqVO reqVO) {
        requireProcessCodeUnique(reqVO.getProcessCode().trim());
        FinApproveProcessDO process = new FinApproveProcessDO();
        process.setProcessCode(reqVO.getProcessCode().trim());
        process.setProcessName(reqVO.getProcessName().trim());
        process.setBizType(reqVO.getBizType().trim().toUpperCase(Locale.ROOT));
        process.setVersionNo(1);
        process.setEnableFlag(ENABLE_FLAG);
        process.setRemark(reqVO.getRemark());
        process.setCreatedBy(reqVO.getCreatedBy());
        process.setCreatedAt(LocalDateTime.now());
        finApproveProcessMapper.insert(process);
        return toProcessResp(process);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ApprovalProcessRespVO updateProcessDefinition(ApprovalProcessUpdateReqVO reqVO) {
        FinApproveProcessDO process = requireProcess(reqVO.getProcessId());
        process.setProcessName(reqVO.getProcessName().trim());
        process.setBizType(reqVO.getBizType().trim().toUpperCase(Locale.ROOT));
        process.setRemark(reqVO.getRemark());
        process.setUpdatedBy(reqVO.getUpdatedBy());
        process.setUpdatedAt(LocalDateTime.now());
        finApproveProcessMapper.updateById(process);
        return toProcessResp(process);
    }

    @Override
    public List<ApprovalProcessRespVO> getProcessDefinitionList(String bizType, Integer enableFlag) {
        LambdaQueryWrapper<FinApproveProcessDO> wrapper = new LambdaQueryWrapper<FinApproveProcessDO>()
                .orderByDesc(FinApproveProcessDO::getUpdatedAt)
                .orderByDesc(FinApproveProcessDO::getId);
        if (StringUtils.hasText(bizType)) {
            wrapper.eq(FinApproveProcessDO::getBizType, bizType.trim().toUpperCase(Locale.ROOT));
        }
        if (enableFlag != null) {
            wrapper.eq(FinApproveProcessDO::getEnableFlag, enableFlag);
        }
        return finApproveProcessMapper.selectList(wrapper).stream().map(this::toProcessResp).toList();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ApprovalProcessRespVO enableProcessDefinition(Long processId, Long operatorId) {
        return changeProcessEnableFlag(processId, ENABLE_FLAG, operatorId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ApprovalProcessRespVO disableProcessDefinition(Long processId, Long operatorId) {
        return changeProcessEnableFlag(processId, DISABLE_FLAG, operatorId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ApprovalInstanceRespVO startProcessInstance(ApprovalInstanceStartReqVO reqVO) {
        FinApproveProcessDO process = requireEnabledProcess(reqVO.getProcessId());
        String bizType = reqVO.getBizType().trim().toUpperCase(Locale.ROOT);
        if (!bizType.equals(process.getBizType())) {
            throw new IllegalArgumentException("实例业务类型与流程定义不一致");
        }
        rejectWhenBizHasRunningInstance(bizType, reqVO.getBizId());

        FinApproveInstanceDO instance = new FinApproveInstanceDO();
        instance.setProcessId(process.getId());
        instance.setBizType(bizType);
        instance.setBizId(reqVO.getBizId());
        instance.setInstanceNo(buildInstanceNo(process.getId()));
        instance.setApplicantId(reqVO.getApplicantId());
        instance.setCurrentNode(reqVO.getNodeName().trim());
        instance.setApproveStatus(INSTANCE_STATUS_DRAFT);
        instance.setStartTime(LocalDateTime.now());
        instance.setRemark(reqVO.getRemark());
        instance.setCreatedAt(LocalDateTime.now());
        instance.setUpdatedAt(LocalDateTime.now());
        finApproveInstanceMapper.insert(instance);

        FinApproveTaskDO task = new FinApproveTaskDO();
        task.setInstanceId(instance.getId());
        task.setTaskNo(buildTaskNo(instance.getId()));
        task.setNodeName(reqVO.getNodeName().trim());
        task.setApproverId(reqVO.getApproverId());
        task.setTaskStatus(TASK_STATUS_PENDING);
        task.setCreatedAt(LocalDateTime.now());
        task.setUpdatedAt(LocalDateTime.now());
        finApproveTaskMapper.insert(task);

        instance.setApproveStatus(INSTANCE_STATUS_PROCESSING);
        instance.setUpdatedAt(LocalDateTime.now());
        finApproveInstanceMapper.updateById(instance);

        insertHistory(instance.getId(), task.getNodeName(), reqVO.getApplicantId(),
                ACTION_SUBMIT, INSTANCE_STATUS_PROCESSING, "发起审批");
        return toInstanceResp(instance);
    }

    @Override
    public ApprovalInstanceRespVO getProcessInstance(Long instanceId) {
        return toInstanceResp(requireInstance(instanceId));
    }

    @Override
    public List<ApprovalInstanceRespVO> getProcessInstanceList(String bizType, Long bizId, String approveStatus) {
        LambdaQueryWrapper<FinApproveInstanceDO> wrapper = new LambdaQueryWrapper<FinApproveInstanceDO>()
                .orderByDesc(FinApproveInstanceDO::getCreatedAt)
                .orderByDesc(FinApproveInstanceDO::getId);
        if (StringUtils.hasText(bizType)) {
            wrapper.eq(FinApproveInstanceDO::getBizType, bizType.trim().toUpperCase(Locale.ROOT));
        }
        if (bizId != null) {
            wrapper.eq(FinApproveInstanceDO::getBizId, bizId);
        }
        if (StringUtils.hasText(approveStatus)) {
            wrapper.eq(FinApproveInstanceDO::getApproveStatus, approveStatus.trim().toUpperCase(Locale.ROOT));
        }
        return finApproveInstanceMapper.selectList(wrapper).stream().map(this::toInstanceResp).toList();
    }

    @Override
    public List<ApprovalTaskRespVO> getTodoTasks(Long approverId) {
        if (approverId == null) {
            throw new IllegalArgumentException("approverId不能为空");
        }
        return finApproveTaskMapper.selectList(new LambdaQueryWrapper<FinApproveTaskDO>()
                        .eq(FinApproveTaskDO::getApproverId, approverId)
                        .eq(FinApproveTaskDO::getTaskStatus, TASK_STATUS_PENDING)
                        .orderByDesc(FinApproveTaskDO::getCreatedAt)
                        .orderByDesc(FinApproveTaskDO::getId))
                .stream().map(this::toTaskResp).toList();
    }

    @Override
    public List<ApprovalTaskRespVO> getDoneTasks(Long approverId) {
        if (approverId == null) {
            throw new IllegalArgumentException("approverId不能为空");
        }
        return finApproveTaskMapper.selectList(new LambdaQueryWrapper<FinApproveTaskDO>()
                        .eq(FinApproveTaskDO::getApproverId, approverId)
                        .eq(FinApproveTaskDO::getTaskStatus, TASK_STATUS_DONE)
                        .orderByDesc(FinApproveTaskDO::getActionTime)
                        .orderByDesc(FinApproveTaskDO::getId))
                .stream().map(this::toTaskResp).toList();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ApprovalTaskRespVO handleTask(Long taskId, ApprovalTaskActionReqVO reqVO) {
        FinApproveTaskDO task = requireTask(taskId);
        if (!TASK_STATUS_PENDING.equals(task.getTaskStatus())) {
            throw new IllegalStateException("任务已处理");
        }
        if (!task.getApproverId().equals(reqVO.getApproverId())) {
            throw new IllegalStateException("当前审批人不匹配");
        }
        String action = reqVO.getActionType().trim().toUpperCase(Locale.ROOT);
        String nextStatus;
        if (ACTION_APPROVE.equals(action)) {
            nextStatus = INSTANCE_STATUS_APPROVED;
        } else if (ACTION_REJECT.equals(action)) {
            nextStatus = INSTANCE_STATUS_REJECTED;
        } else {
            throw new IllegalArgumentException("actionType仅支持APPROVE或REJECT");
        }

        task.setTaskStatus(TASK_STATUS_DONE);
        task.setActionType(action);
        task.setActionTime(LocalDateTime.now());
        task.setActionRemark(reqVO.getActionRemark());
        task.setUpdatedAt(LocalDateTime.now());
        finApproveTaskMapper.updateById(task);

        FinApproveInstanceDO instance = requireInstance(task.getInstanceId());
        instance.setApproveStatus(nextStatus);
        instance.setCurrentNode(null);
        instance.setEndTime(LocalDateTime.now());
        instance.setUpdatedAt(LocalDateTime.now());
        finApproveInstanceMapper.updateById(instance);

        insertHistory(instance.getId(), task.getNodeName(), reqVO.getApproverId(),
                action, nextStatus, reqVO.getActionRemark());
        return toTaskResp(task);
    }

    @Override
    public List<ApprovalHistoryRespVO> getProcessHistory(Long instanceId) {
        requireInstance(instanceId);
        return finApproveHistoryMapper.selectList(new LambdaQueryWrapper<FinApproveHistoryDO>()
                        .eq(FinApproveHistoryDO::getInstanceId, instanceId)
                        .orderByDesc(FinApproveHistoryDO::getActionTime)
                        .orderByDesc(FinApproveHistoryDO::getId))
                .stream().map(this::toHistoryResp).toList();
    }

    private ApprovalProcessRespVO changeProcessEnableFlag(Long processId, int enableFlag, Long operatorId) {
        FinApproveProcessDO process = requireProcess(processId);
        process.setEnableFlag(enableFlag);
        process.setUpdatedBy(defaultOperator(operatorId));
        process.setUpdatedAt(LocalDateTime.now());
        finApproveProcessMapper.updateById(process);
        return toProcessResp(process);
    }

    private void requireProcessCodeUnique(String processCode) {
        long count = finApproveProcessMapper.selectCount(new LambdaQueryWrapper<FinApproveProcessDO>()
                .eq(FinApproveProcessDO::getProcessCode, processCode));
        if (count > 0) {
            throw new IllegalArgumentException("processCode已存在");
        }
    }

    private void rejectWhenBizHasRunningInstance(String bizType, Long bizId) {
        long count = finApproveInstanceMapper.selectCount(new LambdaQueryWrapper<FinApproveInstanceDO>()
                .eq(FinApproveInstanceDO::getBizType, bizType)
                .eq(FinApproveInstanceDO::getBizId, bizId)
                .eq(FinApproveInstanceDO::getApproveStatus, INSTANCE_STATUS_PROCESSING));
        if (count > 0) {
            throw new IllegalStateException("该业务已有进行中的审批实例");
        }
    }

    private String buildInstanceNo(Long processId) {
        long count = finApproveInstanceMapper.selectCount(new LambdaQueryWrapper<FinApproveInstanceDO>()
                .eq(FinApproveInstanceDO::getProcessId, processId));
        return "APV-" + processId + "-" + String.format("%04d", count + 1);
    }

    private String buildTaskNo(Long instanceId) {
        long count = finApproveTaskMapper.selectCount(new LambdaQueryWrapper<FinApproveTaskDO>()
                .eq(FinApproveTaskDO::getInstanceId, instanceId));
        return "TASK-" + instanceId + "-" + String.format("%03d", count + 1);
    }

    private void insertHistory(Long instanceId, String nodeName, Long approverId,
                               String actionType, String actionResult, String actionRemark) {
        FinApproveHistoryDO history = new FinApproveHistoryDO();
        history.setInstanceId(instanceId);
        history.setNodeName(nodeName);
        history.setApproverId(approverId);
        history.setActionType(actionType);
        history.setActionResult(actionResult);
        history.setActionTime(LocalDateTime.now());
        history.setActionRemark(actionRemark);
        history.setCreatedAt(LocalDateTime.now());
        finApproveHistoryMapper.insert(history);
    }

    private FinApproveProcessDO requireProcess(Long processId) {
        FinApproveProcessDO process = finApproveProcessMapper.selectById(processId);
        if (process == null) {
            throw new IllegalArgumentException("审批流程不存在");
        }
        return process;
    }

    private FinApproveProcessDO requireEnabledProcess(Long processId) {
        FinApproveProcessDO process = requireProcess(processId);
        if (process.getEnableFlag() == null || process.getEnableFlag() != ENABLE_FLAG) {
            throw new IllegalStateException("审批流程未启用");
        }
        return process;
    }

    private FinApproveInstanceDO requireInstance(Long instanceId) {
        FinApproveInstanceDO instance = finApproveInstanceMapper.selectById(instanceId);
        if (instance == null) {
            throw new IllegalArgumentException("审批实例不存在");
        }
        return instance;
    }

    private FinApproveTaskDO requireTask(Long taskId) {
        FinApproveTaskDO task = finApproveTaskMapper.selectById(taskId);
        if (task == null) {
            throw new IllegalArgumentException("审批任务不存在");
        }
        return task;
    }

    private ApprovalProcessRespVO toProcessResp(FinApproveProcessDO process) {
        ApprovalProcessRespVO vo = new ApprovalProcessRespVO();
        vo.setProcessId(process.getId());
        vo.setProcessCode(process.getProcessCode());
        vo.setProcessName(process.getProcessName());
        vo.setBizType(process.getBizType());
        vo.setVersionNo(process.getVersionNo());
        vo.setEnableFlag(process.getEnableFlag());
        vo.setRemark(process.getRemark());
        return vo;
    }

    private ApprovalInstanceRespVO toInstanceResp(FinApproveInstanceDO instance) {
        ApprovalInstanceRespVO vo = new ApprovalInstanceRespVO();
        vo.setInstanceId(instance.getId());
        vo.setProcessId(instance.getProcessId());
        vo.setBizType(instance.getBizType());
        vo.setBizId(instance.getBizId());
        vo.setInstanceNo(instance.getInstanceNo());
        vo.setApplicantId(instance.getApplicantId());
        vo.setCurrentNode(instance.getCurrentNode());
        vo.setApproveStatus(instance.getApproveStatus());
        vo.setStartTime(instance.getStartTime());
        vo.setEndTime(instance.getEndTime());
        vo.setRemark(instance.getRemark());
        return vo;
    }

    private ApprovalTaskRespVO toTaskResp(FinApproveTaskDO task) {
        ApprovalTaskRespVO vo = new ApprovalTaskRespVO();
        vo.setTaskId(task.getId());
        vo.setInstanceId(task.getInstanceId());
        vo.setTaskNo(task.getTaskNo());
        vo.setNodeName(task.getNodeName());
        vo.setApproverId(task.getApproverId());
        vo.setTaskStatus(task.getTaskStatus());
        vo.setActionType(task.getActionType());
        vo.setActionTime(task.getActionTime());
        vo.setActionRemark(task.getActionRemark());
        return vo;
    }

    private ApprovalHistoryRespVO toHistoryResp(FinApproveHistoryDO history) {
        ApprovalHistoryRespVO vo = new ApprovalHistoryRespVO();
        vo.setHistoryId(history.getId());
        vo.setInstanceId(history.getInstanceId());
        vo.setNodeName(history.getNodeName());
        vo.setApproverId(history.getApproverId());
        vo.setActionType(history.getActionType());
        vo.setActionResult(history.getActionResult());
        vo.setActionTime(history.getActionTime());
        vo.setActionRemark(history.getActionRemark());
        return vo;
    }

    private Long defaultOperator(Long operatorId) {
        return operatorId == null ? 0L : operatorId;
    }
}
