package com.agriculture.nongjingmap.module.overview.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import lombok.Data;

@TableName("mv_region_topic_rank_monthly")
@Data
public class MvRegionTopicRankMonthlyDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String metricCode;
    private String topicCode;
    private String regionCode;
    private String regionName;
    private String statMonth;
    private Integer rankNo;
    private BigDecimal metricValue;
}