import 'package:equatable/equatable.dart';

class AddTaskState extends Equatable {
  final int? id;
  final String title;
  final String description;
  final DateTime? date;
  final String? category;
  final DateTime? scheduledTime; // جديد

  const AddTaskState({
    this.id,
    this.title = '',
    this.description = '',
    this.date,
    this.category,
    this.scheduledTime, // جديد
  });

  AddTaskState copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? date,
    String? category,
    DateTime? scheduledTime, // جديد
  }) {
    return AddTaskState(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      category: category ?? this.category,
      scheduledTime: scheduledTime ?? this.scheduledTime, // جديد
    );
  }

  @override
  List<Object?> get props => [id, title, description, date, category, scheduledTime];
}
