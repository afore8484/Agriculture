package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.util.List;

@Data
public class ContractPageRespVO {

    private Long total;
    private List<ContractRespVO> records;
}
