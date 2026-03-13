package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("fin_book")
public class FinBookDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String bookCode;
    private String bookName;
    private Long orgId;
    private String orgCode;
    private Integer fiscalYear;
    private String currency;
    private LocalDate startDate;
    private LocalDate endDate;
    private String status;
    private String remark;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
