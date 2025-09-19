import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/data/model/task_model.dart';

class SelectionState {
  final Set<TaskModel> selectedTasks;
  final bool multiSelectMode;

  SelectionState({
    this.selectedTasks = const {},
    this.multiSelectMode = false,
  });

  SelectionState copyWith({
    Set<TaskModel>? selectedTasks,
    bool? multiSelectMode,
  }) {
    return SelectionState(
      selectedTasks: selectedTasks ?? this.selectedTasks,
      multiSelectMode: multiSelectMode ?? this.multiSelectMode,
    );
  }
}

class SelectionCubit extends Cubit<SelectionState> {
  SelectionCubit() : super(SelectionState());

  void toggleSelection(TaskModel task) {
    final newSet = {...state.selectedTasks};
    if (newSet.contains(task)) {
      newSet.remove(task);
    } else {
      newSet.add(task);
    }
    emit(state.copyWith(
      selectedTasks: newSet,
      multiSelectMode: newSet.isNotEmpty,
    ));
  }

  void clearSelection() {
    emit(SelectionState());
  }

  void selectAll(List<TaskModel> tasks) {
    emit(state.copyWith(
      selectedTasks: tasks.toSet(),
      multiSelectMode: true,
    ));
  }
}
