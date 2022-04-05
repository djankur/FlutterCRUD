import 'package:sqflite/sqflite.dart';
//import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as p;
import 'package:store_data/model_user.dart';

final String tableUser = 'table_user'; //tableName
final String Id = 'id'; //the name should be same as model.dart variable
final String Email = 'email';
final String Phone = 'phone';

class DatabaseUser {
  static Database? _database; //it will do CURD operation
  static DatabaseUser? databaseUser;

  DatabaseUser._createInstance();

  factory DatabaseUser() {
    if (databaseUser == null) {
      databaseUser = DatabaseUser._createInstance();
    }
    return databaseUser!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    try {
      var databasePath = await getDatabasesPath();
      String path = p.join(databasePath, 'database_user.db');

      var database =
          await openDatabase(path, version: 1, onCreate: (db, version) {
        db.execute('''
            create table $tableUser(
           $Id INTEGER PRIMARY KEY AUTOINCREMENT,
           $Email text not null,
           $Phone text not null
          )
       ''');
      });
      print("====database : $database");
      return database;
    } catch (e) {
      //String a = e.toString();
      print("Hello Database Error : ${e.toString()}");
      // return null!;
      return database;
    }
  }

  Future<bool> AddRecord(ModelUser user_info) async {
    try {
      Database db = await this.database;
      // await db.insert(tableUser, user_info.toMap());
      var result = await db.insert(tableUser, user_info.toMap());
      print("Hello db result : ${result}");
      return true;
    } catch (e) {
      print("Hello Database Error : ${e.toString()}");
      return false;
    }
  }

  // where: 'id = ?, email = ?',
  //         whereArgs: [user_info.id, user_info.email]

  Future<bool> UpdateRecord(ModelUser user_info) async {
    try {
      var db = await this.database;
      await db.update(tableUser, user_info.toMap(),
          where: '$Id = ?', whereArgs: [user_info.id]);

      return true;
    } catch (e) {
      print("Hello Database Error : ${e.toString()}");
      return false;
    }
  }

  Future<bool> DeleteRecord(String id) async {
    try {
      var db = await this.database;
      await db.delete(tableUser, where: '$Id = ?', whereArgs: [id]);

      return true;
    } catch (e) {
      print("Hello Database Error : ${e.toString()}");
      return false;
    }
  }

  Future<List<ModelUser>> GetAllRecord() async {
    List<ModelUser> modelUserData = [];
    try {
      var db = await this.database;
      // var result = await db.query(tableUser);
      List<Map<String, dynamic>> result = await db.query(tableUser);
      if (result.length > 0) {
        for (int i = 0; i < result.length; i++) {
          // var model = ModelUser.fromMap(result[i]);
          ModelUser model = ModelUser.fromMap(result[i]);
          modelUserData.add(model);
        }
        print("sifatLog values length : ${modelUserData.length}");
        return modelUserData;
      } else {
        return modelUserData;
      }
    } catch (e) {
      print("Hello Database Error : ${e.toString()}");
      return modelUserData;
    }
  }
}
