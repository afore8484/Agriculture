package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("fin_subject")
public class FinSubjectDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long bookId;
    private String subjectCode;
    private String subjectName;
    private Long parentId;
    private String parentCode;
    private Long categoryId;
    private String balanceDirection;
    private Integer level;
    private Integer isLeaf;
    private Integer enableFlag;
    private Integer assistFlag;
    private String remark;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
