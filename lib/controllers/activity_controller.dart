import 'package:get/get.dart';
import '../models/activity_model.dart';
import '../services/activity_service.dart';

class ActivityController extends GetxController {
  final ActivityService _service = ActivityService();
  RxList<ActivityModel> activities = <ActivityModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadActivities();
  }

  Future<void> loadActivities() async {
    isLoading.value = true;
    try {
      final data = await _service.fetchActivities();
      activities.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat kegiatan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> add(ActivityModel activity) async {
    await _service.addActivity(activity);
    loadActivities();
  }

  Future<void> updateActivity(String id, Map<String, dynamic> data) async {
    await _service.updateActivity(id, data);
    loadActivities(); // refresh list
  }

  Future<void> delete(String id) async {
    await _service.deleteActivity(id);
    loadActivities();
  }
}
// ini activity conytroller ahahah//