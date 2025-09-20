import 'package:database/db/queries/queries.dart';

class CoreQueries extends Queries {
  static CoreQueries? _instance;
  CoreQueries._internal();

  factory CoreQueries() {
    _instance ??= CoreQueries._internal();

    if (_instance?.db == null) {
      _instance?.loadDb();
    }

    return _instance ?? CoreQueries._internal();
  }

}
