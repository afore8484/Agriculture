package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("fin_contract_attachment")
public class FinContractAttachmentDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long contractId;
    private String bizType;
    private String fileName;
    private String fileUrl;
    private String fileType;
    private Long fileSize;
    private Long uploadedBy;
    private LocalDateTime uploadedAt;
    private String remark;
}
