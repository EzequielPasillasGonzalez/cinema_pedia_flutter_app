import 'package:cinema_pedia_app/infrastructure/database/models/local_movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDbDatasource {
  // Singleton: Para siempre usar la misma conexion
  static final LocalDbDatasource _instace = LocalDbDatasource._internal();
  factory LocalDbDatasource() => _instace;
  LocalDbDatasource._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _iniDatabase();
    return _database!;
  }

  // Inicializar la base de datos
  Future<Database> _iniDatabase() async {
    final dbPath = await getDatabasesPath(); // Ruta segura en el celular
    final path = join(dbPath, 'cinema_pedia.db');

    return await openDatabase(
      path,
      version:
          1, // En caso de cambiar las tablas en el futuro, es necesario subir el numero
      onCreate: (Database db, int version) async {
        await db.execute(
          ''' CREATE TABLE favorites(id INTEGER PRIMARY KEY, title TEXT, posterPath TEXT) ''',
        );
      },
    );
  }

  // --- Metodos CRUD ----

  // Create pelicula
  Future<void> toggleFavorite(LocalMovie movie) async {
    final db = await database;
    // Verficamos si existe
    final existe = await db.query(
      'favorites',
      where: 'id = ? ',
      whereArgs: [movie.id],
    );

    if (existe.isNotEmpty) {
      // Si existe la borramos
      await db.delete('favorites', where: 'id = ?', whereArgs: [movie.id]);
    } else {
      // Si no existe, la insertamos
      await db.insert(
        'favorites',
        movie.toMap(),
        conflictAlgorithm:
            ConflictAlgorithm.replace, // Si hay conflicto reemplaza
      );
    }
  }

  // Leer si una pelicula es favorita
  Future<bool> isFavorite(int movieId) async {
    final db = await database;
    final maps = await db.query(
      'favorites',
      where: 'id = ? ',
      whereArgs: [movieId],
    );
    return maps.isNotEmpty;
  }

  Future<List<LocalMovie>> loadFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');

    return List.generate(maps.length, (i) => LocalMovie.fromMap(maps[i]));
  }
}
