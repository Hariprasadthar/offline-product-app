import 'package:flutter/material.dart';
import 'package:offline_product_app/model/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:offline_product_app/databasehelper.dart';

class Databasehelper {
  //singleton
  static final Databasehelper Instance = Databasehelper._init();

  static Database? _database;
  String dbName = "pms.db";
  String tableName = "product";

  Databasehelper._init();

  Future<Database> get database async {
    _database = await _initDB(
      dbName,
    );
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final Path = join(dbPath, filePath);
    return openDatabase(Path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    String sql = """  CREATE TABLE "$tableName" (
  	"id"	INTEGER,
	  "title"	TEXT NOT NULL,
	  "description"	TEXT,
	  PRIMARY KEY("id" AUTOINCREMENT)
    );    """;
    await db.execute(sql);
  }

  Future<Product> addProduct(Product p) async {
    final db = await Instance.database;
    final id = await db.insert(tableName, p.toMap());
    return p.copy(id: id);
  }

  Future<List<Product>> listAllProduct() async {
    final db = await Instance.database;
    List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (index) {
      return Product(
          id: maps[index]['id'],
          title: maps[index]['title'],
          description: maps[index]['description']);
    }).toList();
  }

  Future close() async {
    final db = await Instance.database;
    db.close();
  }

  // For delete
  Future<bool> deleteProduct(int id) async {
    try {
      final db = await Instance.database;
      await db.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<bool> updateProduct(Product p) async {
    // Get a reference to the database.
    try {
      final db = await database;

      // Update the given Dog.
      await db.update(
        tableName,
        p.toMap(),
        // Ensure that the Dog has a matching id.
        where: 'id = ?',
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [p.id],
      );
      return true;
    } catch (ex) {
      return false;
    }
  }
}
