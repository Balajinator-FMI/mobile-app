import 'package:app/api/backend/dto/forecast_item.dart';
import 'package:app/static/app_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ForecastView extends StatelessWidget {
  final List<ForecastItem> forecast;

  const ForecastView({
    super.key,
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          final day = forecast[index];
          return _buildUVCard(
            day.date,
            day.UVIndex,
          );
        },
      ),
    );
  }

  Widget _buildUVCard(String day, int uvIndex) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppStyle.secondaryColor1,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat("E").format(DateTime.parse(day)),
            style: TextStyle(
              fontSize: 16,
              color: AppStyle.textColorWith05Opacity,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "$uvIndex UV",
            style: const TextStyle(
              fontSize: 16,
              color: AppStyle.textColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            _getUVIndexLabel(uvIndex),
            style: TextStyle(
              fontSize: 14,
              color: AppStyle.textColorWith07Opacity,
            ),
          ),
        ],
      ),
    );
  }

  String _getUVIndexLabel(int uvIndex) {
    if (uvIndex >= 0 && uvIndex <= 2) {
      return "Low";
    } else if (uvIndex >= 3 && uvIndex <= 5) {
      return "Moderate";
    } else if (uvIndex >= 6 && uvIndex <= 7) {
      return "High";
    } else if (uvIndex >= 8 && uvIndex <= 10) {
      return "Very High";
    } else {
      return "Extreme";
    }
  }
}
