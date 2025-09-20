
import 'package:database/db/queries/core_queries.dart';
import 'db/db.dart';

/*
Author: Nagaraju.lj
Date: April,2024.
type: Utility
Description: Initializing the dependency classes for the first time, called from main widget
 */
class DbUtils {
  static Future<void> init() async {
    await DatabaseHelper()
        .database; // Initializing the database - call only on app open
    CoreQueries(); // singleton core queries, holds the db reference
  }
}
