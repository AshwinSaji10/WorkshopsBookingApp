import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:workshops_booking/models/workshops.dart';
import 'package:workshops_booking/models/locations.dart';
import 'package:workshops_booking/models/instructors.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  //workshops table
  final String _workshopTableName = "workshops";
  final String _workshopWidColumnName = "w_id";
  final String _workshopWnameColumnName = "w_name";
  final String _workshopSubjectColumnName = "w_subject";

  //locations table
  final String _locationTableName = "locations";
  final String _locationLidColumnName = "l_id";
  final String _locationLnameColumnName = "l_name";
  final String _locationCapacityColumnName = "l_capacity";

  //instructors table
  final String _instructorTableName = "instructors";
  final String _instructorIidColumnName = "i_id";
  final String _instructorInameColumnName = "i_name";
  final String _instructorGenderColumnName = "gender";
  final String _instructorAgeColumnName = "age";

  //sessions table
  final String _sessionTableName = "sessions";
  final String _sessionIdColumnName = "s_id";
  final String _sessionDateColumnName = "date";
  final String _sessionStartColumnName = "start_time";
  final String _sessionEndColumnName = "end_time";

  //users table
  final String _userTableName = "users";
  final String _userIdColumnName = "u_id";
  final String _userNameColumnName = "u_name";
  final String _userPasswordColumnName = 'u_password';

  //bookings table
  final String _bookingTableName = "bookings";
  final String _bookingIdColumnName = "b_id";

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
        //workshops table
        db.execute('''
      CREATE TABLE $_workshopTableName(
          $_workshopWidColumnName TEXT PRIMARY KEY,
          $_workshopWnameColumnName TEXT NOT NULL,
          $_workshopSubjectColumnName TEXT NOT NULL
      )
      ''');
        //locations table
        db.execute('''
      CREATE TABLE $_locationTableName(
          $_locationLidColumnName TEXT PRIMARY KEY,
          $_locationLnameColumnName TEXT NOT NULL,
          $_locationCapacityColumnName INTEGER NOT NULL
      )
      ''');
        //instructors table
        db.execute('''
      CREATE TABLE $_instructorTableName(
        $_instructorIidColumnName TEXT PRIMARY KEY,
        $_instructorInameColumnName TEXT NOT NULL,
        $_instructorGenderColumnName TEXT NOT NULL,
        $_instructorAgeColumnName INTEGER NOT NULL
      )
      ''');

        //sessions table
        db.execute('''
      CREATE TABLE $_sessionTableName(
          $_sessionIdColumnName TEXT PRIMARY KEY,
          $_workshopWidColumnName TEXT NOT NULL,
          $_locationLidColumnName TEXT NOT NULL,
          $_instructorIidColumnName TEXT NOT NULL,
          $_sessionDateColumnName TEXT NOT NULL,
          $_sessionStartColumnName TEXT NOT NULL,
          $_sessionEndColumnName TEXT NOT NULL,
          FOREIGN KEY($_workshopWidColumnName) REFERENCES $_workshopTableName($_workshopWidColumnName),
          FOREIGN KEY($_locationLidColumnName) REFERENCES $_locationTableName($_locationLidColumnName),
          FOREIGN KEY($_instructorIidColumnName) REFERENCES $_instructorTableName($_instructorIidColumnName)
      )
      ''');
        db.execute('''
        CREATE TABLE $_userTableName(
          $_userIdColumnName TEXT PRIMARY KEY,      
          $_userNameColumnName TEXT NOT NULL,       
          $_userPasswordColumnName TEXT NOT NULL   
        )
      ''');

        //bookings table
        db.execute('''
      CREATE TABLE $_bookingTableName(
          $_bookingIdColumnName TEXT PRIMARY KEY,
          $_userIdColumnName TEXT NOT NULL,
          $_sessionIdColumnName TEXT NOT NULL,
          FOREIGN KEY($_userIdColumnName) REFERENCES $_userTableName($_userIdColumnName),
          FOREIGN KEY($_sessionIdColumnName) REFERENCES $_sessionTableName($_sessionIdColumnName)
      )
      ''');
      },
    );
    return database;
  }

  //insert data
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

  void addLocation(String lid, String lname, int capacity) async {
    final db = await database;
    await db.insert(
      _locationTableName,
      {
        _locationLidColumnName: lid,
        _locationLnameColumnName: lname,
        _locationCapacityColumnName: capacity
      },
    );
  }

  void addInstructor(String iid, String iname, String gender, int age) async {
    final db = await database;
    await db.insert(
      _instructorTableName,
      {
        _instructorIidColumnName: iid,
        _instructorInameColumnName: iname,
        _instructorGenderColumnName: gender,
        _instructorAgeColumnName: age
      },
    );
  }

  //display
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

  Future<List<Locations>> getLocations() async {
    final db = await database;
    final data = await db.query(_locationTableName);

    List<Locations> locations = data
        .map(
          (e) => Locations(
              lid: e[_locationLidColumnName] as String,
              lname: e[_locationLnameColumnName] as String,
              capacity: e[_locationCapacityColumnName] as int),
        )
        .toList();
    return locations;
  }

  Future<List<Instructors>> getInstructors() async {
    final db = await database;
    final data = await db.query(_instructorTableName);

    List<Instructors> instructors = data
        .map(
          (e) => Instructors(
            iid: e[_instructorIidColumnName] as String,
            iname: e[_instructorInameColumnName] as String,
            gender: e[_instructorGenderColumnName] as String,
            age: e[_instructorAgeColumnName] as int,
          ),
        )
        .toList();
    return instructors;
  }

//delete
  void deleteWorkshops(String id) async {
    final db = await database;
    await db.rawDelete(
        '''DELETE FROM $_workshopTableName WHERE $_workshopWidColumnName='$id' ''');
  }

  void deleteLocation(String id) async {
    final db = await database;
    await db.rawDelete(
        '''DELETE FROM $_locationTableName WHERE $_locationLidColumnName='$id' ''');
  }

  void deleteInstructor(String id) async {
    final db = await database;
    await db.rawDelete(
        '''DELETE FROM $_instructorTableName WHERE $_instructorIidColumnName='$id' ''');
  }
}
