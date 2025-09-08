import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/cubit/tasks_cubit.dart';
import 'package:todo_app/core/widgets/task_card.dart';
import 'package:todo_app/model/task_model.dart';

class TasksList extends StatelessWidget {
  final TasksState state;
  final Set<String> selectedTasks;
  final bool multiSelectMode;
  final Function(TaskModel) onLongPressSelection;
  final Function(TaskModel) onTapSelection;

  const TasksList({
    super.key,
    required this.state,
    required this.selectedTasks,
    required this.multiSelectMode,
    required this.onLongPressSelection,
    required this.onTapSelection,
  });

  @override
  Widget build(BuildContext context) {
    if (state is! TasksLoaded) {
      return const Center(child: Text("لا توجد مهام بعد"));
    }

    final tasks = (state as TasksLoaded).tasks;

    if (tasks.isEmpty) {
      return const Center(child: Text("لا توجد مهام بعد"));
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final isSelected = selectedTasks.contains(task.id.toString());

        return GestureDetector(
          onTap: () {
            if (multiSelectMode) onTapSelection(task);
          },
          onLongPress: () {
            onLongPressSelection(task);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue.withOpacity(0.2) : null,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TaskCard(
              title: task.title,
              subtitle: task.date.toString(),
              isDone: task.isDone,
              onChanged: (val) {
                context.read<TasksCubit>().toggleTask(task.id!);
              },
            ),
          ),
        );
      },
    );
  }
}
