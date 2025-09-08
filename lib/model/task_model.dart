// lib/models/task_model.dart

class TaskModel {
  final String id;
  final String title;
  final String? description;
  final DateTime date;
  final bool isDone;
  final String category;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    this.isDone = false,
    required this.category,
  });

  // تحويل من Map (مفيد للتخزين في SharedPreferences أو Firebase)
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String?,
      date: DateTime.parse(map['date'] as String),
      isDone: map['isDone'] as bool,
      category: map['category'] as String,
    );
  }

  // تحويل لكائن Map (للتخزين أو الإرسال)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'isDone': isDone,
      'category': category,
    };
  }

  // نسخة جديدة مع تعديلات (مفيد في الكيوبت)
  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    bool? isDone,
    String? category,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      category: category ?? this.category,
    );
  }
}
