import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../models/activity_model.dart';

class WeeklyBarChart extends StatelessWidget {
  final List<ActivityModel> activities;

  const WeeklyBarChart({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final data = {for (var i in List.generate(7, (i) => i)) i: 0};

    for (var a in activities) {
      final diff = now.difference(a.activityDate).inDays;
      if (diff >= 0 && diff < 7) {
        final weekday = a.activityDate.weekday % 7; // 0=Sunday
        data[weekday] = (data[weekday] ?? 0) + 1;
      }
    }

    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (val, _) {
                      final weekdays = [
                        'Min',
                        'Sen',
                        'Sel',
                        'Rab',
                        'Kam',
                        'Jum',
                        'Sab',
                      ];
                      return Text(weekdays[val.toInt() % 7]);
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              barGroups:
                  data.entries
                      .map(
                        (e) => BarChartGroupData(
                          x: e.key,
                          barRods: [
                            BarChartRodData(
                              toY: e.value.toDouble(),
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
// ini weakly bar chart