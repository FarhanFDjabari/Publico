import 'package:publico/data/models/video_materi_table.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblBookmark = 'bookmark';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/publico.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblBookmark (
        id TEXT PRIMARY KEY,
        admin_id TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        duration INTEGER,
        source_count INTEGER,
        type TEXT NOT NULL,
        thumbnail_url TEXT NOT NULL,
        video_url TEXT,
        tiktok_url TEXT,
      );
    ''');
  }

  Future<int> insertVideoMateriBookmark(VideoMateriTable video) async {
    final db = await database;
    return await db!.insert(_tblBookmark, video.toJson());
  }

  Future<int> removeFromBookmark(VideoMateriTable video) async {
    final db = await database;
    return await db!.delete(
      _tblBookmark,
      where: 'id = ?',
      whereArgs: [video.id],
    );
  }

  Future<List<Map<String, dynamic>>?> getBookmarkByType(String type) async {
    final db = await database;
    final results = await db!.query(
      _tblBookmark,
      where: 'type = ?',
      whereArgs: [type],
    );

    if (results.isNotEmpty) {
      return results;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getAllBookmark() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblBookmark);

    return results;
  }
}
