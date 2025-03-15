// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_location_data_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchLocationDataRes _$FetchLocationDataResFromJson(
        Map<String, dynamic> json) =>
    FetchLocationDataRes(
      (json['forecast'] as List<dynamic>)
          .map((e) => ForecastItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['forecastHistory'] as List<dynamic>?)
          ?.map((e) => ForecastItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      CurrUvData.fromJson(json['current'] as Map<String, dynamic>),
      (json['reccOutdoorTime'] as num).toInt(),
      json['advice'] as String,
      (json['factor'] as num).toInt(),
    );

Map<String, dynamic> _$FetchLocationDataResToJson(
        FetchLocationDataRes instance) =>
    <String, dynamic>{
      'forecast': instance.forecast,
      'forecastHistory': instance.forecastHistory,
      'current': instance.current,
      'reccOutdoorTime': instance.reccOutdoorTime,
      'advice': instance.advice,
      'factor': instance.factor,
    };
