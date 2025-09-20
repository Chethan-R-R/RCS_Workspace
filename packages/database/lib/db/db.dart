import 'dart:io';

import 'package:database/db/tables.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:utilities/utils.dart';


class DatabaseHelper {
/*Singleton DatabaseHelper*/
  static DatabaseHelper? _databaseHelper;

  /*Singleton database*/
  static Database? _database;

/*Named constructor to create instance of databaseHelper*/
  DatabaseHelper._createInstance();

  static Future close() async => _database?.close();

  Future<Database?> get database async {
    _database ??= await _open();
    return _database;
  }

  factory DatabaseHelper() {
    return _databaseHelper ??= DatabaseHelper._createInstance();
  }

  Future<Database> _open() async {
    String path = await _initDb(Tables.rscDatabase);
    var db = await openDatabase(
      path,
      password: "Rcs@123",
      version: 6,
      onCreate: _createDb,
      onUpgrade: (db, oldVersion, newVersion) async {
        for (var version = oldVersion + 1; version <= newVersion; version++) {
          switch (version) {

          }
        }
      },
    );
    return db;
  }

  static Future<String> _initDb(String dbName) async {
    var databasePath = await getDatabasesPath();
    String path = p.join(databasePath, dbName);
    if (await Directory(p.dirname(path)).exists()) {
    } else {
      try {
        await Directory(p.dirname(path)).create(recursive: true);
      } catch (e, stackTrace) {
        Utils.printCrashError(e.toString(), stacktrace: stackTrace);
      }
    }
    return path;
  }

  void _createDb(Database db, int newVersion) async {

  }

}
