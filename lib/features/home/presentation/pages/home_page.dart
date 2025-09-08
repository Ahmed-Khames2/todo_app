import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constant/app_style.dart';
import 'package:todo_app/features/widgets/task_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> allTasks = [
    {'title': 'مراجعة Flutter', 'isDone': false, 'category': 'دراسة'},
    {'title': 'كتابة Documentation', 'isDone': true, 'category': 'عمل'},
    {'title': 'تنظيف المكتب', 'isDone': false, 'category': 'شخصي'},
    {'title': 'قراءة كتاب', 'isDone': false, 'category': 'دراسة'},
  ];

  String searchQuery = '';
  String selectedCategory = 'الكل';
  String selectedFilter = 'الكل';

  List<Map<String, dynamic>> get filteredTasks {
    return allTasks.where((task) {
      final matchesSearch = task['title'].toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      final matchesCategory =
          selectedCategory == 'الكل' || task['category'] == selectedCategory;
      final matchesFilter =
          selectedFilter == 'الكل' ||
          (selectedFilter == 'مكتملة' && task['isDone']) ||
          (selectedFilter == 'غير مكتملة' && !task['isDone']);
      return matchesSearch && matchesCategory && matchesFilter;
    }).toList();
  }

  final List<String> categories = ['الكل', 'عمل', 'دراسة', 'شخصي'];
  final List<String> filters = ['الكل', 'مكتملة', 'غير مكتملة'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: AppBar(
          backgroundColor: theme.colorScheme.primary,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.r)),
          ),
          flexibleSpace: Padding(
            padding: EdgeInsets.only(left: 20.w, top: 40.h, right: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // الترحيب
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'مرحباً بك،',
                      style: AppStyle.heading.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 4.h),
                    // Text(
                    //   'إليك مهامك اليوم:',
                    //   style: AppStyle.body.copyWith(
                    //     color: Colors.white70,
                    //     fontSize: 14.sp,
                    //   ),
                    // ),
                    Text(
                      'ابحث، صنف وارتب مهامك بسهولة',
                      style: AppStyle.body.copyWith(
                        color: Colors.white70,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                // أيقونة الملف الشخصي
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: theme.colorScheme.primary),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          children: [
            // Search
            TextField(
              decoration: InputDecoration(
                hintText: 'ابحث عن مهمة...',
                prefixIcon: Icon(Icons.search, color: theme.iconTheme.color),
                filled: true,
                fillColor: theme.cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) {
                setState(() {
                  searchQuery = val;
                });
              },
            ),
            SizedBox(height: 10.h),
            // Categories + Filter
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          categories.map((cat) {
                            final isSelected = selectedCategory == cat;
                            return Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: ChoiceChip(
                                label: Text(cat),
                                selected: isSelected,
                                onSelected: (_) {
                                  setState(() {
                                    selectedCategory = cat;
                                  });
                                },
                                selectedColor: theme.colorScheme.primary,
                                backgroundColor: theme.cardColor,
                                labelStyle: AppStyle.body.copyWith(
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : theme.textTheme.bodyMedium?.color,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.filter_alt, color: theme.iconTheme.color),
                  onSelected: (val) {
                    setState(() {
                      selectedFilter = val;
                    });
                  },
                  itemBuilder: (context) {
                    return filters
                        .map((f) => PopupMenuItem(value: f, child: Text(f)))
                        .toList();
                  },
                ),
              ],
            ),
            SizedBox(height: 10.h),
            // Task Cards
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 80.h),
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];
                  return TaskCard(
                    title: task['title'],
                    isDone: task['isDone'],
                    onChanged: (val) {
                      setState(() {
                        task['isDone'] = val ?? false;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 10.h, right: 10.w),
        child: FloatingActionButton(
          onPressed: () {
            // فتح BottomSheet لإضافة مهمة جديدة لاحقاً
          },
          backgroundColor: theme.colorScheme.primary,
          child: Icon(Icons.add, size: 28.sp, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
