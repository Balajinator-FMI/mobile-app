// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastItem _$ForecastItemFromJson(Map<String, dynamic> json) => ForecastItem(
      (json['uvIndex'] as num).toInt(),
      json['date'] as String,
    );

Map<String, dynamic> _$ForecastItemToJson(ForecastItem instance) =>
    <String, dynamic>{
      'uvIndex': instance.uvIndex,
      'date': instance.date,
    };
