import 'package:flutter/material.dart';
import 'package:dailyquest_fixed/utils/notification_helper.dart';

Future<void> pickTimeAndScheduleNotification(BuildContext context) async {
  final picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (picked != null) {
    await NotificationHelper.scheduleDailyNotification(
      id: 1,
      title: 'Pengingat!',
      body: 'Saatnya menyelesaikan tugasmu.',
      time: picked, // Langsung pakai TimeOfDay
    );

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // ignore: use_build_context_synchronously
        content: Text('Notifikasi dijadwalkan pada ${picked.format(context)}'),
      ),
    );
  }
}
