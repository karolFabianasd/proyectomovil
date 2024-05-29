import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Product.db";
  static const String _tableName = "productos";

  static const String _columnId = "id";
  static const String _columnNombre = "nombre";
  static const String _columnDescripcion = "descripcion";
  static const String _columnPrecio = "precio";
  static const String _columnImage = "image";
  static const String _columnCategoria = "categoria";
  static Database? _database;

  static Future<Database?> _getDB() async {
    if (_database != null) {
      return _database;
    }

    _database = await openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $_tableName (
            $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $_columnNombre TEXT,
            $_columnDescripcion TEXT,
            $_columnPrecio TEXT,
            $_columnImage TEXT,
            $_columnCategoria TEXT
          )
        ''');
      },
      version: _version,
    );

    return _database;
  }

  static Future<void> insertProducto(Map<String, dynamic> producto) async {
    final db = await _getDB();
    await db!.insert(
      _tableName,
      producto,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getProductos() async {
    final db = await _getDB();
    return db!.query(_tableName);
  }

  static Future<bool> eliminarProducto(int id) async {
    final db = await _getDB();
    final rowsAffected = await db!.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
    return rowsAffected > 0;
  }
}