import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constant/app_style.dart';

class CategoryFilter extends StatelessWidget {
  final List<String> categories;
  final List<String> filters;
  final String selectedCategory;
  final String selectedFilter;
  final ValueChanged<String> onCategoryChanged;
  final ValueChanged<String> onFilterChanged;

  const CategoryFilter({
    super.key,
    required this.categories,
    required this.filters,
    required this.selectedCategory,
    required this.selectedFilter,
    required this.onCategoryChanged,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((cat) {
                final isSelected = selectedCategory == cat;
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: ChoiceChip(
                    label: Text(
                      cat,
                      style: AppStyle.body.copyWith(
                        fontSize: 14.sp,
                        color: isSelected
                            ? Colors.white
                            : theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (_) => onCategoryChanged(cat),
                    selectedColor: theme.colorScheme.primary,
                    backgroundColor: theme.cardColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        PopupMenuButton<String>(
          icon: Icon(
            Icons.filter_alt,
            color: theme.iconTheme.color,
            size: 22.sp,
          ),
          onSelected: onFilterChanged,
          itemBuilder: (context) {
            return filters
                .map(
                  (f) => PopupMenuItem(
                    value: f,
                    child: Text(
                      f,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                )
                .toList();
          },
        ),
      ],
    );
  }
}
