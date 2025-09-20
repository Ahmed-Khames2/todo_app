class TaskModel {
  final int? id;
  final String title;
  final String? description;
  final DateTime date; // created at
  final bool isDone;
  final String category;

  final DateTime? scheduledTime; // ← ميعاد تنفيذ المهمة (Notification)

  TaskModel({
    this.id,
    required this.title,
    this.description,
    required this.date,
    this.isDone = false,
    required this.category,
    this.scheduledTime, // جديد
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': date.toIso8601String(),
      'isDone': isDone ? 1 : 0,
      'category': category,
      'scheduledTime': scheduledTime?.toIso8601String(), // جديد
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String?,
      date: DateTime.parse(map['createdAt'] as String),
      isDone: (map['isDone'] as int) == 1,
      category: map['category'] as String,
      scheduledTime: map['scheduledTime'] != null
          ? DateTime.parse(map['scheduledTime'] as String)
          : null, // جديد
    );
  }

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? date,
    bool? isDone,
    String? category,
    DateTime? scheduledTime, // جديد
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      category: category ?? this.category,
      scheduledTime: scheduledTime ?? this.scheduledTime, // جديد
    );
  }
}
