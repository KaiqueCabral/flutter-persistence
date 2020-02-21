import 'package:flutter_persistence/controller/dogs.dart';
import 'package:flutter_persistence/models/connections.dart';
import 'package:sqflite/sqflite.dart';

class DogsModel {
  Future<void> insertDog(Dogs dog) async {
    // Get a reference to the database.
    final Database db = await Connections.database();

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Dogs>> dogs() async {
    // Get a reference to the database.
    final Database db = await Connections.database();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('dogs');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Dogs(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

  Future<Dogs> dogsDetails(int id) async {
    // Get a reference to the database.
    final Database db = await Connections.database();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(
      "Dogs",
      columns: ["id", "name", "age"],
      where: 'id = ?',
      whereArgs: [id],
    );

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return Dogs(
      id: maps.first['id'],
      name: maps.first['name'],
      age: maps.first['age'],
    );
  }

  Future<void> updateDog(Dogs dog) async {
    // Get a reference to the database.
    final db = await Connections.database();

    // Update the given Dog.
    await db.update(
      'dogs',
      dog.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }

  Future<void> deleteDog(int id) async {
    // Get a reference to the database.
    final db = await Connections.database();

    // Remove the Dog from the database.
    await db.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
