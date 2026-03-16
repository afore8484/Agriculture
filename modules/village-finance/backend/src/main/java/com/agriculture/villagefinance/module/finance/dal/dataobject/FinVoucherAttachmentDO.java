package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("fin_voucher_attachment")
public class FinVoucherAttachmentDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long voucherId;
    private String fileName;
    private String fileUrl;
    private Long fileSize;
    private Long uploadedBy;
    private LocalDateTime uploadedAt;
}
