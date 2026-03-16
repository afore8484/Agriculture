package com.agriculture.nongjingmap.module.resource.controller.vo;

import java.time.LocalDateTime;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class ResourceFetchJobRespVO {
    String taskName;
    String source;
    String scope;
    String status;
    LocalDateTime lastRunTime;
}