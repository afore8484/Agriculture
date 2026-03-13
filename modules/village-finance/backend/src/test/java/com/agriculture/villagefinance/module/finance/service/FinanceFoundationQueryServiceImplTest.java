package com.agriculture.villagefinance.module.finance.service;

import com.agriculture.villagefinance.module.finance.controller.vo.SubjectTreeRespVO;
import com.agriculture.villagefinance.module.finance.dal.dataobject.FinSubjectDO;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinBookMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinPeriodMapper;
import com.agriculture.villagefinance.module.finance.dal.mysql.FinSubjectMapper;
import com.agriculture.villagefinance.module.finance.service.impl.FinanceFoundationQueryServiceImpl;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class FinanceFoundationQueryServiceImplTest {

    @Test
    void shouldBuildSubjectTree() {
        FinSubjectMapper subjectMapper = mock(FinSubjectMapper.class);
        when(subjectMapper.selectList(org.mockito.ArgumentMatchers.any())).thenReturn(List.of(
                subject(1L, "1001", null, "资产", 0),
                subject(1L, "100101", "1001", "库存现金", 1)
        ));
        FinanceFoundationQueryServiceImpl service = new FinanceFoundationQueryServiceImpl(
                mock(FinBookMapper.class), mock(FinPeriodMapper.class), subjectMapper
        );

        List<SubjectTreeRespVO> tree = service.getSubjectTree(1L);

        assertEquals(1, tree.size());
        assertEquals("1001", tree.get(0).getSubjectCode());
        assertEquals(1, tree.get(0).getChildren().size());
        assertEquals("100101", tree.get(0).getChildren().get(0).getSubjectCode());
    }

    private static FinSubjectDO subject(Long bookId, String code, String parentCode, String name, Integer assistFlag) {
        FinSubjectDO subject = new FinSubjectDO();
        subject.setBookId(bookId);
        subject.setSubjectCode(code);
        subject.setParentCode(parentCode);
        subject.setSubjectName(name);
        subject.setEnableFlag(1);
        subject.setAssistFlag(assistFlag);
        return subject;
    }
}
