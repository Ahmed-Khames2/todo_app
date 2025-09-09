import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 50.h,
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: 'ابحث عن مهمة...',
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: theme.hintColor,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 22.sp,
            color: theme.iconTheme.color,
          ),
          filled: true,
          fillColor: theme.cardColor,
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 12.w,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
