import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/cubit/tasks_cubit.dart';
import 'package:todo_app/core/data/model/task_model.dart';
import 'package:todo_app/features/tasks/widgets/task_card_task.dart';

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
      return Center(
        child: Text("لا توجد مهام بعد", style: TextStyle(fontSize: 16.sp)),
      );
    }

    final tasks = (state as TasksLoaded).tasks;

    if (tasks.isEmpty) {
      return Center(
        child: Text("لا توجد مهام بعد", style: TextStyle(fontSize: 16.sp)),
      );
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
            margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: isSelected ? Colors.blue.withOpacity(0.2) : null,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TaskCardTask(
              title: task.title,
              description: task.description, // 👈 أضفنا دي

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
