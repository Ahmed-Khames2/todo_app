// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constant/app_style.dart';
import 'package:todo_app/core/cubit/tasks_cubit.dart';
import 'package:todo_app/features/addTask/add_task_page.dart';
import 'package:todo_app/features/tasks/logic/cubit/task_cubit.dart';

class TasksAppBar extends StatelessWidget {
  final TasksState state;
  const TasksAppBar({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selection = context.watch<SelectionCubit>().state;

    return AppBar(
      backgroundColor: theme.colorScheme.primary,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25.r),
        ),
      ),
      flexibleSpace: Padding(
        padding: EdgeInsets.only(left: 20.w, top: 40.h, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selection.multiSelectMode
                  ? '${selection.selectedTasks.length} مهمة مختارة'
                  : 'إليك مهامك :',
              style: AppStyle.heading.copyWith(
                color: Colors.white,
                fontSize: 20.sp,
              ),
            ),
            if (!selection.multiSelectMode)
              Text(
                'ابحث، صنف وارتب مهامك بسهولة',
                style: AppStyle.body.copyWith(
                  color: Colors.white70,
                  fontSize: 14.sp,
                ),
              ),
          ],
        ),
      ),
      leading: selection.multiSelectMode
          ? IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => context.read<SelectionCubit>().clearSelection(),
            )
          : null,
      actions: selection.multiSelectMode
          ? [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  if (selection.selectedTasks.length == 1) {
                    final task = selection.selectedTasks.first;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddTaskPage(editTask: task),
                      ),
                    // ignore: use_build_context_synchronously
                    ).then((_) => context.read<SelectionCubit>().clearSelection());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("اختار مهمة واحدة فقط للتعديل")),
                    );
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () {
                  // تقدر تنادي هنا deleteSelected
                },
              ),
            ]
          : null,
    );
  }
}
