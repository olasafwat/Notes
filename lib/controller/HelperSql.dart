import 'package:notes_app/model/NotesModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';

class HelperSql {
  static Database? _db;

  static Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }

  static initialDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "Notess.db");
    var mydb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return mydb;
  }

  static _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Notes(ID INTEGER PRIMARY KEY,Description TEXT NOT NULL,Title TEXT NOT NULL,Date TEXT NOT NULL)');
  }

  static insertDB(Map<String, dynamic> data) async {
    Database? db_Client = await db;
    var result = await db_Client!.insert("Notes", data);
    print(result);
    return result;
  }

  static deleteDB(int ID) async {
    Database? db_Client = await db;
    var result = await db_Client!.rawUpdate("DELETE FROM Notes WHERE ID = $ID");
    print(result);
    return result;
  }

  static updateDB(int ID, String Title) async {
    Database? db_Client = await db;
    var result =
    await db_Client?.rawUpdate(
        "Update Notes SET Title = $Title Where ID = $ID");
    print(result);
    return result;
  }

  static getsinglerowDB(int ID, String Title) async {
    Database? db_Client = await db;
    var result = await db_Client!.query("Notes", where: "ID = $ID");
    print(result);
    return result;
  }

  static getallrowDB() async {
    List<NotesModel> noteList = [];
    Database? db_Client = await db;
    var result = await db_Client!.query("Notes");

    for (var i in result) {
      noteList.add(NotesModel(ID: i["ID"],
          Description: i["Description"],
          Title: i["Title"],
          Date: i["Date"]));
    }
    print(noteList);
    return noteList;
  }
}
