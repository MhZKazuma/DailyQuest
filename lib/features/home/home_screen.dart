import 'package:dailyquest_fixed/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/activity_controller.dart';
import 'widgets/add_activity_dialog.dart';
import 'widgets/activity_card.dart';
import 'package:dailyquest_fixed/utils/notification_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final activityController = Get.put(ActivityController());

  @override
  void initState() {
    super.initState();

    final now = TimeOfDay.now();
    final nextMinute = (now.minute + 1) % 60;
    final nextHour = (now.minute + 1 >= 60) ? (now.hour + 1) % 24 : now.hour;

    NotificationHelper.scheduleDailyNotification(
      id: 1,
      title: 'Reminder!',
      body: 'Cek habit harianmu!',
      time: TimeOfDay(hour: nextHour, minute: nextMinute),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DailyQuest'),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed('/profile'),
            icon: const Icon(Icons.person),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.toNamed(AppRoutes.settings),
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              NotificationHelper.showImmediateNotification();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (activityController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (activityController.activities.isEmpty) {
          return const Center(child: Text('Belum ada kegiatan.'));
        }

        return ListView.builder(
          itemCount: activityController.activities.length,
          itemBuilder: (context, index) {
            final item = activityController.activities[index];
            return ActivityCard(activity: item);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddActivityDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
