import 'package:json_annotation/json_annotation.dart';

part 'forecast_item.g.dart';

@JsonSerializable()
class ForecastItem {
  @JsonKey(name: 'uv_index')
  final int UVIndex;
  final String date;

  ForecastItem(
    this.UVIndex,
    this.date,
  );

  ForecastItem.empty() : UVIndex = 0, date = '';

  factory ForecastItem.fromJson(Map<String, dynamic> json) => _$ForecastItemFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastItemToJson(this);
}