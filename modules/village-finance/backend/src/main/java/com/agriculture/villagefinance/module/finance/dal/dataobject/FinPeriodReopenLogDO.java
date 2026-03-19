package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("fin_period_reopen_log")
public class FinPeriodReopenLogDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long bookId;
    private Long periodId;
    private String reopenNo;
    private String reason;
    private Long operatorId;
    private LocalDateTime operateTime;
    private String periodStatus;
}
