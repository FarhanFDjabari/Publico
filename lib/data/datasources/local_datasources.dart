import 'package:publico/data/models/infographic_table.dart';
import 'package:publico/data/models/video_materi_table.dart';
import 'package:publico/data/models/video_singkat_table.dart';
import 'package:publico/util/exception.dart';

import './db/database_helper.dart';

abstract class LocalDataSources {
  Future<String> insertVideoMateriToBookmark(VideoMateriTable video);
  Future<String> removeVideoMateriFromBookmark(VideoMateriTable video);
  Future<List<VideoMateriTable>> getVideoMateriBookmark();
  Future<VideoMateriTable?> getVideoMateriBookmarkById(String id);
  Future<String> insertVideoSingkatToBookmark(VideoSingkatTable video);
  Future<String> removeVideoSingkatFromBookmark(VideoSingkatTable video);
  Future<List<VideoSingkatTable>> getVideoSingkatBookmark();
  Future<VideoSingkatTable?> getVideoSingkatBookmarkById(String id);
  Future<String> insertInfographicToBookmark(InfographicTable infographic);
  Future<String> removeInfographicFromBookmark(InfographicTable infographic);
  Future<List<InfographicTable>> getInfographicBookmark();
  Future<InfographicTable?> getInfographicBookmarkById(String id);
}

class LocalDataSourceImpl implements LocalDataSources {
  final DatabaseHelper databaseHelper;

  LocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertVideoMateriToBookmark(VideoMateriTable video) async {
    try {
      await databaseHelper.insertVideoMateriBookmark(video);
      return 'Ditambahkan ke Bookmark';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeVideoMateriFromBookmark(VideoMateriTable video) async {
    try {
      await databaseHelper.removeVideoMateriFromBookmark(video);
      return 'Dihapus dari Bookmark';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<VideoMateriTable>> getVideoMateriBookmark() async {
    final result = await databaseHelper.getVideoMateriBookmark();
    if (result != null) {
      return result.map((data) => VideoMateriTable.fromMap(data)).toList();
    }
    return [];
  }

  @override
  Future<VideoMateriTable?> getVideoMateriBookmarkById(String id) async {
    final result = await databaseHelper.getVideoMateriBookmarkById(id);
    if (result != null) {
      return VideoMateriTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<InfographicTable>> getInfographicBookmark() async {
    final result = await databaseHelper.getInfographicsBookmark();
    if (result != null) {
      return result.map((data) => InfographicTable.fromMap(data)).toList();
    }
    return [];
  }

  @override
  Future<InfographicTable?> getInfographicBookmarkById(String id) async {
    final result = await databaseHelper.getInfographicsBookmarkById(id);
    if (result != null) {
      return InfographicTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<VideoSingkatTable>> getVideoSingkatBookmark() async {
    final result = await databaseHelper.getVideoSingkatBookmark();
    if (result != null) {
      return result.map((data) => VideoSingkatTable.fromMap(data)).toList();
    }
    return [];
  }

  @override
  Future<VideoSingkatTable?> getVideoSingkatBookmarkById(String id) async {
    final result = await databaseHelper.getVideoSingkatBookmarkById(id);
    if (result != null) {
      return VideoSingkatTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<String> insertInfographicToBookmark(
      InfographicTable infographic) async {
    try {
      await databaseHelper.insertInfographicBookmark(infographic);
      return 'Ditambahkan ke Bookmark';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> insertVideoSingkatToBookmark(VideoSingkatTable video) async {
    try {
      await databaseHelper.insertVideoSingkatBookmark(video);
      return 'Ditambahkan ke Bookmark';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeInfographicFromBookmark(
      InfographicTable infographic) async {
    try {
      await databaseHelper.removeInfographicFromBookmark(infographic);
      return 'Dihapus dari Bookmark';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeVideoSingkatFromBookmark(VideoSingkatTable video) async {
    try {
      await databaseHelper.removeVideoSingkatFromBookmark(video);
      return 'Dihapus dari Bookmark';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
