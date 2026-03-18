package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class ContractAttachmentCreateReqVO {

    @NotNull(message = "contractId is required")
    private Long contractId;

    private String bizType;

    @NotBlank(message = "fileName is required")
    private String fileName;

    @NotBlank(message = "fileUrl is required")
    private String fileUrl;

    private String fileType;
    private Long fileSize;
    private Long operatorId;
    private String remark;
}
