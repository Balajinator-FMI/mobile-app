// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastItem _$ForecastItemFromJson(Map<String, dynamic> json) => ForecastItem(
      (json['uv_index'] as num).toInt(),
      json['date'] as String,
    );

Map<String, dynamic> _$ForecastItemToJson(ForecastItem instance) =>
    <String, dynamic>{
      'uv_index': instance.UVIndex,
      'date': instance.date,
    };
