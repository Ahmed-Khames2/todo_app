import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/model/task_model.dart';
import '../core/cubit/tasks_cubit.dart';
// import '../core/data/task_model.dart';

class AddTaskPage extends StatefulWidget {
  final TaskModel? editTask;
  const AddTaskPage({super.key, this.editTask});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _selectedDate;
  String? _selectedCategory;

  final List<String> categories = ['عمل', 'دراسة', 'تسوق', 'أخرى'];

  @override
  void initState() {
    super.initState();
    if (widget.editTask != null) {
      _titleController = TextEditingController(text: widget.editTask!.title);
      _descriptionController =
          TextEditingController(text: widget.editTask!.description);
      _selectedDate = widget.editTask!.date;
      _selectedCategory = widget.editTask!.category;
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    }
  }

  void _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  void _saveTask() {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _selectedCategory != null) {
      final task = TaskModel(
        id: widget.editTask?.id ?? DateTime.now().millisecondsSinceEpoch,
        title: _titleController.text,
        description: _descriptionController.text,
        date: _selectedDate!,
        category: _selectedCategory!,
        isDone: widget.editTask?.isDone ?? false,
      );

      if (widget.editTask != null) {
        context.read<TasksCubit>().updateTask(task);
      } else {
        context.read<TasksCubit>().addTask(task);
      }

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("أكمل كل البيانات")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.editTask != null ? 'تعديل المهمة' : 'إضافة مهمة')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'العنوان'),
                validator: (val) => val == null || val.isEmpty ? 'ادخل العنوان' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'الوصف'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedCategory = val),
                decoration: const InputDecoration(labelText: 'الفئة'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(_selectedDate != null
                      ? 'التاريخ: ${_selectedDate!.toLocal()}'.split(' ')[0]
                      : 'اختر التاريخ'),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: _pickDate,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _saveTask, child: const Text('حفظ')),
            ],
          ),
        ),
      ),
    );
  }
}
