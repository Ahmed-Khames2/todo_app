// lib/cubit/tasks_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/core/data/task_repository.dart';
import 'package:todo_app/core/data/model/task_model.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final TaskRepository repository;

  TasksCubit(this.repository) : super(TasksInitial());

  // جلب المهام
  Future<void> fetchTasks() async {
    emit(TasksLoading());
    try {
      final tasks = await repository.getTasks();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError("فشل في جلب المهام: $e"));
    }
  }
  // إضافة مهمة
  Future<void> addTask(TaskModel task) async {
    await repository.addTask(task);
    await fetchTasks();
  }

  // تعديل مهمة
  Future<void> updateTask(TaskModel task) async {
    await repository.updateTask(task);
    await fetchTasks();
  }
  // حذف مهمة
 Future<void> deleteTask(int id) async {
  await repository.deleteTask(id);
  await fetchTasks();
}
  // حذف الكل
  Future<void> deleteAllTasks() async {
    await repository.deleteAllTasks();
    await fetchTasks();
  }
  Future<void> toggleTask(int id) async {
  try {
    if (state is TasksLoaded) {
      final currentTasks = (state as TasksLoaded).tasks;
      final task = currentTasks.firstWhere((t) => t.id == id);
      final updatedTask = task.copyWith(isDone: !task.isDone);
      await repository.updateTask(updatedTask);
      await fetchTasks();
    }
  } catch (e) {
    emit(TasksError("فشل في تحديث حالة المهمة: $e"));
  }
}
}
