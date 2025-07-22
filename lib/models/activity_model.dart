class ActivityModel {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final DateTime activityDate;
  final String activityTime;
  final String status;

  ActivityModel({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.activityDate,
    required this.activityTime,
    required this.status,
  });

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      id: map['id'],
      userId: map['user_id'],
      title: map['title'],
      description: map['description'],
      activityDate: DateTime.parse(map['activity_date']),
      activityTime: map['activity_time'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'activity_date': activityDate.toIso8601String().split('T')[0],
      'activity_time': activityTime,
      'status': status,
    };
  }
}
