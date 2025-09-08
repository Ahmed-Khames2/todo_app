import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/features/home/widgets/category_filter.dart';
import 'package:todo_app/features/home/widgets/custom_app_bar.dart';
import 'package:todo_app/features/home/widgets/search_field.dart';
import 'package:todo_app/features/home/widgets/tasks_list.dart';
import 'package:todo_app/core/widgets/add_task_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';
  String selectedCategory = 'الكل';
  String selectedFilter = 'الكل';

  final List<String> categories = ['الكل', 'عمل', 'دراسة', 'شخصي'];
  final List<String> filters = ['الكل', 'مكتملة', 'غير مكتملة'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          children: [
            SearchField(onChanged: (val) {
              setState(() => searchQuery = val);
            }),
            SizedBox(height: 10.h),
            CategoryFilter(
              categories: categories,
              filters: filters,
              selectedCategory: selectedCategory,
              selectedFilter: selectedFilter,
              onCategoryChanged: (cat) {
                setState(() => selectedCategory = cat);
              },
              onFilterChanged: (f) {
                setState(() => selectedFilter = f);
              },
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: TasksList(
                searchQuery: searchQuery,
                selectedCategory: selectedCategory,
                selectedFilter: selectedFilter,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AddTaskButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
