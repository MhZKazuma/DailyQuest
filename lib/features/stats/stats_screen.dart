import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/activity_controller.dart';
import 'widgets/weekly_bar_chart.dart';
import 'widgets/pie_status_chart.dart';
import 'widgets/total_summary_widget.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activityController = Get.find<ActivityController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Statistik')),
      body: Obx(() {
        final activities = activityController.activities;

        if (activities.isEmpty) {
          return const Center(child: Text('Belum ada data aktivitas.'));
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TotalSummaryWidget(activities: activities),
            const SizedBox(height: 20),
            WeeklyBarChart(activities: activities),
            const SizedBox(height: 20),
            PieStatusChart(activities: activities),
          ],
        );
      }),
    );
  }
}
