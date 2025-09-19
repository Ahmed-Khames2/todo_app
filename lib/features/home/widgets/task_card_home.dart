import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/constant/app_style.dart';

class TaskCardHome extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String? description;
  final bool isDone;
  final void Function(bool?)? onChanged;

  const TaskCardHome({
    super.key,
    required this.title,
    this.subtitle,
    this.description,
    required this.isDone,
    this.onChanged,
  });

  @override
  State<TaskCardHome> createState() => _TaskCardHomeState();
}

class _TaskCardHomeState extends State<TaskCardHome> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(16.r),
        color: theme.cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: widget.description != null && widget.description!.isNotEmpty
              ? () => setState(() => expanded = !expanded)
              : null,
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: widget.isDone,
                      onChanged: widget.onChanged,
                      activeColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: AppStyle.body.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: widget.isDone
                                  ? theme.textTheme.bodyMedium?.color
                                      // ignore: deprecated_member_use
                                      ?.withOpacity(0.6)
                                  : theme.textTheme.bodyMedium?.color,
                              decoration: widget.isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          if (widget.subtitle != null)
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 14.sp,
                                  color: theme.colorScheme.primary,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  DateFormat('yyyy-MM-dd').format(
                                    DateTime.parse(widget.subtitle!),
                                  ),
                                  style: AppStyle.subHeading.copyWith(
                                    fontSize: 13.sp,
                                    color: theme.textTheme.bodyMedium?.color
                                        // ignore: deprecated_member_use
                                        ?.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    if (widget.description != null &&
                        widget.description!.isNotEmpty)
                      AnimatedRotation(
                        turns: expanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 250),
                        child: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: theme.colorScheme.primary),
                          onPressed: () =>
                              setState(() => expanded = !expanded),
                        ),
                      ),
                  ],
                ),
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                    child: Text(
                      widget.description ?? '',
                      style: AppStyle.body.copyWith(
                        fontSize: 14.sp,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),
                  crossFadeState: expanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 250),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
