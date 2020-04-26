import 'package:path/path.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'main.dart';
import 'package:async/async.dart';

class Rent{
//  Rent({this.rentNo,this.name});
  int rentNo;
  String name;
  static final db = Rent();

  static Database _database;
  Future<Database> get database async{
    if(_database!=null)
      return _database;
    _database = await initDB();
    return _database;
  }
  initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,"TestDB.db");
    return await openDatabase(path,version: 1,onOpen: (db){},onCreate: (Database db, int version) async{
      await db.execute("CREATE TABLE Rental("
          "rent INTEGER PRIMARY KEY,"
          "name TEXT"
      ")");
    });
  }
}