import 'package:app/api/backend/dto/curr_uv_data.dart';
import 'package:app/api/backend/dto/forecast_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fetch_location_data_res.g.dart';

@JsonSerializable()
class FetchLocationDataRes {
  final List<ForecastItem> forecast;
  final List<ForecastItem> pastWeek;
  final CurrUvData currentUvData;
  final int recOutdoor;
  final String advice;
  final int factor;

  FetchLocationDataRes(
    this.forecast,
    this.pastWeek,
    this.currentUvData,
    this.recOutdoor,
    this.advice,
    this.factor,
  );

  factory FetchLocationDataRes.fromJson(Map<String, dynamic> json) => _$FetchLocationDataResFromJson(json);

  Map<String, dynamic> toJson() => _$FetchLocationDataResToJson(this);
}
