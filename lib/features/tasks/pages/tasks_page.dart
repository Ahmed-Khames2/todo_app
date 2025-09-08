import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constant/app_style.dart';
import 'package:todo_app/core/cubit/tasks_cubit.dart';
import 'package:todo_app/core/widgets/add_task_button.dart';
import 'package:todo_app/features/add_task_page.dart';
import 'package:todo_app/features/tasks/widgets/tasks_list.dart';
import 'package:todo_app/model/task_model.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final Set<TaskModel> selectedTasks = {};
  bool multiSelectMode = false; // 👈 لو وضع الاختيار المتعدد مفعل

  void toggleSelection(TaskModel task) {
    setState(() {
      selectedTasks.contains(task)
          ? selectedTasks.remove(task)
          : selectedTasks.add(task);
      if (selectedTasks.isEmpty) multiSelectMode = false; // لو مفيش مهام محددة
    });
  }

  void selectAllOrClear(List<TaskModel> tasks) {
    setState(() {
      if (selectedTasks.length == tasks.length) {
        selectedTasks.clear();
        multiSelectMode = false;
      } else {
        selectedTasks.addAll(tasks);
        multiSelectMode = true;
      }
    });
  }

  void clearSelection() => setState(() {
        selectedTasks.clear();
        multiSelectMode = false;
      });

  void deleteSelectedTasks(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: Text(
            'هل أنت متأكد أنك تريد حذف ${selectedTasks.length} مهمة؟'),
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
      for (var task in selectedTasks) {
        context.read<TasksCubit>().deleteTask(task.id!);
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
            preferredSize: Size.fromHeight(100.h),
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
              actions: multiSelectMode
                  ? [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          if (selectedTasks.length == 1) {
                            final task = selectedTasks.first;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddTaskPage(editTask: task),
                              ),
                            ).then((_) => clearSelection()); // 👈 بعد التعديل مسح التحديد
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "اختار مهمة واحدة فقط للتعديل")),
                            );
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.select_all),
                        onPressed: () {
                          if (state is TasksLoaded) {
                            selectAllOrClear(state.tasks);
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
            selectedTasks:
                selectedTasks.map((e) => e.id.toString()).toSet(),
            multiSelectMode: multiSelectMode,
            onLongPressSelection: (task) {
              setState(() {
                multiSelectMode = true;
              });
              toggleSelection(task);
            },
            onTapSelection: (task) {
              if (multiSelectMode) toggleSelection(task);
            },
          ),
          floatingActionButton: const AddTaskButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}
