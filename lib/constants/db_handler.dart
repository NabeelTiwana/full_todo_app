import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/todo_model.dart';

class DBHandler {
  Database? _database;

  //Create db
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'todo.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
         CREATE TABLE ToDoTable(
         id INTEGER PRIMARY KEY,
         title TEXT ,
         description TEXT,
         checkbox INTEGER,
         
         )
         ''');
      },
    );
    return _database;
  }

  //inset the data into table
  insert(TodoModel todoModel) async {
    Database? db = await database;
    final value = todoModel.toMap();
    db!.insert('ToDoTable', value);
  }
  //read Data
 Future<List<TodoModel>>read()async{
   Database? db = await database;
   List<Map<String,Object?>>list=await db!.query('TodoTable');
   return list.map((map)=>TodoModel.fromMap(map)).toList();
 }
}
