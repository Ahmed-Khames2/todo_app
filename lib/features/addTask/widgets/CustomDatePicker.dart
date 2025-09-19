// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onTap;

  const CustomDatePicker({
    super.key,
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: theme.colorScheme.primary, width: 1.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate != null
                  ? 'التاريخ: ${selectedDate!.toLocal()}'.split(' ')[0]
                  : 'اختر التاريخ',
              style: TextStyle(fontSize: 16.sp),
            ),
            Icon(Icons.calendar_today, size: 22.sp, color: theme.colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
