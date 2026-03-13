package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("fin_period")
public class FinPeriodDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long bookId;
    private Integer periodYear;
    private Integer periodNo;
    private LocalDate startDate;
    private LocalDate endDate;
    private String closeStatus;
    private LocalDateTime closeTime;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
