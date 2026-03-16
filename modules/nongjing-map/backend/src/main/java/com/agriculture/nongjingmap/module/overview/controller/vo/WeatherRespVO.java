package com.agriculture.nongjingmap.module.overview.controller.vo;

import java.time.LocalDate;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class WeatherRespVO {
    String regionCode;
    LocalDate weatherDate;
    String weatherType;
    String temperatureText;
    String windText;
    String humidityText;
}