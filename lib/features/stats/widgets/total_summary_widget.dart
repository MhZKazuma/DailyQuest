import 'package:flutter/material.dart';
import '../../../models/activity_model.dart';

class TotalSummaryWidget extends StatelessWidget {
  final List<ActivityModel> activities;

  const TotalSummaryWidget({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    final total = activities.length;
    final done = activities.where((a) => a.status == 'done').length;
    final pending = total - done;

    return Card(
      child: ListTile(
        title: Text('Total Kegiatan: $total'),
        subtitle: Text('Selesai: $done | Belum: $pending'),
      ),
    );
  }
}
// ini total summary widget