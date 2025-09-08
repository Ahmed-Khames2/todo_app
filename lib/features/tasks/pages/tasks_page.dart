import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constant/app_style.dart';
import 'package:todo_app/core/cubit/tasks_cubit.dart';
import 'package:todo_app/features/tasks/widgets/tasks_list.dart';
import 'package:todo_app/core/widgets/add_task_button.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final Set<String> selectedTasks = {};

  void toggleSelection(int id) {
    final idStr = id.toString();
    setState(() {
      selectedTasks.contains(idStr)
          ? selectedTasks.remove(idStr)
          : selectedTasks.add(idStr);
    });
  }

  void selectAll(List<int> ids) =>
      setState(() => selectedTasks.addAll(ids.map((e) => e.toString())));

  void clearSelection() => setState(() => selectedTasks.clear());

  void deleteSelectedTasks(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content:
            Text('هل أنت متأكد أنك تريد حذف ${selectedTasks.length} مهمة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('حذف'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      for (var idStr in selectedTasks) {
        final id = int.parse(idStr);
        context.read<TasksCubit>().deleteTask(id);
      }
      clearSelection();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.h),
            child: AppBar(
              backgroundColor: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.r),
                ),
              ),
              flexibleSpace: Padding(
                padding: EdgeInsets.only(left: 20.w, top: 35.h, right: 20.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    selectedTasks.isEmpty
                        ? 'إليك مهامك :'
                        : '${selectedTasks.length} مهمة مختارة',
                    style: AppStyle.heading.copyWith(color: Colors.white),
                  ),
                ),
              ),
              actions: selectedTasks.isNotEmpty
                  ? [
                      IconButton(
                        icon: const Icon(Icons.select_all),
                        onPressed: () {
                          if (state is TasksLoaded) {
                            selectAll(state.tasks.map((t) => t.id!).toList());
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteSelectedTasks(context),
                      ),
                    ]
                  : null,
            ),
          ),
          body: TasksList(
            state: state,
            selectedTasks: selectedTasks,
            onToggleSelection: toggleSelection,
          ),
          floatingActionButton: AddTaskButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}
