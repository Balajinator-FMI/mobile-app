import 'package:app/api/backend/dto/curr_uv_data.dart';
import 'package:app/static/app_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UvCardView extends StatelessWidget {
  final CurrUvData uvData;
  final int reccOutdoorTime;
  final int factor;

  const UvCardView({
    super.key,
    required this.uvData,
    required this.reccOutdoorTime,
    required this.factor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppStyle.secondaryColor1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "${uvData.UVIndex} UV",
                style: const TextStyle(
                  color: AppStyle.textColor,
                  fontSize: 42,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getUVIndexLabel(uvData.UVIndex),
                    style: const TextStyle(
                      color: AppStyle.textColor,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      'Reccomended outdoor time: $reccOutdoorTime hours',
                      style: TextStyle(
                        color: AppStyle.textColorWith07Opacity,
                        fontSize: 16,
                      ),
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          AQISpectrumChart(aqiValue: uvData.UVIndex),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildWeatherInfo('Sunrise', _formatTime(uvData.sunrise)),
              _buildWeatherInfo('Sunset', _formatTime(uvData.sunset)),
              _buildWeatherInfo('Protection', '$factor+ SPF'),
            ],
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

  Widget _buildWeatherInfo(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: AppStyle.textColorWith05Opacity,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: AppStyle.textColor,
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat("HH:mm").format(dateTime.toLocal());
  }
}

class AQISpectrumChart extends StatelessWidget {
  final int aqiValue;

  const AQISpectrumChart({required this.aqiValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Colors.green,
                    Colors.yellow,
                    Colors.orange,
                    Colors.red,
                    Colors.purple,
                  ],
                  stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                ),
              ),
            ),
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildUVLabel("0 - 2"),
                  _buildUVLabel("3 - 5"),
                  _buildUVLabel("6 - 7"),
                  _buildUVLabel("8 - 10"),
                  _buildUVLabel("11+"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUVLabel(String text) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            color: AppStyle.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
