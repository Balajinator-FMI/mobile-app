import 'package:json_annotation/json_annotation.dart';

part 'curr_uv_data.g.dart';

@JsonSerializable()
class CurrUvData {
  @JsonKey(name: 'uv_index')
  final int UVIndex;
  final double temp;
  final DateTime sunrise;
  final DateTime sunset;

  CurrUvData(
    this.UVIndex,
    this.temp,
    this.sunrise,
    this.sunset,
  );

  factory CurrUvData.fromJson(Map<String, dynamic> json) => _$CurrUvDataFromJson(json);

  Map<String, dynamic> toJson() => _$CurrUvDataToJson(this);
}
