import 'package:chat_box/data/models/contact_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'contacts_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE contacts (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,imagePath BLOB )',
        );
      },
    );
  }

  Future<void> insertContact(ContactModel contact) async {
    final db = await database;
    await db.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ContactModel>> getContacts() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('contacts');
  return List.generate(maps.length, (i) {
    return ContactModel(
      name: maps[i]['name'],
      imagePath: maps[i]['imagePath'],
    );
  }
  );
}
}
