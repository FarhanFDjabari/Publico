import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/entities/theme.dart';
import 'package:publico/domain/entities/user.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/domain/entities/video_singkat.dart';
import 'package:publico/util/failure.dart';

abstract class Repository {
  Future<Either<Failure, User>> loginWithEmailPassword(
      String email, String password);
  Future<Either<Failure, void>> sendForgetPasswordSignal(String email);
  Future<Either<Failure, UploadTask>> uploadFile(String destination, File file);
  Future<Either<Failure, void>> logout();

  Future<Either<Failure, void>> postVideoSingkat(
      String title,
      String description,
      String tiktokUrl,
      String videoDestination,
      String thumbnailDestination,
      File videoFile,
      File thumbnailFile,
      int duration);
  Future<Either<Failure, void>> postVideoMateri(
      String title,
      String description,
      String videoDestination,
      String thumbnailDestination,
      File videoFile,
      File thumbnailFile,
      int duration);
  Future<Either<Failure, List<VideoSingkat>>> getVideoSingkatPostsByUid(
      String uid);
  Future<Either<Failure, List<VideoMateri>>> getVideoMateriPostsByUid(
      String uid);
  Future<Either<Failure, List<VideoSingkat>>> getVideoSingkatPostsByUidQuery(
      String uid, String query);
  Future<Either<Failure, List<VideoMateri>>> getVideoMateriPostsByUidQuery(
      String uid, String query);
  Future<Either<Failure, List<Theme>>> getInfographicThemesByUid(String uid);
  Future<Either<Failure, void>> postInfographicTheme(
      String themeName, File themeImage, String destination);
  Future<Either<Failure, void>> deleteVideoPost(
      String id, String videoUrl, String thumbnailUrl, String collectionPath);
  Future<Either<Failure, void>> postInfographic(String themeId,
      String themeName, String title, List sources, String destination);
  Future<Either<Failure, List<Infographic>>> getInfographicsByThemeId(
      String themeId);
  Future<Either<Failure, void>> deleteInfographicPost(
      String id, List<dynamic> illustrationsUrl, String collectionPath);

  Future<Either<Failure, List<VideoSingkat>>> getVideoSingkatPosts(
      String query);
  Future<Either<Failure, List<VideoMateri>>> getVideoMateriPosts(String query);
  Future<Either<Failure, List<Infographic>>> getInfographicPosts(String query);
  Future<Either<Failure, List<Infographic>>> getInfographicPostsByUidQuery(
      String uid, String query);

  Future<Either<Failure, void>> editInfographic(
    String id,
    String themeId,
    String themeName,
    String? title,
    List<dynamic>? newSources,
  );
  Future<Either<Failure, void>> editVideoMateri(
      String id,
      String? title,
      String? description,
      String oldVideoUrl,
      String oldThumbnailUrl,
      File? newVideoFile,
      File? newThumbnailFile,
      int? duration);
  Future<Either<Failure, void>> editVideoSingkat(
      String id,
      String? title,
      String? description,
      String oldVideoUrl,
      String oldThumbnailUrl,
      File? newVideoFile,
      File? newThumbnailFile,
      String? tiktokUrl,
      int? duration);

  Future<Either<Failure, List<dynamic>>> getExplore();
  Future<Either<Failure, List<dynamic>>> getAllByQuery(String query);
  Future<Either<Failure, String>> saveVideoMateriToBookmark(
      VideoMateri video, String id);
  Future<Either<Failure, String>> saveVideoSingkatToBookmark(
      VideoSingkat video, String id);
  Future<Either<Failure, String>> saveInfographicToBookmark(
      Infographic infographic, String id);
  Future<Either<Failure, String>> removeVideoMateriFromBookmark(
      VideoMateri video, String id);

  Future<Either<Failure, String>> removeVideoSingkatFromBookmark(
      VideoSingkat video, String id);
  Future<Either<Failure, String>> removeInfographicFromBookmark(
      Infographic infographic, String id);
  Future<bool> isVideoMateriAddedToBookmark(String id);
  Future<bool> isVideoSingkatAddedToBookmark(String id);
  Future<bool> isInfographicAddedToBookmark(String id);

  Future<Either<Failure, List<VideoMateri>>> getVideoMateriBookmark();
  Future<Either<Failure, List<VideoSingkat>>> getVideoSingkatBookmark();
  Future<Either<Failure, List<Infographic>>> getInfographicBookmark();
  Future<Either<Failure, List<dynamic>>> getAllBookmark();
}
