import 'package:flutter/material.dart';
import 'package:medicine_reminder/Model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper  {

  static Database? _database;
  
  static const String dbName = 'medicine.db';
  static const String tableName = 'medicines';


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
            name TEXT,
            TotalDose INTEGER,
            dose INTEGER,
            type TEXT,
            startDate TEXT,
            endDate TEXT,
            time TEXT,
            Remind INTEGER,
            Repeat TEXT,
            keys TEXT
          )
        ''');
      },
    );
  }

  static Future<int> insertMedicine(Medicine medicine) async {
    final db = await database;
    return await db.insert(tableName, medicine.toMap());
  }

  static Future<List<Medicine>> fetchMedicines() async {
    final db = await database;
    final List<Map<String, dynamic>> medicines = await db.query(tableName);
    return List.generate(medicines.length, (index) {
      print('DB Medicine List ${Medicine.fromMap(medicines[index])} ');
      return Medicine.fromMap(medicines[index]);
    });
  }

//update the medicine 
static Future<int> updateMedicine(Medicine medicine) async {
  final db = await database;
  return await db.update(
    tableName,
    medicine.toMap(),
    where: 'keys = ?',
    whereArgs: [medicine.keys],
    // Exclude 'id' from the update query
    // id will be used in the WHERE clause for identification, but not in the SET clause
    // The 'id' column should be automatically managed by SQLite (auto-incremented)
    conflictAlgorithm: ConflictAlgorithm.replace, // Use ConflictAlgorithm.replace to handle primary key conflicts
  );
}
//delete 
static Future<int> deleteMedicine(Medicine medicine) async {
  final db = await database;
  return await db.delete(
    tableName,
    where: 'id = ?', // assuming id is the unique identifier
    whereArgs: [medicine.id],
  );
}



}
