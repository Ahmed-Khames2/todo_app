import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/core/data/task_repository.dart';
import 'package:todo_app/model/task_model.dart';

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
    fetchTasks();
  }

  // تعديل مهمة
  Future<void> updateTask(TaskModel task) async {
    await repository.updateTask(task);
    fetchTasks();
  }

  // حذف مهمة
  Future<void> deleteTask(int id) async {
    await repository.deleteTask(id);
    fetchTasks();
  }

  // حذف الكل
  Future<void> deleteAllTasks() async {
    await repository.deleteAllTasks();
    fetchTasks();
  }
}
