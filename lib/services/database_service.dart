import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:workshops_booking/models/bookings.dart';
import 'package:workshops_booking/models/search_model.dart';
import 'package:workshops_booking/models/workshops.dart';
import 'package:workshops_booking/models/locations.dart';
import 'package:workshops_booking/models/instructors.dart';
import 'package:workshops_booking/models/sessions.dart';
import 'package:workshops_booking/models/users.dart';

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
          FOREIGN KEY($_workshopWidColumnName) REFERENCES $_workshopTableName($_workshopWidColumnName) ON DELETE CASCADE,
          FOREIGN KEY($_locationLidColumnName) REFERENCES $_locationTableName($_locationLidColumnName) ON DELETE CASCADE,
          FOREIGN KEY($_instructorIidColumnName) REFERENCES $_instructorTableName($_instructorIidColumnName) ON DELETE CASCADE
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
          FOREIGN KEY($_userIdColumnName) REFERENCES $_userTableName($_userIdColumnName) ON DELETE CASCADE,
          FOREIGN KEY($_sessionIdColumnName) REFERENCES $_sessionTableName($_sessionIdColumnName) ON DELETE CASCADE
      )
      ''');
      },
      onOpen: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      },
    );
    return database;
  }

  //insert data
  Future<void> addWorkshops(String wid, String wname, String wsubject) async {
    final db = await database;
    try {
      await db.insert(
        _workshopTableName,
        {
          _workshopWidColumnName: wid,
          _workshopWnameColumnName: wname,
          _workshopSubjectColumnName: wsubject
        },
        conflictAlgorithm: ConflictAlgorithm.abort, // Abort on conflict
      );
    } catch (e) {
      if (e is DatabaseException &&
          e.toString().contains('UNIQUE constraint failed')) {
        throw Exception(
            'Primary key violation: Workshop ID $wid already exists.');
      } else {
        throw Exception('Database error: $e');
      }
    }
  }

  Future<void> addLocation(String lid, String lname, int capacity) async {
    final db = await database;
    try {
      await db.insert(
        _locationTableName,
        {
          _locationLidColumnName: lid,
          _locationLnameColumnName: lname,
          _locationCapacityColumnName: capacity
        },
        conflictAlgorithm: ConflictAlgorithm.abort, // Abort on conflict
      );
    } catch (e) {
      if (e is DatabaseException &&
          e.toString().contains('UNIQUE constraint failed')) {
        throw Exception(
            'Primary key violation: Location ID $lid already exists.');
      } else {
        throw Exception('Database error: $e');
      }
    }
  }

  Future<void> addInstructor(
      String iid, String iname, String gender, int age) async {
    final db = await database;
    try {
      final existingInstructor = await db.rawQuery(
          'SELECT * FROM $_instructorTableName WHERE $_instructorIidColumnName = ?',
          [iid]);

      if (existingInstructor.isNotEmpty) {
        throw Exception('Instructor with ID $iid already exists.');
      }

      await db.insert(
        _instructorTableName,
        {
          _instructorIidColumnName: iid,
          _instructorInameColumnName: iname,
          _instructorGenderColumnName: gender,
          _instructorAgeColumnName: age
        },
        conflictAlgorithm: ConflictAlgorithm.abort, // Abort on conflict
      );
    } catch (e) {
      if (e is DatabaseException &&
          e.toString().contains('UNIQUE constraint failed')) {
        throw Exception(
            'Primary key violation: Instructor ID $iid already exists.');
      } else {
        throw Exception('Database error: $e');
      }
    }
  }

  Future<void> addSession(String sid, String wid, String lid, String iid,
      String date, String startTime, String endTime) async {
    final db = await database;
    try {
      await db.insert(
        _sessionTableName,
        {
          _sessionIdColumnName: sid,
          _workshopWidColumnName: wid,
          _locationLidColumnName: lid,
          _instructorIidColumnName: iid,
          _sessionDateColumnName: date,
          _sessionStartColumnName: startTime,
          _sessionEndColumnName: endTime,
        },
        conflictAlgorithm: ConflictAlgorithm.abort, // Abort on conflict
      );
    } catch (e) {
      if (e is DatabaseException &&
          e.toString().contains('UNIQUE constraint failed')) {
        throw Exception(
            'Primary key violation: Session ID $sid already exists.');
      } else {
        throw Exception('Database error: $e');
      }
    }
  }

  Future<void> addUser(String uid, String uname, String password) async {
    final db = await database;
    try {
      await db.insert(
        _userTableName,
        {
          _userIdColumnName: uid,
          _userNameColumnName: uname,
          _userPasswordColumnName: password,
        },
        conflictAlgorithm: ConflictAlgorithm.abort, // Abort on conflict
      );
    } catch (e) {
      if (e is DatabaseException &&
          e.toString().contains('UNIQUE constraint failed')) {
        throw Exception('Primary key violation: User ID $uid already exists.');
      } else {
        throw Exception('Database error: $e');
      }
    }
  }

  Future<void> addBooking(String bid, String sid, String uid) async {
    final db = await database;
    try {
      // Check if a booking with the same user and session already exists using rawQuery
      final existingBooking = await db.rawQuery('''
      SELECT * FROM $_bookingTableName 
      WHERE $_userIdColumnName = ? 
      AND $_sessionIdColumnName = ?
      ''', [uid, sid]);

      if (existingBooking.isNotEmpty) {
        throw Exception(
            'A booking already exists for user ID $uid and session ID $sid.');
      }

      // If no existing booking is found, insert the new booking
      await db.insert(
        _bookingTableName,
        {
          _bookingIdColumnName: bid,
          _sessionIdColumnName: sid,
          _userIdColumnName: uid,
        },
        conflictAlgorithm: ConflictAlgorithm.abort, // Abort on conflict
      );
    } catch (e) {
      if (e is DatabaseException &&
          e.toString().contains('UNIQUE constraint failed')) {
        throw Exception(
            'Primary key violation: Booking ID $bid already exists.');
      } else {
        throw Exception('Database error: $e');
      }
    }
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

  Future<List<Sessions>> getSessions() async {
    final db = await database;
    final data = await db.query(_sessionTableName);

    List<Sessions> sessions = data
        .map(
          (e) => Sessions(
            sid: e[_sessionIdColumnName] as String,
            wid: e[_workshopWidColumnName] as String,
            lid: e[_locationLidColumnName] as String,
            iid: e[_instructorIidColumnName] as String,
            date: e[_sessionDateColumnName] as String,
            startTime: e[_sessionStartColumnName] as String,
            endTime: e[_sessionEndColumnName] as String,
          ),
        )
        .toList();
    return sessions;
  }

  //user details
  Future<List<Users>> getUsers() async {
    final db = await database;
    final data = await db.query(
      _userTableName,
      columns: [_userIdColumnName, _userNameColumnName],
    );

    List<Users> users = data
        .map((e) => Users(
              uid: e[_userIdColumnName] as String,
              uname: e[_userNameColumnName] as String,
            ))
        .toList();

    return users;
  }

  Future<List<Bookings>> getBookings() async {
  final db = await database;
  final data = await db.query(_bookingTableName);

  List<Bookings> bookings = data
      .map(
        (e) => Bookings(
          bid: e[_bookingIdColumnName] as String,
          sessionId: e[_sessionIdColumnName] as String,
          userId: e[_userIdColumnName] as String,
        ),
      )
      .toList();
  return bookings;
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

  void deleteSession(String id) async {
    final db = await database;
    await db.rawDelete(
        '''DELETE FROM $_sessionTableName WHERE $_sessionIdColumnName = '$id' ''');
  }

  void deleteBooking(String bookingId) async {
    final db = await database;
    try {
      int result = await db.rawDelete(
        '''DELETE FROM $_bookingTableName WHERE $_bookingIdColumnName = ?''',
        [bookingId],
      );

      if (result == 0) {
        throw Exception('Booking with ID $bookingId does not exist.');
      }
    } catch (e) {
      throw Exception('Database error while deleting booking: $e');
    }
  }

  //user login
  Future<int> userLogin(String uid, String password) async {
    final db = await database;

    final result = await db.rawQuery(
      '''SELECT * FROM $_userTableName WHERE $_userIdColumnName = ? AND $_userPasswordColumnName = ?''',
      [uid, password],
    );

    if (result.isNotEmpty) {
      return 1;
    } else {
      return 0;
    }
  }

  //search for sessions
  Future<List<SessionDetails>> searchSession(
      String workshopSubject, String sessionDate) async {
    final db = await database;

    final data = await db.rawQuery('''
    SELECT 
      s.$_sessionIdColumnName AS sessionId, 
      w.$_workshopWnameColumnName AS workshopName, 
      i.$_instructorInameColumnName AS instructorName,
      s.$_sessionStartColumnName AS startTime,
      s.$_sessionEndColumnName AS endTime
    FROM 
      $_sessionTableName s
    JOIN 
      $_workshopTableName w ON s.$_workshopWidColumnName = w.$_workshopWidColumnName
    JOIN 
      $_instructorTableName i ON s.$_instructorIidColumnName = i.$_instructorIidColumnName
    WHERE 
      s.$_sessionDateColumnName = ? 
      AND w.$_workshopSubjectColumnName = ?
  ''', [sessionDate, workshopSubject]);

    // print(sessionDate+workshopSubject);
    // print(data);

    List<SessionDetails> sessionDetails = data
        .map(
          (e) => SessionDetails(
            sessionId: e['sessionId'] as String,
            workshopName: e['workshopName'] as String,
            instructorName: e['instructorName'] as String,
            startTime: e['startTime'] as String,
            endTime: e['endTime'] as String,
          ),
        )
        .toList();

    return sessionDetails;
  }

  //check if booking is present
  Future<bool> checkBookingExists(String sessionId, String userId) async {
    final db = await database;

    final result = await db.rawQuery('''
    SELECT * FROM $_bookingTableName 
    WHERE $_sessionIdColumnName = ? 
    AND $_userIdColumnName = ?
  ''', [sessionId, userId]);

    return result.isNotEmpty;
  }
}
