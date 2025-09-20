import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:utilities/utils.dart';
import '../db.dart';

/*
Author: Nagaraju.lj
Date: May,2024.
Description: super class for all queries related classes
 */

abstract class Queries {
  Database? _db;

  Future<void> loadDb() async {
    _db = await DatabaseHelper().database;
  }

  Future<void> insertData(String table, Map<String, Object?> values) async {
    try {
      //Utils.print("db! insertData - $table -- inserting values");
      await db?.insert(
        table,
        values,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e,stackTrace) {
      Utils.printCrashError("${e.toString()} \n ${values}",stacktrace: stackTrace);
    }
  }

  Database? get db {
    return _db;
  }
}
