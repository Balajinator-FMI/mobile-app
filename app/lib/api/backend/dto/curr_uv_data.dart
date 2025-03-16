import 'package:json_annotation/json_annotation.dart';

part 'curr_uv_data.g.dart';

@JsonSerializable()
class CurrUvData {
  final int uvIndex;
  final double temperatureC;
  final DateTime sunrise;
  final DateTime sunset;

  CurrUvData(
    this.uvIndex,
    this.temperatureC,
    this.sunrise,
    this.sunset,
  );

  factory CurrUvData.fromJson(Map<String, dynamic> json) => _$CurrUvDataFromJson(json);

  Map<String, dynamic> toJson() => _$CurrUvDataToJson(this);
}
