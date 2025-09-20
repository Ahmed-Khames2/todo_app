import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final DateTime? selectedTime;
  final VoidCallback onSelectDate;
  final VoidCallback onSelectTime;

  const CustomDatePicker({
    super.key,
    required this.selectedDate,
    this.selectedTime,
    required this.onSelectDate,
    required this.onSelectTime,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        InkWell(
          onTap: onSelectDate,
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
                Icon(Icons.calendar_today,
                    size: 22.sp, color: theme.colorScheme.primary),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.h),
        InkWell(
          onTap: onSelectTime,
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
                  selectedTime != null
                      ? 'الوقت: ${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}'
                      : 'اختر الوقت (اختياري)',
                  style: TextStyle(fontSize: 16.sp),
                ),
                Icon(Icons.access_time,
                    size: 22.sp, color: theme.colorScheme.primary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
