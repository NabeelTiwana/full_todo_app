//db_handler
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/todo_model.dart';

class DBHandler {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'todo.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
  CREATE TABLE ToDoTable(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    description TEXT,
    checkbox INTEGER  
  )
''');
      },
    );

    return _database;
  }

  // insert data
  insert(TodoModel todoModel) async {
    Database? db = await database;
    db!.insert('ToDoTable', todoModel.toMap());
  }

  // read data
  Future<List<TodoModel>> read() async {
    Database? db = await database;
    List<Map<String, Object?>> list = await db!.query('ToDoTable');
    return list.map((map) => TodoModel.fromMap(map)).toList();
  }

  //delete data
  delete(int id) async {
    Database? db = await database;
    await db!.delete('ToDoTable', where: 'id = ?', whereArgs: [id]);
  }

  //upadte
  update(Map<String, dynamic> dataRow) async {
    Database? db = await database;
    int id = dataRow['id'];
    await db!.update('ToDoTable', dataRow, where: 'id =?', whereArgs: [id]);
  }
  Future<List<TodoModel>>searchItems(String query)async{
    Database? db = await database;
    List<Map<String,dynamic>>maps=await db!.query(
      'TodoTable',
      where: 'title LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'title ASC'
    );
    return maps.map((map)=>TodoModel.fromMap(map)).toList();
  }
}
