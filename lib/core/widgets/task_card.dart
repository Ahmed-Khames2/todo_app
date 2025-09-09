import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constant/app_style.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String? description;
  final bool isDone;
  final void Function(bool?)? onChanged;

  const TaskCard({
    super.key,
    required this.title,
    this.subtitle,
    this.description,
    required this.isDone,
    this.onChanged,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      child: Container(
        decoration: AppStyle.cardDecoration(
          color: theme.cardColor,
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
                      ? theme.textTheme.bodyMedium?.color?.withOpacity(0.6)
                      : theme.textTheme.bodyMedium?.color,
                  decoration:
                      widget.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: widget.subtitle != null
                  ? Text(
                      widget.subtitle!,
                      style: AppStyle.subHeading.copyWith(
                        fontSize: 14.sp,
                        color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                      ),
                    )
                  : null,
              trailing: IconButton(
                icon: Icon(
                  expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 24.sp,
                  color: theme.colorScheme.primary,
                ),
                onPressed: () {
                  setState(() {
                    expanded = !expanded;
                  });
                },
              ),
            ),
            if (expanded && widget.description != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Text(
                  widget.description!,
                  style: AppStyle.body.copyWith(
                    fontSize: 14.sp,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
/**
 * 
 * import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constant/app_style.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? description;
  final bool isDone;
  final bool expanded;
  final void Function(bool?)? onChanged;
  final VoidCallback onToggleExpanded;

  const TaskCard({
    super.key,
    required this.title,
    this.subtitle,
    this.description,
    required this.isDone,
    required this.expanded,
    this.onChanged,
    required this.onToggleExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      child: Container(
        decoration: AppStyle.cardDecoration(color: theme.cardColor),
        child: Column(
          children: [
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              leading: Checkbox(
                value: isDone,
                onChanged: onChanged,
                activeColor: theme.colorScheme.primary,
              ),
              title: Text(
                title,
                style: AppStyle.body.copyWith(
                  color: isDone
                      ? theme.textTheme.bodyMedium?.color?.withOpacity(0.6)
                      : theme.textTheme.bodyMedium?.color,
                  decoration: isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: subtitle != null
                  ? Text(
                      subtitle!,
                      style: AppStyle.subHeading.copyWith(
                        color: theme.textTheme.bodyMedium?.color
                            ?.withOpacity(0.6),
                      ),
                    )
                  : null,
              trailing: description != null
                  ? IconButton(
                      icon: Icon(
                        expanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: theme.colorScheme.primary,
                      ),
                      onPressed: onToggleExpanded,
                    )
                  : null,
            ),
            if (expanded && description != null)
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Text(
                  description!,
                  style: AppStyle.body.copyWith(
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

 */