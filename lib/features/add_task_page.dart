import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/cubit/tasks_cubit.dart';
import 'package:todo_app/model/task_model.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedCategory;

  final List<String> categories = ['الكل', 'عمل', 'دراسة', 'شخصي'];

  void _pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _selectedCategory != null) {
      final task = TaskModel(
        id: DateTime.now().millisecondsSinceEpoch,
        title: _titleController.text,
        description: _descriptionController.text,
        date: _selectedDate!,
        category: _selectedCategory!,
        isDone: false,
      );

      context.read<TasksCubit>().addTask(task);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("أكمل كل البيانات قبل الحفظ")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إضافة مهمة")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "عنوان المهمة"),
                validator: (val) =>
                    val == null || val.isEmpty ? "أدخل عنوان المهمة" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "وصف المهمة"),
                validator: (val) =>
                    val == null || val.isEmpty ? "أدخل وصف المهمة" : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "الفئة"),
                items: categories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                value: _selectedCategory,
                onChanged: (val) => setState(() => _selectedCategory = val),
                validator: (val) => val == null ? "اختر الفئة" : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "اختر تاريخ"
                          : "التاريخ: ${_selectedDate!.toLocal()}".split(' ')[0],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: const Text("اختيار التاريخ"),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveTask,
                child: const Text("حفظ المهمة"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
