import 'package:medicine_reminder/Model/registermodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class RegisterDbhelper {
  static Database? _database;
  static const String dbName = 'register.db';
  static const String tableName = 'register';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, dbName);
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            firstname TEXT,
            lastname TEXT,
            ProfileImage TEXT,
            email TEXT,
            phonenumber TEXT,
            password TEXT,
            confirmpassword TEXT,
            key TEXT 
          )
        ''');
      },
    );
  }

  static Future<int> insertRegister(RegisterModel register) async {
    final db = await database;
    return await db.insert(tableName, register.toMap());
  }

 

  static Future<RegisterModel?> fetchRegisterByEmail(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> register =
        await db.query(tableName, where: 'email = ?', whereArgs: [email]);
    if (register.isNotEmpty) {
      return RegisterModel.fromMap(register.first);
    } else {
      return null; // Return null if no records are found
    }
  }

  static Future<Map<String, dynamic>> fetchRegisterByEmailAndPassword(
      String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> register = await db.query(tableName,
        where: 'email = ? AND password = ?', whereArgs: [email, password]);
    if (register.isEmpty) {
      print(
          'No matching record found for email: $email and password: $password');
      return {};
    } else {
      print('Login successful for email: $email');
      return {'key': register.first['key']};
    }
  }

//fetch user details by key
  static Future<RegisterModel?> fetchRegisterByKey(String key) async {
    final db = await database;
    final List<Map<String, dynamic>> register =
        await db.query(tableName, where: 'key = ?', whereArgs: [key]);
    if (register.isEmpty) {
      print('No record found for key: $key');
      return null; // Return null to indicate no record found
    } else {
      return RegisterModel.fromMap(register.first);
    }
  }

  //update user details by key
  static Future<int> updateRegister(RegisterModel register) async {
    final db = await database;
    return await db.update(tableName, register.toMap(),
        where: 'key = ?', whereArgs: [register.key]);
  }

  //udpate register table by email
  static Future<int> updateRegisterByEmail(RegisterModel register) async {
    final db = await database;

    return await db.update(tableName, register.toMap(),
        where: 'email = ?', whereArgs: [register.email], 
        conflictAlgorithm: ConflictAlgorithm.replace,
        );
  }
  //update register table using email
}
