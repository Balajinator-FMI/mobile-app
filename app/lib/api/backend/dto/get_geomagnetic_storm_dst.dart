import 'package:json_annotation/json_annotation.dart';

part 'get_geomagnetic_storm_dst.g.dart';

@JsonSerializable()
class GetGeomagneticStormDst {
  @JsonKey(name: 'time_tag')
  final String date;

  @JsonKey(name: 'predicted_dst')
  final double dst;

  GetGeomagneticStormDst(this.date, this.dst);

  factory GetGeomagneticStormDst.fromJson(Map<String, dynamic> json) => _$GetGeomagneticStormDstFromJson(json);

  Map<String, dynamic> toJson() => _$GetGeomagneticStormDstToJson(this);
}