package com.agriculture.nongjingmap.module.common.controller.vo;

import java.time.LocalDate;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class TimeDimensionRespVO {
    String timeCode;
    LocalDate dateValue;
    Integer yearNo;
    Integer quarterNo;
    Integer monthNo;
    String monthLabel;
}