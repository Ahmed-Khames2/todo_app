import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constant/app_style.dart';
import 'package:todo_app/core/cubit/tasks_cubit.dart';
import 'package:todo_app/core/widgets/add_task_button.dart';
import 'package:todo_app/features/addTask/add_task_page.dart';
import 'package:todo_app/features/tasks/widgets/tasks_list.dart';
import 'package:todo_app/core/data/model/task_model.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final Set<TaskModel> selectedTasks = {};
  bool multiSelectMode = false;

  void toggleSelection(TaskModel task) {
    setState(() {
      selectedTasks.contains(task)
          ? selectedTasks.remove(task)
          : selectedTasks.add(task);
      if (selectedTasks.isEmpty) multiSelectMode = false;
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
      builder:
          (_) => AlertDialog(
            title: Text('تأكيد الحذف', style: TextStyle(fontSize: 18.sp)),
            content: Text(
              'هل أنت متأكد أنك تريد حذف ${selectedTasks.length} مهمة؟',
              style: TextStyle(fontSize: 16.sp),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('إلغاء', style: TextStyle(fontSize: 14.sp)),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 10.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text('حذف', style: TextStyle(fontSize: 14.sp)),
              ),
            ],
          ),
    );

    if (confirm == true) {
      for (var task in selectedTasks) {
        if (task.id != null) {
          // ignore: use_build_context_synchronously
          context.read<TasksCubit>().deleteTask(task.id!);
        }
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
                      selectedTasks.isEmpty
                          ? 'إليك مهامك :'
                          : '${selectedTasks.length} مهمة مختارة',
                      style: AppStyle.heading.copyWith(
                        color: Colors.white,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    if (selectedTasks.isEmpty)
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
              leading:
                  multiSelectMode
                      ? IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 22.sp,
                          color: Colors.white,
                        ),
                        onPressed: clearSelection,
                      )
                      : null,
              actions:
                  multiSelectMode
                      ? [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 22.sp,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (selectedTasks.length == 1) {
                              final task = selectedTasks.first;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddTaskPageSimple(editTask: task),
                                ),
                              ).then((_) => clearSelection());
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "اختار مهمة واحدة فقط للتعديل",
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.select_all,
                            size: 22.sp,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (state is TasksLoaded) {
                              selectAllOrClear(state.tasks);
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 22.sp,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => deleteSelectedTasks(context),
                        ),
                      ]
                      : null,
            ),
          ),
          body: TasksList(
            state: state,
            selectedTasks: selectedTasks.map((e) => e.id.toString()).toSet(),
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
