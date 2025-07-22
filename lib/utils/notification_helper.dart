import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    show
        AndroidInitializationSettings,
        AndroidNotificationDetails,
        AndroidScheduleMode,
        DateTimeComponents,
        FlutterLocalNotificationsPlugin,
        Importance,
        InitializationSettings,
        NotificationDetails,
        Priority,
        UILocalNotificationDateInterpretation;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // ✅ Inisialisasi
  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _plugin.initialize(initializationSettings);
  }

  static Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
  }) async {
    if (kDebugMode) {
      print("⏰ Scheduling notification at ${time.hour}:${time.minute}");
    }

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(time),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'dailyquest_channel',
          'DailyQuest Reminders',
          channelDescription: 'Channel untuk pengingat DailyQuest',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  static Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }

  // ✅ Fungsi untuk tes notifikasi 5 detik setelah dijalankan
  static Future<void> scheduleTestNotification() async {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = now.add(const Duration(seconds: 5));

    await _plugin.zonedSchedule(
      999,
      'Test Notifikasi',
      'Ini hanya tes notifikasi 5 detik ke depan',
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'dailyquest_channel',
          'DailyQuest Reminders',
          channelDescription: 'Channel untuk pengingat DailyQuest',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: null,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // ✅ Tambahan untuk notifikasi langsung saat tombol ditekan
  static Future<void> showImmediateNotification() async {
    await _plugin.show(
      1000,
      'Notifikasi Langsung',
      'Ini notifikasi muncul langsung',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'dailyquest_channel',
          'DailyQuest Reminders',
          channelDescription: 'Channel untuk pengingat DailyQuest',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
}
