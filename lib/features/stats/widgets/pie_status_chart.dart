import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../models/activity_model.dart';

class PieStatusChart extends StatelessWidget {
  final List<ActivityModel> activities;

  const PieStatusChart({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    final done = activities.where((a) => a.status == 'done').length;
    final pending = activities.length - done;

    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: Colors.green,
                  value: done.toDouble(),
                  title: 'Selesai\n$done',
                  titleStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.orange,
                  value: pending.toDouble(),
                  title: 'Pending\n$pending',
                  titleStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
