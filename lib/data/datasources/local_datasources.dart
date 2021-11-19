import 'package:publico/data/models/video_materi_table.dart';
import 'package:publico/util/exception.dart';

import './db/database_helper.dart';

abstract class LocalDataSources {
  Future<String> insertVideoMateriToBookmark(VideoMateriTable video);
  Future<String> removeVideoMateriFromBookmark(VideoMateriTable movie);
  Future<List<VideoMateriTable>> getVideoMateriBookmark();
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
      await databaseHelper.removeFromBookmark(video);
      return 'Dihapus dari Bookmark';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<VideoMateriTable>> getVideoMateriBookmark() async {
    final result = await databaseHelper.getBookmarkByType('Video Materi');
    if (result != null) {
      return result.map((data) => VideoMateriTable.fromMap(data)).toList();
    }
    return [];
  }
}
