import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_task_state.dart';
import 'package:todo_app/core/data/model/task_model.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit({TaskModel? editTask})
      : super(
          AddTaskState(
            id: editTask?.id,
            title: editTask?.title ?? '',
            description: editTask?.description ?? '',
            date: editTask?.date ?? DateTime.now(),
            category: editTask?.category,
            scheduledTime: editTask?.scheduledTime, // جديد
          ),
        );

  void changeTitle(String value) => emit(state.copyWith(title: value));
  void changeDescription(String value) => emit(state.copyWith(description: value));
  void changeDate(DateTime value) => emit(state.copyWith(date: value));
  void changeCategory(String value) => emit(state.copyWith(category: value));
  void changeScheduledTime(DateTime value) => emit(state.copyWith(scheduledTime: value)); // جديد

  void resetForm({TaskModel? editTask}) {
    emit(
      AddTaskState(
        id: editTask?.id,
        title: editTask?.title ?? '',
        description: editTask?.description ?? '',
        date: editTask?.date ?? DateTime.now(),
        category: editTask?.category,
        scheduledTime: editTask?.scheduledTime, // جديد
      ),
    );
  }
}
