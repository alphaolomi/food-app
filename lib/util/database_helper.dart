import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_app/model/record.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableRecord = 'recordTable';
  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnDescription = 'description';

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'records.db');

    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableRecord($columnId INTEGER PRIMARY KEY, $columnTitle TEXT, $columnDescription TEXT)');
  }

  Future<int> saveRecord(Record record) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableRecord, record.toMap());
    return result;
  }

  Future<List> getAllRecords() async {
    var dbClient = await db;
    var result = await dbClient.query(tableRecord, columns: [columnId, columnTitle, columnDescription]);
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableRecord'));
  }

  Future<Record> getRecord(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableRecord,
        columns: [columnId, columnTitle, columnDescription],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (result.length > 0) {
      return new Record.fromMap(result.first);
    }
    return null;
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}