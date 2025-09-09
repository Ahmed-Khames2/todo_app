import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/cubit/tasks_cubit.dart';
import 'package:todo_app/features/addTask/logic/cubit/add_task_cubit.dart';
import 'package:todo_app/features/addTask/logic/cubit/add_task_state.dart';
import 'package:todo_app/features/addTask/widgets/CustomButton.dart';
import 'package:todo_app/features/addTask/widgets/CustomDatePicker.dart';
import 'package:todo_app/features/addTask/widgets/CustomDropdown.dart';
import 'package:todo_app/features/addTask/widgets/CustomTextField.dart';
import 'package:todo_app/core/data/model/task_model.dart';

class AddTaskPage extends StatelessWidget {
  final TaskModel? editTask;

  AddTaskPage({super.key, this.editTask});

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
      create:
          (_) =>
              AddTaskCubit()
                ..changeTitle(editTask?.title ?? "")
                ..changeDescription(editTask?.description ?? "")
                ..changeDate(editTask?.date ?? DateTime.now())
                ..changeCategory(editTask?.category ?? categories.first),
      child: BlocBuilder<AddTaskCubit, AddTaskState>(
        builder: (context, state) {
          final cubit = context.read<AddTaskCubit>();
          final isEditing = editTask != null;

          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              automaticallyImplyLeading:
                  false, // ❌ يمنع ظهور زر الرجوع التلقائي
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
                  CustomDatePicker(
                    selectedDate: state.date,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: state.date ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) cubit.changeDate(date);
                    },
                  ),
                  SizedBox(height: 30.h),
                  CustomButton(
                    text: "حفظ",
                    onPressed: () {
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
                        category: state.category!,
                        isDone: editTask?.isDone ?? false,
                      );

                      if (isEditing) {
                        context.read<TasksCubit>().updateTask(task);
                      } else {
                        context.read<TasksCubit>().addTask(task);
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
