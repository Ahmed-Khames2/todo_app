import 'package:sqflite/sqflite.dart';
import 'package:todo_app/core/data/app_database.dart';
import 'package:todo_app/core/data/model/task_model.dart';
class TaskRepository {
  // إضافة مهمة جديدة
  Future<int> addTask(TaskModel task) async {
    final db = await AppDatabase.database;
    return await db.insert(
      'tasks',
      task.toMap(), // كده يشمل createdAt و scheduledTime لو موجود
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // get كل المهام
  Future<List<TaskModel>> getTasks() async {
    final db = await AppDatabase.database;
    final result = await db.query('tasks', orderBy: 'createdAt DESC');
    return result.map((e) => TaskModel.fromMap(e)).toList();
  }

  // تحديث مهمة
  Future<int> updateTask(TaskModel task) async {
    final db = await AppDatabase.database;
    return await db.update(
      'tasks',
      task.toMap(), // يشمل scheduledTime
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // حذف مهمة
  Future<int> deleteTask(int id) async {
    final db = await AppDatabase.database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // حذف كل المهام 
  Future<int> deleteAllTasks() async {
    final db = await AppDatabase.database;
    return await db.delete('tasks');
  }
}
