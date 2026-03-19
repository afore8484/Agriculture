package com.agriculture.villagefinance.module.finance.service;

import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalInstanceStartReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalProcessCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ApprovalTaskActionReqVO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinApproveHistoryDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinApproveInstanceDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinApproveProcessDO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinApproveTaskDO;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinApproveHistoryMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinApproveInstanceMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinApproveProcessMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinApproveTaskMapper;
import com.agriculture.villagefinance.module.finance.service.impl.FinanceApprovalServiceImpl;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class FinanceApprovalServiceImplTest {

    @Test
    void shouldCreateProcessDefinition() {
        TestContext c = newContext();
        when(c.processMapper.selectCount(any())).thenReturn(0L);
        doAnswer(invocation -> {
            FinApproveProcessDO process = invocation.getArgument(0);
            process.setId(101L);
            return 1;
        }).when(c.processMapper).insert(any(FinApproveProcessDO.class));

        ApprovalProcessCreateReqVO reqVO = new ApprovalProcessCreateReqVO();
        reqVO.setProcessCode("PAY_APV");
        reqVO.setProcessName("支付审批");
        reqVO.setBizType("PAYMENT");
        reqVO.setCreatedBy(9L);

        assertEquals(101L, c.service.createProcessDefinition(reqVO).getProcessId());
    }

    @Test
    void shouldStartProcessInstance() {
        TestContext c = newContext();
        mockEnabledProcess(c);
        when(c.instanceMapper.selectCount(any())).thenReturn(0L);
        when(c.taskMapper.selectCount(any())).thenReturn(0L);
        doAnswer(invocation -> {
            FinApproveInstanceDO row = invocation.getArgument(0);
            row.setId(201L);
            return 1;
        }).when(c.instanceMapper).insert(any(FinApproveInstanceDO.class));
        doAnswer(invocation -> {
            FinApproveTaskDO row = invocation.getArgument(0);
            row.setId(301L);
            return 1;
        }).when(c.taskMapper).insert(any(FinApproveTaskDO.class));

        ApprovalInstanceStartReqVO reqVO = new ApprovalInstanceStartReqVO();
        reqVO.setProcessId(11L);
        reqVO.setBizType("PAYMENT");
        reqVO.setBizId(1001L);
        reqVO.setApplicantId(7L);
        reqVO.setApproverId(8L);
        reqVO.setNodeName("财务审批");

        assertEquals("PROCESSING", c.service.startProcessInstance(reqVO).getApproveStatus());
    }

    @Test
    void shouldQueryTodoTasks() {
        TestContext c = newContext();
        FinApproveTaskDO task = new FinApproveTaskDO();
        task.setId(301L);
        task.setInstanceId(201L);
        task.setTaskNo("TASK-201-001");
        task.setNodeName("财务审批");
        task.setApproverId(8L);
        task.setTaskStatus("PENDING");
        when(c.taskMapper.selectList(any())).thenReturn(java.util.List.of(task));

        assertEquals(1, c.service.getTodoTasks(8L).size());
    }

    @Test
    void shouldApproveTask() {
        TestContext c = newContext();
        mockPendingTask(c, 8L);
        mockInstance(c);

        ApprovalTaskActionReqVO reqVO = new ApprovalTaskActionReqVO();
        reqVO.setApproverId(8L);
        reqVO.setActionType("APPROVE");
        reqVO.setActionRemark("同意");

        c.service.handleTask(301L, reqVO);
        ArgumentCaptor<FinApproveTaskDO> taskCaptor = ArgumentCaptor.forClass(FinApproveTaskDO.class);
        verify(c.taskMapper).updateById(taskCaptor.capture());
        assertEquals("DONE", taskCaptor.getValue().getTaskStatus());
        assertEquals("APPROVE", taskCaptor.getValue().getActionType());
    }

    @Test
    void shouldRejectTask() {
        TestContext c = newContext();
        mockPendingTask(c, 8L);
        mockInstance(c);

        ApprovalTaskActionReqVO reqVO = new ApprovalTaskActionReqVO();
        reqVO.setApproverId(8L);
        reqVO.setActionType("REJECT");
        reqVO.setActionRemark("驳回");

        c.service.handleTask(301L, reqVO);
        ArgumentCaptor<FinApproveInstanceDO> instanceCaptor = ArgumentCaptor.forClass(FinApproveInstanceDO.class);
        verify(c.instanceMapper).updateById(instanceCaptor.capture());
        assertEquals("REJECTED", instanceCaptor.getValue().getApproveStatus());
    }

    @Test
    void shouldQueryProcessHistory() {
        TestContext c = newContext();
        mockInstance(c);
        FinApproveHistoryDO history = new FinApproveHistoryDO();
        history.setId(401L);
        history.setInstanceId(201L);
        history.setNodeName("财务审批");
        history.setApproverId(8L);
        history.setActionType("APPROVE");
        history.setActionResult("APPROVED");
        when(c.historyMapper.selectList(any())).thenReturn(java.util.List.of(history));

        assertEquals(1, c.service.getProcessHistory(201L).size());
    }

    private static void mockEnabledProcess(TestContext c) {
        FinApproveProcessDO process = new FinApproveProcessDO();
        process.setId(11L);
        process.setProcessCode("PAY_APV");
        process.setProcessName("支付审批");
        process.setBizType("PAYMENT");
        process.setEnableFlag(1);
        process.setVersionNo(1);
        when(c.processMapper.selectById(11L)).thenReturn(process);
    }

    private static void mockPendingTask(TestContext c, Long approverId) {
        FinApproveTaskDO task = new FinApproveTaskDO();
        task.setId(301L);
        task.setInstanceId(201L);
        task.setTaskNo("TASK-201-001");
        task.setNodeName("财务审批");
        task.setApproverId(approverId);
        task.setTaskStatus("PENDING");
        when(c.taskMapper.selectById(301L)).thenReturn(task);
    }

    private static void mockInstance(TestContext c) {
        FinApproveInstanceDO instance = new FinApproveInstanceDO();
        instance.setId(201L);
        instance.setProcessId(11L);
        instance.setBizType("PAYMENT");
        instance.setBizId(1001L);
        instance.setApproveStatus("PROCESSING");
        when(c.instanceMapper.selectById(201L)).thenReturn(instance);
    }

    private static TestContext newContext() {
        TestContext c = new TestContext();
        c.processMapper = mock(FinApproveProcessMapper.class);
        c.instanceMapper = mock(FinApproveInstanceMapper.class);
        c.taskMapper = mock(FinApproveTaskMapper.class);
        c.historyMapper = mock(FinApproveHistoryMapper.class);
        c.service = new FinanceApprovalServiceImpl(
                c.processMapper,
                c.instanceMapper,
                c.taskMapper,
                c.historyMapper
        );
        return c;
    }

    private static class TestContext {
        private FinanceApprovalService service;
        private FinApproveProcessMapper processMapper;
        private FinApproveInstanceMapper instanceMapper;
        private FinApproveTaskMapper taskMapper;
        private FinApproveHistoryMapper historyMapper;
    }
}
