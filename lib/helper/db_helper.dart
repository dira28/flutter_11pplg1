import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'contacts.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE contacts(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT
          )
          ''');
      },
    );
  }

  // CREATE
  Future<int> insertName(String name) async {
    final client = await db;
    return await client.insert('contacts', {'name': name});
  }

  // READ
  Future<List<Map<String, dynamic>>> getNames() async {
    final client = await db;
    return await client.query('contacts', orderBy: 'id DESC');
  }

  // UPDATE
  Future<int> updateName(int id, String newName) async {
    final client = await db;
    return await client.update(
      'contacts',
      {'name': newName},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteName(int id) async {
    final client = await db;
    return await client.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }
}
