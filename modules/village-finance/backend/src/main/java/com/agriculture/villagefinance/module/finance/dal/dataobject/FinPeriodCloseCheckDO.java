package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("fin_period_close_check")
public class FinPeriodCloseCheckDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long closeId;
    private Long bookId;
    private Long periodId;
    private String checkCode;
    private String checkName;
    private String checkResult;
    private Integer errorCount;
    private String detailJson;
    private LocalDateTime createdAt;
}
