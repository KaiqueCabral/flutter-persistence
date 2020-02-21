// Open the database and store the reference.
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Connections {
  static Future<Database> database() async => openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        join(await getDatabasesPath(), 'dogs.db'),
        // When the database is first created, create a table to store dogs.
        onCreate: (db, version) {
          String script =
              "CREATE TABLE dogs (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER);";
          return db.execute(script);
        },
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        version: 1,
      );
}
