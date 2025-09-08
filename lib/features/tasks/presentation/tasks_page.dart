import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constant/app_style.dart';
import 'package:todo_app/features/widgets/task_card.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'مراجعة Flutter',
      'isDone': false,
      'date': DateTime(2025, 9, 8, 10, 0),
    },
    {
      'title': 'كتابة Documentation',
      'isDone': true,
      'date': DateTime(2025, 9, 7, 14, 0),
    },
    {
      'title': 'تنظيف المكتب',
      'isDone': false,
      'date': DateTime(2025, 9, 8, 9, 0),
    },
    {
      'title': 'قراءة كتاب',
      'isDone': true,
      'date': DateTime(2025, 9, 6, 18, 0),
    },
  ];

  final Set<int> selectedTasks = {}; // لتخزين المهام المختارة

  void toggleSelection(int index) {
    setState(() {
      if (selectedTasks.contains(index)) {
        selectedTasks.remove(index);
      } else {
        selectedTasks.add(index);
      }
    });
  }

  void selectAll() {
    setState(() {
      selectedTasks.addAll(List.generate(tasks.length, (i) => i));
    });
  }

  void clearSelection() => setState(() => selectedTasks.clear());

  void deleteSelectedTasks() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: Text('هل أنت متأكد أنك تريد حذف ${selectedTasks.length} مهمة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('حذف'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        tasks.removeWhere((task) => selectedTasks.contains(tasks.indexOf(task)));
        selectedTasks.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.h),
        child: AppBar(
          backgroundColor: theme.colorScheme.primary,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
          ),
          flexibleSpace: Padding(
            padding: EdgeInsets.only(left: 20.w, top: 35.h, right: 20.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                selectedTasks.isEmpty
                    ? 'إليك مهامك :'
                    : '${selectedTasks.length} مهمة مختارة',
                style: AppStyle.heading.copyWith(color: Colors.white),
              ),
            ),
          ),
          actions: selectedTasks.isNotEmpty
              ? [
                  IconButton(
                    icon: const Icon(Icons.select_all),
                    onPressed: selectAll,
                    tooltip: 'اختيار الكل',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: deleteSelectedTasks,
                    tooltip: 'حذف المهام المختارة',
                  ),
                ]
              : null,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            final isSelected = selectedTasks.contains(index);
            return GestureDetector(
              onLongPress: () => toggleSelection(index),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primary.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TaskCard(
                  title: task['title'],
                  subtitle:
                      '${task['date'].day}/${task['date'].month}/${task['date'].year} ${task['date'].hour}:${task['date'].minute.toString().padLeft(2, '0')}',
                  isDone: task['isDone'],
                  onChanged: (val) {
                    setState(() {
                      task['isDone'] = val ?? false;
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // فتح BottomSheet لإضافة مهمة جديدة لاحقاً
        },
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
