import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/activity_controller.dart';
import '../../../models/activity_model.dart';

class ActivityCard extends StatelessWidget {
  final ActivityModel activity;

  const ActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    final activityController = Get.find<ActivityController>();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Icon(
          activity.status == 'done'
              ? Icons.check_circle
              : Icons.radio_button_unchecked,
        ),
        title: Text(activity.title),
        subtitle: Text(
          '${activity.activityDate.toLocal().toIso8601String().split('T')[0]} • ${activity.activityTime}',
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'hapus') {
              activityController.delete(activity.id);
            } else if (value == 'selesai') {
              activityController.updateActivity(activity.id, {
                'status': 'done',
              });
            }
          },
          itemBuilder:
              (_) => [
                const PopupMenuItem(
                  value: 'selesai',
                  child: Text('Tandai Selesai'),
                ),
                const PopupMenuItem(value: 'hapus', child: Text('Hapus')),
              ],
        ),
      ),
    );
  }
}
// anu iki activity card yo rek perek//