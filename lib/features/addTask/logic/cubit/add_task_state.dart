import 'package:equatable/equatable.dart';

class AddTaskState extends Equatable {
  final String title;
  final String description;
  final DateTime? date;
  final String? category;

  const AddTaskState({
    this.title = '',
    this.description = '',
    this.date,
    this.category,
  });

  AddTaskState copyWith({
    String? title,
    String? description,
    DateTime? date,
    String? category,
  }) {
    return AddTaskState(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [title, description, date, category];
}
