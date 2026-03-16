package com.agriculture.nongjingmap.module.common.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.time.LocalDate;
import lombok.Data;

@TableName("dim_time")
@Data
public class DimTimeDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String timeCode;
    private LocalDate dateValue;
    private Integer yearNo;
    private Integer quarterNo;
    private Integer monthNo;
    private String monthLabel;
}