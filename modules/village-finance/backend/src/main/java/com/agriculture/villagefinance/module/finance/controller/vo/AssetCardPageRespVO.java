package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
public class AssetCardPageRespVO {

    private Long total;
    private List<Record> records;

    @Data
    public static class Record {
        private Long assetId;
        private String assetCode;
        private String assetName;
        private String categoryName;
        private BigDecimal originalValue;
        private BigDecimal netValue;
        private String useStatus;
    }
}
