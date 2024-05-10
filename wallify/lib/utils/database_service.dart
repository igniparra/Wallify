import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;
  static final DatabaseService instance = DatabaseService._internal();

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'wallify.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorite_images(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            url TEXT,
            tags TEXT,
            path TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE tags_cache(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            modelCount INTEGER,
            link TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE wallpaper_history(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp TEXT,
            url TEXT,
            tags TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertFavoriteImage(Map<String, dynamic> imageData) async {
    final db = await database;
    return await db.insert('favorite_images', imageData);
  }

  Future<int> insertTag(Map<String, dynamic> tagData) async {
    final db = await database;
    return await db.insert('tags_cache', tagData);
  }

  Future<int> insertWallpaperHistory(Map<String, dynamic> historyData) async {
    final db = await database;
    return await db.insert('wallpaper_history', historyData);
  }

  Future<List<Map<String, dynamic>>> getFavoriteImages() async {
    final db = await database;
    return await db.query('favorite_images');
  }

  Future<List<Map<String, dynamic>>> getTagsCache() async {
    final db = await database;
    return await db.query('tags_cache');
  }

  Future<List<Map<String, dynamic>>> getWallpaperHistory() async {
    final db = await database;
    return await db.query('wallpaper_history');
  }

  Future<int> deleteFavoriteImage(int id) async {
    final db = await database;
    return await db.delete('favorite_images', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllTagsCache() async {
    final db = await database;
    return await db.delete('tags_cache');
  }

  Future<int> deleteAllWallpaperHistory() async {
    final db = await database;
    return await db.delete('wallpaper_history');
  }
}
