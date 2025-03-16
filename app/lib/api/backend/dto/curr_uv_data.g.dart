// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curr_uv_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrUvData _$CurrUvDataFromJson(Map<String, dynamic> json) => CurrUvData(
      (json['uvIndex'] as num).toInt(),
      (json['temperatureC'] as num).toDouble(),
      DateTime.parse(json['sunrise'] as String),
      DateTime.parse(json['sunset'] as String),
    );

Map<String, dynamic> _$CurrUvDataToJson(CurrUvData instance) =>
    <String, dynamic>{
      'uvIndex': instance.uvIndex,
      'temperatureC': instance.temperatureC,
      'sunrise': instance.sunrise.toIso8601String(),
      'sunset': instance.sunset.toIso8601String(),
    };
