import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/activity_model.dart';

class ActivityService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<ActivityModel>> fetchActivities() async {
    final user = _client.auth.currentUser;
    if (user == null) throw 'User not logged in';

    final data = await _client
        .from('activities')
        .select()
        .eq('user_id', user.id)
        .order('activity_date', ascending: true);

    return (data as List).map((e) => ActivityModel.fromMap(e)).toList();
  }

  Future<void> addActivity(ActivityModel activity) async {
    final user = _client.auth.currentUser;
    if (user == null) throw 'User not logged in';

    await _client.from('activities').insert({
      ...activity.toMap(),
      'user_id': user.id,
    });
  }

  Future<void> updateActivity(String id, Map<String, dynamic> data) async {
    await _client.from('activities').update(data).eq('id', id);
  }

  Future<void> deleteActivity(String id) async {
    await _client.from('activities').delete().eq('id', id);
  }
}
//activity services