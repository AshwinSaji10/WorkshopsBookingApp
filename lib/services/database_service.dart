import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:workshops_booking/models/workshops.dart';

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
      version: 1,
      onCreate: (db, version) {
        db.execute('''
      CREATE TABLE $_workshopTableName(
          $_workshopWidColumnName TEXT PRIMARY KEY,
          $_workshopWnameColumnName TEXT NOT NULL,
          $_workshopSubjectColumnName TEXT NOT NULL
      )
      ''');
      },
    );
    return database;
  }

  void addWorkshops(String wid, String wname, String wsubject) async {
    final db = await database;
    await db.insert(
      _workshopTableName,
      {
        _workshopWidColumnName: wid,
        _workshopWnameColumnName: wname,
        _workshopSubjectColumnName: wsubject
      },
    );
  }

  Future<List<Workshops>> getWorkshops() async {
    final db = await database;
    final data = await db.query(_workshopTableName);

    List<Workshops> workshops = data
        .map(
          (e) => Workshops(
              wid: e[_workshopWidColumnName] as String,
              wname: e[_workshopWnameColumnName] as String,
              wsubject: e[_workshopSubjectColumnName] as String),
        )
        .toList();
    return workshops;
  }
}
