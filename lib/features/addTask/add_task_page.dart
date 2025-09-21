import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/cubit/tasks_cubit.dart';
import 'package:todo_app/core/services/notification_service.dart';
import 'package:todo_app/features/addTask/logic/cubit/add_task_cubit.dart';
import 'package:todo_app/features/addTask/logic/cubit/add_task_state.dart';
import 'package:todo_app/features/addTask/widgets/CustomButton.dart';
import 'package:todo_app/features/addTask/widgets/CustomDropdown.dart';
import 'package:todo_app/features/addTask/widgets/CustomTextField.dart';
import 'package:todo_app/core/data/model/task_model.dart';
import 'package:timezone/timezone.dart' as tz;

class AddTaskPageSimple extends StatelessWidget {
  final TaskModel? editTask;

  AddTaskPageSimple({super.key, this.editTask});

  final List<String> categories = [
    'الكل',
    'عمل',
    'دراسة',
    'شخصي',
    'صحة / رياضة',
    'عائلة',
    'مالية',
    'تسوق / مشتريات',
    'مشاريع / أهداف',
    'سفر / مناسبات',
    'أعمال منزلية',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddTaskCubit(editTask: editTask),
      child: BlocBuilder<AddTaskCubit, AddTaskState>(
        builder: (context, state) {
          final cubit = context.read<AddTaskCubit>();
          final isEditing = editTask != null;

          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                isEditing ? "تعديل المهمة" : "إضافة مهمة",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  CustomTextField(
                    label: "العنوان",
                    icon: Icons.title,
                    initialValue: state.title,
                    onChanged: cubit.changeTitle,
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    label: "الوصف",
                    icon: Icons.description,
                    maxLines: 4,
                    initialValue: state.description,
                    onChanged: cubit.changeDescription,
                  ),
                  SizedBox(height: 20.h),
                  CustomDropdown(
                    items: categories,
                    value: state.category,
                    onChanged: cubit.changeCategory,
                  ),
                  SizedBox(height: 20.h),

                  // ===== تاريخ إنشاء المهمة =====
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: state.date ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (date != null) cubit.changeDate(date);
                          },
                          child: Text(
                            state.date != null
                                ? 'تاريخ المهمة: ${state.date!.toLocal()}'
                                    .split(' ')[0]
                                : 'اختر تاريخ المهمة',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // ===== وقت الإشعار =====
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (time != null && state.date != null) {
                              DateTime scheduledDateTime = DateTime(
                                state.date!.year,
                                state.date!.month,
                                state.date!.day,
                                time.hour,
                                time.minute,
                              );
                              if (scheduledDateTime.isBefore(DateTime.now())) {
                                scheduledDateTime = scheduledDateTime.add(
                                  const Duration(days: 1),
                                );
                              }
                              cubit.changeScheduledTime(scheduledDateTime);
                            }
                          },
                          child: Text(
                            state.scheduledTime != null
                                ? 'وقت التنبيه: ${state.scheduledTime!.hour.toString().padLeft(2, '0')}:${state.scheduledTime!.minute.toString().padLeft(2, '0')}'
                                : 'اختر وقت التنبيه',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),

                  CustomButton(
                    text: "حفظ",
                    onPressed: () async {
                      if (state.title.isEmpty ||
                          state.description.isEmpty ||
                          state.date == null ||
                          state.category == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("أكمل كل البيانات")),
                        );
                        return;
                      }

                      final task = TaskModel(
                        id:
                            editTask?.id ??
                            DateTime.now().millisecondsSinceEpoch,
                        title: state.title,
                        description: state.description,
                        date: state.date!,
                        scheduledTime: state.scheduledTime,
                        category: state.category!,
                        isDone: editTask?.isDone ?? false,
                      );

                      if (isEditing) {
                        context.read<TasksCubit>().updateTask(task);
                      } else {
                        context.read<TasksCubit>().addTask(task);
                      }

                      if (task.scheduledTime != null) {
                        await NotificationService().scheduleNotification(
                          id: task.id! % 2147483647,
                          title: task.title,
                          body: task.description!,
                          scheduledTime: task.scheduledTime!,
                        );
                      }

                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
