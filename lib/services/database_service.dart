import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _workshopTableName = "workshops";
  final String _workshopWidColumnName = "w_id";
  final String _workshopWnameColumnName = "w_name";
  final String _workshopSubjectColumnName = "w_subject";

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }

    _db = await getDatabase();

    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirpath = await getDatabasesPath();
    final databasePath = join(databaseDirpath, "master.db");
    final database = await openDatabase(
      databasePath,
      onCreate: (db, version) {
        db.execute('''
      CREATE TABLE $_workshopTableName(
          $_workshopWidColumnName TEXT PRIMARY KEY,
          $_workshopWnameColumnName TEXT NOT NULL,
          $_workshopSubjectColumnName TEXT NOT NULL,

      )
      ''');
      },
    );
    return database;
  }

  // void addTask(String content) async{
  //   final db=await database;
  //   await db.insert(_workshopTableName, {
  //     _workshopWidColumnName:content,
  //   })
  // }
}
