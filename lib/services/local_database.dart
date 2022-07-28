import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../models/task.dart';
import '../utils/shared/CacheHelper.dart';
class CacheService {

  static Database? _db;

   String tasksTable = 'tasksTable';
  String responseTable = 'responses';




  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }

  initialDB() async {
    io.Directory docDirect = await getApplicationDocumentsDirectory();
    String path = join(docDirect.path, 'Tasks.db');

    var mydb = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE "$tasksTable"( "id" INTEGER PRIMARY KEY ,"title" Text NOT NULL,"startTime" Text NOT NULL,"endTime" Text NOT NULL,"date" Text NOT NULL,"remind" Text NOT NULL,"repeat" Text NOT NULL,"isCompleted" Text NOT NULL,"isFav" Text NOT NULL )');
          //UNIQUE PRIMARY KEY
        });
     return mydb;
  }



  Future<void> addTask(TaskModel taskModel) async {
    int id=CacheHelper.getData(key: "id") ?? 1;
    print(id);
    _db ??= await db;
    return await _db!
        .rawInsert(
        'INSERT INTO $tasksTable(id,title,startTime,endTime,date,remind,repeat,isCompleted,isFav) VALUES($id,"${taskModel.title}","${taskModel.startTime}","${taskModel.endTime}","${taskModel.date}","${taskModel.remind}","${taskModel.repeat}","${taskModel.isCompleted}","${taskModel.isFav}")')
      .then((value) {
      CacheHelper.saveData(value: id+1,key: "id");
    })
        .catchError((e) {
      print("Error When Inserting New Record ${e.toString()}");
    });
  }

  Future<List<Map>> getAllTasks() async {
   _db ??= await db;
    return await _db!
        .rawQuery('SELECT * FROM $tasksTable ');
  }

  Future<List<Map>> getSpecificTasks(String attribute,String value) async {
   _db ??= await db;
    return await _db!
        .rawQuery('SELECT * FROM $tasksTable where $attribute like ?',[value]);
  }

  Future<int?> deleteTask({required int id}) async {
    Database? database = await db;
    int query =
    await database!.rawDelete('DELETE FROM $tasksTable where id = ?', [id]);
    return query;
  }

  Future<void>  updateTask({
    required String attribute,required String value,required int id
  }) async {
    if (kDebugMode) {
      print("try update");
    }
    _db!.rawUpdate(
        'UPDATE $tasksTable SET $attribute = ? WHERE id = ?',
        [
           value,id
        ]);
  }





 
}
