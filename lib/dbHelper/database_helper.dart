import 'package:flutter_application_1/modelo/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';



class DatabaseHelper{
  static const int _version=1;
  static const String _dbName= "User.db";
  static const String _tableName = "usuarios";
  
  static const String _columnId = "id";
  static const String _columnNombre = "nombre";
  static const String _columnApellido = "apellido";
  static const String _columnTelefono = "telefono";
  static const String _columnCorreo = "correo";
  static const String _columnPassword = "password";
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
            $_columnApellido TEXT,
            $_columnTelefono TEXT,
            $_columnCorreo TEXT,
            $_columnPassword TEXT
          )
        ''');
      },
      version: _version,
    );

    return _database;
  }

    static Future<void> insertRegistro(User user) async {
    final db = await _getDB();
    await db!.insert(
      _tableName,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

static Future<bool> usuarioExiste(String nombreUsuario, String contrasena) async {
  final db = await _getDB();
  final List<Map<String, dynamic>> maps = await db!.query(
    _tableName,
    where: '$_columnNombre = ? AND $_columnPassword = ?',
    whereArgs: [nombreUsuario, contrasena],
  );
  return maps.isNotEmpty;
}

}
