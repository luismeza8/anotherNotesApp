import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, description TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertNote(Notes notes) async {
    Database _db = await database();
    await _db.insert(
      'notes',
      notes.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteNote(Notes note) async {
    Database _db = await database();
    await _db.rawDelete('DELETE FROM notes WHERE id = ${note.id}');
  }

  Future<List<Notes>> getNotes() async {
    Database _db = await database();
    List<Map<String, dynamic>> noteMap = await _db.query('notes');

    return List.generate(
      noteMap.length,
      (index) {
        return Notes(
          id: noteMap[index]['id'],
          title: noteMap[index]['title'],
          description: noteMap[index]['description'],
        );
      },
    );
  }
}
