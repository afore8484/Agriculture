package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class SubjectTreeRespVO {

    private String subjectCode;
    private String subjectName;
    private String parentCode;
    private Boolean assistFlag;
    private List<SubjectTreeRespVO> children = new ArrayList<>();
}
