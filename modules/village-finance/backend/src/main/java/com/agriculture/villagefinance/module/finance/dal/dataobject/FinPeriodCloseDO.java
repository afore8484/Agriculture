package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("fin_period_close")
public class FinPeriodCloseDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long bookId;
    private Long periodId;
    private String closeNo;
    private String closeType;
    private String closeStatus;
    private LocalDateTime closeTime;
    private Integer pendingVoucherCount;
    private Long operatorId;
    private String remark;
}
