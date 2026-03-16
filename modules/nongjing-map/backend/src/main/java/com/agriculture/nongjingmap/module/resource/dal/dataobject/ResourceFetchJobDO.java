package com.agriculture.nongjingmap.module.resource.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.time.LocalDateTime;
import lombok.Data;

@TableName("resource_fetch_job")
@Data
public class ResourceFetchJobDO {

    @TableId(type = IdType.AUTO)
    private Long jobId;
    private String taskName;
    private String sourceSystem;
    private String scopeRegionCode;
    private String scopeDesc;
    private String status;
    private LocalDateTime lastRunTime;
    private String periodMonth;
}