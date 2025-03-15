// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curr_uv_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrUvData _$CurrUvDataFromJson(Map<String, dynamic> json) => CurrUvData(
      (json['uv_index'] as num).toInt(),
      (json['temp'] as num).toDouble(),
      DateTime.parse(json['sunrise'] as String),
      DateTime.parse(json['sunset'] as String),
    );

Map<String, dynamic> _$CurrUvDataToJson(CurrUvData instance) =>
    <String, dynamic>{
      'uv_index': instance.UVIndex,
      'temp': instance.temp,
      'sunrise': instance.sunrise.toIso8601String(),
      'sunset': instance.sunset.toIso8601String(),
    };
