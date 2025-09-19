import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/constant/app_style.dart';

class TaskCardTask extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String? description;
  final bool isDone;
  final bool selected; // ✅ إضافة
  final void Function(bool?)? onChanged;

  const TaskCardTask({
    super.key,
    required this.title,
    this.subtitle,
    this.description,
    required this.isDone,
    this.onChanged,
    this.selected = false, // ✅ default = false
  });

  @override
  State<TaskCardTask> createState() => _TaskCardTaskState();
}

class _TaskCardTaskState extends State<TaskCardTask> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: AppStyle.cardDecoration(
          color: widget.selected
              // ignore: deprecated_member_use
              ? theme.colorScheme.primary.withOpacity(0.15) // ✅ لون مميز لو متعلم
              : theme.cardColor,
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 15.w,
              ),
              leading: Checkbox(
                value: widget.isDone,
                onChanged: widget.onChanged,
                activeColor: theme.colorScheme.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              title: Text(
                widget.title,
                style: AppStyle.body.copyWith(
                  fontSize: 16.sp,
                  color: widget.isDone
                      // ignore: deprecated_member_use
                      ? theme.textTheme.bodyMedium?.color?.withOpacity(0.6)
                      : theme.textTheme.bodyMedium?.color,
                  decoration:
                      widget.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: widget.subtitle != null
                  ? Text(
                      DateFormat('yyyy-MM-dd')
                          .format(DateTime.parse(widget.subtitle!)),
                      style: AppStyle.subHeading.copyWith(
                        fontSize: 14.sp,
                        color:
                            // ignore: deprecated_member_use
                            theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                      ),
                    )
                  : null,
              trailing: widget.description != null &&
                      widget.description!.isNotEmpty
                  ? IconButton(
                      icon: AnimatedRotation(
                        turns: expanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                      onPressed: () {
                        setState(() {
                          expanded = !expanded;
                        });
                      },
                    )
                  : null,
            ),
            if (expanded &&
                widget.description != null &&
                widget.description!.isNotEmpty)
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.description!,
                    style: AppStyle.subHeading.copyWith(
                      fontSize: 14.sp,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
