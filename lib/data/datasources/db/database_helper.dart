import 'package:publico/data/models/infographic_table.dart';
import 'package:publico/data/models/video_materi_table.dart';
import 'package:publico/data/models/video_singkat_table.dart';
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

  static const String _tblVideoMateriBookmark = 'video_materi_bookmark';
  static const String _tblVideoSingkatBookmark = 'video_singkat_bookmark';
  static const String _tblInfographicBookmark = 'infographics_bookmark';

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
      CREATE TABLE  $_tblVideoMateriBookmark (
        id TEXT PRIMARY KEY,
        admin_id TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        duration INTEGER,
        type TEXT NOT NULL,
        thumbnail_url TEXT NOT NULL,
        video_url TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblVideoSingkatBookmark (
        id TEXT PRIMARY KEY,
        admin_id TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        duration INTEGER,
        type TEXT NOT NULL,
        thumbnail_url TEXT NOT NULL,
        video_url TEXT,
        tiktok_url TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblInfographicBookmark (
        id TEXT PRIMARY KEY,
        admin_id TEXT NOT NULL,
        title TEXT NOT NULL,
        themeId TEXT NOT NULL,
        themeName TEXT NOT NULL,
        type TEXT NOT NULL,
        sources TEXT NOT NULL
      );
    ''');
  }

  Future<int> insertVideoMateriBookmark(VideoMateriTable video) async {
    final db = await database;
    return await db!.insert(_tblVideoMateriBookmark, video.toJson());
  }

  Future<int> insertVideoSingkatBookmark(VideoSingkatTable video) async {
    final db = await database;
    return await db!.insert(_tblVideoSingkatBookmark, video.toJson());
  }

  Future<int> insertInfographicBookmark(InfographicTable infographic) async {
    final db = await database;
    return await db!.insert(_tblInfographicBookmark, infographic.toJson());
  }

  Future<int> removeVideoMateriFromBookmark(VideoMateriTable video) async {
    final db = await database;
    return await db!.delete(
      _tblVideoMateriBookmark,
      where: 'id = ?',
      whereArgs: [video.id],
    );
  }

  Future<int> removeVideoSingkatFromBookmark(VideoSingkatTable video) async {
    final db = await database;
    return await db!.delete(
      _tblVideoSingkatBookmark,
      where: 'id = ?',
      whereArgs: [video.id],
    );
  }

  Future<int> removeInfographicFromBookmark(
      InfographicTable infographic) async {
    final db = await database;
    return await db!.delete(
      _tblInfographicBookmark,
      where: 'id = ?',
      whereArgs: [infographic.id],
    );
  }

  Future<Map<String, dynamic>?> getVideoMateriBookmarkById(String id) async {
    final db = await database;
    final results = await db!.query(
      _tblVideoMateriBookmark,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getVideoSingkatBookmarkById(String id) async {
    final db = await database;
    final results = await db!.query(
      _tblVideoSingkatBookmark,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getInfographicsBookmarkById(String id) async {
    final db = await database;
    final results = await db!.query(
      _tblInfographicBookmark,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getVideoMateriBookmark() async {
    final db = await database;
    final results = await db!.query(
      _tblVideoMateriBookmark,
    );

    if (results.isNotEmpty) {
      return results;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getInfographicsBookmark() async {
    final db = await database;
    final results = await db!.query(
      _tblInfographicBookmark,
    );

    if (results.isNotEmpty) {
      return results;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getVideoSingkatBookmark() async {
    final db = await database;
    final results = await db!.query(
      _tblVideoSingkatBookmark,
    );

    if (results.isNotEmpty) {
      return results;
    } else {
      return null;
    }
  }
}
