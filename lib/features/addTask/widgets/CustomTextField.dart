import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final IconData icon;
  final String? initialValue;
  final int maxLines;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    this.hint,
    this.initialValue,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(
        fontSize: 14.sp,
        color: theme.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 13.sp,
          color: theme.hintColor,
        ),
        labelStyle: TextStyle(
          color: theme.colorScheme.primary,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: theme.colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 1.5,
          ),
        ),
        prefixIcon: Icon(
          icon,
          size: 22.sp,
          color: theme.colorScheme.primary,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 12.w,
        ),
      ),
    );
  }
}
