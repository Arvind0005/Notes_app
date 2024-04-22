import 'package:sample_project/Data/Encrypt.dart';
import 'package:sqflite/sqflite.dart';
import 'package:encrypt/encrypt.dart';

class DatabaseHelper {
  static const String _databaseName = 'notes.db';
  static const int _databaseVersion = 1;
  EncryptionData _encryptionData = EncryptionData();

  Database? _database;

  // String _decryptData(String encryptedData) {
  //   final encrypter = Encrypter(AES(_encryptionKey));
  //   final decrypted = encrypter.decrypt(encryptedData, iv: iv);
  //   return decrypted;
  // }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<int> updateNote(
      int id, String title, String tag, String content) async {
    final db = await database;
    return await db.update(
      'Notes',
      {'title': title, 'tag': tag, 'content': content},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/$_databaseName';
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (db, version) {
      db.execute('''
        CREATE TABLE Notes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          tag TEXT,
          content TEXT NOT NULL
        )
      ''');
    });
  }

  Future<void> insertNote(String title, String tag, String content) async {
    final db = await database;
    await db.insert('Notes', {'title': title, 'tag': tag, 'content': content});
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete('Notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await database;
    print("udcgbgyvdcgvscvsdvdfv");
    List<Map<String, dynamic>> s = await db.query('Notes');
    print(s);
    return await db.query('Notes');
  }

  // Function to retrieve a specific note by id
  Future<Map<String, dynamic>?> getNoteById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Notes',
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? maps.first : null;
  }
}
