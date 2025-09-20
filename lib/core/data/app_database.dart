import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tasks.db');

    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // ضفنا onUpgrade
    );
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        isDone INTEGER NOT NULL,
        category TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        scheduledTime TEXT
      )
    ''');
  }

 static Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
  if (oldVersion < 2) {
    await db.execute('ALTER TABLE tasks ADD COLUMN description TEXT');
  }
  if (oldVersion < 3) {
    await db.execute('ALTER TABLE tasks ADD COLUMN scheduledTime TEXT');
  }
}

}
