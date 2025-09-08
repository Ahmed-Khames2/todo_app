import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart'; 

class AppStyle {
  // ====== Text Styles ======
  static TextStyle heading = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'Cairo',
    color: AppColors.lightTextPrimary,
  );

  static TextStyle subHeading = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    fontFamily: 'Cairo',
    color: AppColors.lightTextPrimary,
  );

  static TextStyle body = TextStyle(
    fontSize: 16.sp,
    fontFamily: 'Cairo',
    color: AppColors.lightTextPrimary,
  );

  static TextStyle small = TextStyle(
    fontSize: 14.sp,
    fontFamily: 'Cairo',
    color: AppColors.lightTextSecondary,
  );

  // ====== Card Decoration ======
  static BoxDecoration cardDecoration({Color? color}) {
    return BoxDecoration(
      color: color ?? AppColors.lightSurface,
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 3.r,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  // ====== Button Style ======
  static ButtonStyle elevatedButtonStyle({Color? bgColor}) {
    return ElevatedButton.styleFrom(
      backgroundColor: bgColor ?? AppColors.lightPrimary,
      foregroundColor: Colors.white,
      elevation: 3,
      textStyle: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }

  static ButtonStyle textButtonStyle({Color? color}) {
    return TextButton.styleFrom(
      foregroundColor: color ?? AppColors.lightPrimary,
      textStyle: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),
    );
  }
}
