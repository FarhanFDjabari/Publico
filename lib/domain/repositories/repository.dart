import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:publico/domain/entities/user.dart';
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
  Future<Either<Failure, void>> postInfographicTheme(
      String themeName, File themeImage, String destination);
  Future<Either<Failure, void>> deleteVideoPost(
      String id, String videoUrl, String thumbnailUrl, String collectionPath);
}
