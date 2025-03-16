// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_geomagnetic_storm_dst.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGeomagneticStormDst _$GetGeomagneticStormDstFromJson(
        Map<String, dynamic> json) =>
    GetGeomagneticStormDst(
      json['time_tag'] as String,
      json['predicted_dst'] as double,
    );

Map<String, dynamic> _$GetGeomagneticStormDstToJson(
        GetGeomagneticStormDst instance) =>
    <String, dynamic>{
      'time_tag': instance.date,
      'predicted_dst': instance.dst,
    };
