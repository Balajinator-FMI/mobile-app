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
      (json['pastWeek'] as List<dynamic>)
          .map((e) => ForecastItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      CurrUvData.fromJson(json['currentUvData'] as Map<String, dynamic>),
      (json['recOutdoor'] as num).toInt(),
      json['advice'] as String,
      (json['factor'] as num).toInt(),
    );

Map<String, dynamic> _$FetchLocationDataResToJson(
        FetchLocationDataRes instance) =>
    <String, dynamic>{
      'forecast': instance.forecast,
      'pastWeek': instance.pastWeek,
      'currentUvData': instance.currentUvData,
      'recOutdoor': instance.recOutdoor,
      'advice': instance.advice,
      'factor': instance.factor,
    };
