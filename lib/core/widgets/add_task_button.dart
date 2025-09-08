import 'package:flutter/material.dart';
import 'package:todo_app/features/add_task_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, right: 10.w),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskPage()),
          );
        },
        backgroundColor: theme.colorScheme.primary,
        child: Icon(Icons.add, size: 28.sp, color: Colors.white),
      ),
    );
  }
}
