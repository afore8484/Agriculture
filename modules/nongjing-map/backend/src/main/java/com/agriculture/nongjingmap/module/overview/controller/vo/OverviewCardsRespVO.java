package com.agriculture.nongjingmap.module.overview.controller.vo;

import java.math.BigDecimal;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class OverviewCardsRespVO {
    String regionCode;
    String statMonth;
    Integer orgCount;
    Integer townshipCount;
    Integer villageCount;
    Integer unsettledCount;
    Integer noBookCount;
    Integer warningCount;
    BigDecimal incomeTotal;
}