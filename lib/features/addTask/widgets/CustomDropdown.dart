// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String? value;
  final Function(String) onChanged;

  const CustomDropdown({
    super.key,
    required this.items,
    this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map(
            (c) => DropdownMenuItem(
              value: c,
              child: Text(
                c,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (val) => onChanged(val!),
      decoration: InputDecoration(
        labelText: 'الفئة',
        labelStyle: TextStyle(
          color: theme.colorScheme.primary,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: theme.colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(
            // ignore: deprecated_member_use
            color: theme.colorScheme.outline.withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(
            // ignore: deprecated_member_use
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 1.4,
          ),
        ),
      ),
      borderRadius: BorderRadius.circular(14.r),
      dropdownColor: theme.colorScheme.surface,
    );
  }
}
