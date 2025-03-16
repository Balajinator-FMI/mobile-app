import 'package:app/static/app_style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UVTimeBarChartView extends StatelessWidget {
  final List<Map<String, dynamic>> outdoorTimes;

  const UVTimeBarChartView({super.key, required this.outdoorTimes});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppStyle.secondaryColor1,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: BarChart(
              BarChartData(
                backgroundColor: Colors.transparent,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(color: AppStyle.textColorWith07Opacity),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index >= 0 && index < outdoorTimes.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              DateFormat('E').format(outdoorTimes[index]['date']),
                              style: TextStyle(color: AppStyle.textColorWith07Opacity),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                barGroups: _buildBarGroups(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(outdoorTimes.length, (index) {
      final data = outdoorTimes[index];
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data['uvIndex'].toDouble(),
            width: 10,
            color: Colors.pinkAccent,
            borderRadius: BorderRadius.circular(6),
          ),
          BarChartRodData(
            toY: data['totalHours'].toDouble(),
            width: 10,
            color: Colors.cyanAccent,
            borderRadius: BorderRadius.circular(6),
          ),
        ],
        barsSpace: 5,
      );
    });
  }
}