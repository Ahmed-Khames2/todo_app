import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(const AddTaskState());

  void changeTitle(String value) => emit(state.copyWith(title: value));
  void changeDescription(String value) => emit(state.copyWith(description: value));
  void changeDate(DateTime value) => emit(state.copyWith(date: value));
  void changeCategory(String value) => emit(state.copyWith(category: value));

  void resetForm() => emit(const AddTaskState());
}
