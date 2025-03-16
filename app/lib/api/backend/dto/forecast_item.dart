import 'package:json_annotation/json_annotation.dart';

part 'forecast_item.g.dart';

@JsonSerializable()
class ForecastItem {
  final int uvIndex;
  final String date;

  ForecastItem(
    this.uvIndex,
    this.date,
  );

  ForecastItem.empty()
      : uvIndex = 0,
        date = '';

  factory ForecastItem.fromJson(Map<String, dynamic> json) => _$ForecastItemFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastItemToJson(this);
}
