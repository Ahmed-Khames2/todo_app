import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/cubit/tasks_cubit.dart';
import 'package:todo_app/core/widgets/task_card.dart';
import 'package:todo_app/model/task_model.dart';

import 'empty_tasks.dart';

class TasksList extends StatelessWidget {
  final String searchQuery;
  final String selectedCategory;
  final String selectedFilter;

  const TasksList({
    super.key,
    required this.searchQuery,
    required this.selectedCategory,
    required this.selectedFilter,
  });

  List<TaskModel> applyFilters(List<TaskModel> tasks) {
    return tasks.where((task) {
      final matchesSearch = task.title.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      final matchesCategory =
          selectedCategory == 'الكل' || task.category == selectedCategory;
      final matchesFilter =
          selectedFilter == 'الكل' ||
          (selectedFilter == 'مكتملة' && task.isDone) ||
          (selectedFilter == 'غير مكتملة' && !task.isDone);

      return matchesSearch && matchesCategory && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state is TasksLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TasksLoaded) {
          final tasks = applyFilters(state.tasks);
          if (tasks.isEmpty) {
            return const EmptyTasks();
          }
          return ListView.builder(
            padding: EdgeInsets.only(bottom: 80.h),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskCard(
                title: task.title,
                isDone: task.isDone,
                onChanged: (val) {
                  context.read<TasksCubit>().updateTask(
                    task.copyWith(isDone: val ?? false),
                  );
                },
                
              );
            },
          );
        } else if (state is TasksError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
