package com.agriculture.nongjingmap.module.overview.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.time.LocalDate;
import lombok.Data;

@TableName("fact_weather_daily")
@Data
public class FactWeatherDailyDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String regionCode;
    private LocalDate weatherDate;
    private String weatherType;
    private String temperatureText;
    private String windText;
    private String humidityText;
}