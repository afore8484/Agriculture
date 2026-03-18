package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ContractAttachmentRespVO {

    private Long attachmentId;
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
