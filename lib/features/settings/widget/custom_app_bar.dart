import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constant/app_style.dart';

/// AppBar مخصص لصفحة الإعدادات
class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SettingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.colorScheme.primary,
      elevation: 6,
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25.r),
        ),
      ),
      flexibleSpace: Padding(
        padding: EdgeInsets.only(left: 16.w, top: 40.h, right: 16.w),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'إعدادات التطبيق',
                style: AppStyle.heading.copyWith(
                  color: Colors.white,
                  fontSize: 20.sp, // متجاوب
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'غير شكل التطبيق حسب تفضيلاتك',
                style: AppStyle.body.copyWith(
                  color: Colors.white70,
                  fontSize: 13.sp, // متجاوب
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(95.h);
}
