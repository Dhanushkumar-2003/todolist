import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _database;

  // DatabaseHelper() {
  //   initDatabase();
  // }

  Future<void> initDatabase() async {
    if (_database != null) return;

    _database = await openDatabase(
      join(await getDatabasesPath(), 'tasks.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE note(id INTEGER PRIMARY KEY AUTOINCREMENT, mm TEXT, descrip TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertTask(note note) async {
    await initDatabase();

    return await _database!.insert('note', note.toMap());
  }

  Future<int> updatenote(note note) async {
    print("upda");
    return await _database!.update(
      'note',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.mm],
    );
  }

  Future<void> deletenot(int id) async {
    // Get a reference to the database.
    // ignore: await_only_futures
    final db = await _database;

    await db?.delete(
      'note',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List> getTasks() async {
    await initDatabase();
    final List<Map<String, dynamic>> maps = await _database!.query('note');
    return List.generate(maps.length, (i) {
      return note(
          id: maps[i]['id'], mm: maps[i]['mm'], descrip: maps[i]['descrip']);
    });
  }
}

// ignore: camel_case_types
class note {
  String mm;
  int id;
  String descrip;
  note({
    required this.mm,
    required this.id,
    required this.descrip,
  });
  Map<String, dynamic> toMap() {
    // ignore: pre

    var map = <String, dynamic>{};

    map['descrip'] = descrip;
    map['mm'] = mm;
    map['id'] = id;

    return map;
  }
}
