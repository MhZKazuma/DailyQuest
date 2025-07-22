import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/activity_controller.dart';
import '../../../models/activity_model.dart';
import 'package:uuid/uuid.dart';

void showAddActivityDialog(BuildContext context) {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final activityController = Get.find<ActivityController>();

  showDialog(
    context: context,
    builder:
        (_) => AlertDialog(
          title: const Text('Tambah Kegiatan'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Judul'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: 'Deskripsi'),
                ),
                const SizedBox(height: 8),
                ListTile(
                  title: Text(
                    'Tanggal: ${DateFormat.yMMMd().format(selectedDate)}',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      selectedDate = date;
                    }
                  },
                ),
                ListTile(
                  title: Text('Jam: ${selectedTime.format(context)}'),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (time != null) {
                      selectedTime = time;
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: Get.back, child: const Text('Batal')),
            ElevatedButton(
              onPressed: () {
                final activity = ActivityModel(
                  id: const Uuid().v4(),
                  userId: '',
                  title: titleController.text,
                  description: descController.text,
                  activityDate: selectedDate,
                  activityTime: selectedTime.format(context),
                  status: 'pending',
                );
                activityController.add(activity);
                Get.back();
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
  );
}
// iki activity dialog gokkkkk//