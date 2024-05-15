// ignore_for_file: file_names
import 'package:flutter/foundation.dart';
import 'package:recipe/database/recipe.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class RecipeDb {
  static const _dbName = 'rwe.db';
  static const _tableName = 'qeq';

  static Future<Database> _database() async {
    sqfliteFfiInit();
    final dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, _dbName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, requirements TEXT, photo TEXT,timeAtt TEXT,information TEXT,time TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert({required Recipe recipe}) async {
    try {
      final db = await _database();
      await db.insert(
        _tableName,
        recipe.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      if (kDebugMode) {
        if (kDebugMode) {
          print('Error inserting note: $error');
        }
      }
    }
  }

  static Future<List<Recipe>> getRecipe() async {
    final db = await _database();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return Recipe(
        id: maps[i]['id'] as int,
        name: maps[i]['name'] as String,
        requirements: maps[i]['requirements'] as String,
        photo: maps[i]['photo'] as String,
        timeAtt: maps[i]['timeAtt'] as String,
        information: maps[i]['information'] as String,
        time: DateTime.parse(maps[i]['time']),
      );
    });
  }

  static Future<void> delete({required Recipe recipe}) async {
    final db = await _database();
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [recipe.id],
    );
  }

  static update({required Recipe recipe}) async {
    final db = await _database();
    await db.update(_tableName, recipe.toMap(),
        where: 'id = ?', whereArgs: [recipe.id]);
  }
}
