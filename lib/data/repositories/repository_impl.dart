import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:publico/data/datasources/local_datasources.dart';
import 'package:publico/data/datasources/remote_datasources.dart';
import 'package:publico/data/models/infographic_table.dart';
import 'package:publico/data/models/video_materi_table.dart';
import 'package:publico/data/models/video_singkat_table.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/entities/theme.dart';
import 'package:publico/domain/entities/user.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/domain/entities/video_singkat.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/exception.dart';
import 'package:publico/util/failure.dart';
import 'package:uuid/uuid.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSources remoteDataSources;
  final LocalDataSources localDataSources;

  RepositoryImpl(
      {required this.remoteDataSources, required this.localDataSources});

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      String email, String password) async {
    try {
      final result =
          await remoteDataSources.loginWithEmailPassword(email, password);
      await GetStorage().write('uid', result.uid);
      return Right(result.toEntity());
    } on AuthException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSources.logout();
      await GetStorage().remove('uid');
      return const Right(null);
    } on AuthException catch (e) {
      return Left(ServerFailure('Logout Error: ${e.message}'));
    }
  }

  @override
  Future<Either<Failure, void>> sendForgetPasswordSignal(String email) async {
    try {
      await remoteDataSources.sendForgetPasswordSignal(email);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UploadTask>> uploadFile(
      String destination, File file) async {
    try {
      final result =
          await remoteDataSources.uploadFiletoStorage(destination, file);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> postVideoSingkat(
      String title,
      String description,
      String tiktokUrl,
      String videoDestination,
      String thumbnailDestination,
      File videoFile,
      File thumbnailFile,
      int duration) async {
    try {
      final videoFilename = basename(videoFile.path);
      final thumbnailFilename = basename(thumbnailFile.path);
      final videoPath =
          "$videoDestination/${DateTime.now().microsecondsSinceEpoch}-${const Uuid().v4()}-${videoFilename.toLowerCase().replaceAll(" ", "_")}";
      final thumbnailPath =
          "$thumbnailDestination/${DateTime.now().microsecondsSinceEpoch}-${const Uuid().v4()}-${thumbnailFilename.toLowerCase().replaceAll(" ", "_")}";
      final videoUploadTask =
          await remoteDataSources.uploadFiletoStorage(videoPath, videoFile);
      final thumbnailUploadTask = await remoteDataSources.uploadFiletoStorage(
          thumbnailPath, thumbnailFile);
      String videoUrl = '';
      String thumbnailUrl = '';
      await videoUploadTask.whenComplete(() async {
        videoUrl = await videoUploadTask.snapshot.ref.getDownloadURL();
      });
      await thumbnailUploadTask.whenComplete(() async {
        thumbnailUrl = await thumbnailUploadTask.snapshot.ref.getDownloadURL();
      });
      await remoteDataSources.postVideoSingkat(
          title, description, videoUrl, thumbnailUrl, tiktokUrl, duration);

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> postVideoMateri(
      String title,
      String description,
      String videoDestination,
      String thumbnailDestination,
      File videoFile,
      File thumbnailFile,
      int duration) async {
    try {
      final videoFilename = basename(videoFile.path);
      final thumbnailFilename = basename(thumbnailFile.path);
      final videoPath =
          "$videoDestination/${DateTime.now().microsecondsSinceEpoch}-${const Uuid().v4()}-${videoFilename.toLowerCase().replaceAll(" ", "_")}";
      final thumbnailPath =
          "$thumbnailDestination/${DateTime.now().microsecondsSinceEpoch}-${const Uuid().v4()}-${thumbnailFilename.toLowerCase().replaceAll(" ", "_")}";
      final videoUploadTask =
          await remoteDataSources.uploadFiletoStorage(videoPath, videoFile);
      final thumbnailUploadTask = await remoteDataSources.uploadFiletoStorage(
          thumbnailPath, thumbnailFile);
      String videoUrl = '';
      String thumbnailUrl = '';
      await videoUploadTask.whenComplete(() async {
        videoUrl = await videoUploadTask.snapshot.ref.getDownloadURL();
      });
      await thumbnailUploadTask.whenComplete(() async {
        thumbnailUrl = await thumbnailUploadTask.snapshot.ref.getDownloadURL();
      });
      await remoteDataSources.postVideoMateri(
          title, description, videoUrl, thumbnailUrl, duration);

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<VideoSingkat>>> getVideoSingkatPostsByUid(
      uid) async {
    try {
      final videoSingkatModels =
          await remoteDataSources.getVideoSingkatPostsByUid(uid);
      final videoSingkatList = videoSingkatModels
          .map((videoSingkatModel) => videoSingkatModel.toEntity())
          .toList();
      return Right(videoSingkatList);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<VideoMateri>>> getVideoMateriPostsByUid(
      String uid) async {
    try {
      final videoMateriModels =
          await remoteDataSources.getVideoMateriPostsByUid(uid);
      final videoMateriList = videoMateriModels
          .map((videoSingkatModel) => videoSingkatModel.toEntity())
          .toList();
      return Right(videoMateriList);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Infographic>>> getInfographicsByThemeId(
      String themeId) async {
    try {
      final infographicModels =
          await remoteDataSources.getInfographicsByThemeId(themeId);
      final infographicList = infographicModels
          .map((infographicModel) => infographicModel.toEntity())
          .toList();
      return Right(infographicList);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Theme>>> getInfographicThemesByUid(
      String uid) async {
    try {
      final themeModels =
          await remoteDataSources.getInfographicThemesByUid(uid);
      final themeList =
          themeModels.map((themeModel) => themeModel.toEntity()).toList();
      return Right(themeList);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> postInfographicTheme(
      String themeName, File themeImage, String destination) async {
    try {
      final filename = basename(themeImage.path);
      final videoPath =
          "$destination/${DateTime.now().microsecondsSinceEpoch}-${const Uuid().v4()}-${filename.toLowerCase().replaceAll(" ", "_")}";
      final themeUploadTask =
          await remoteDataSources.uploadFiletoStorage(videoPath, themeImage);
      String themeImgUrl = '';
      await themeUploadTask.whenComplete(() async {
        themeImgUrl = await themeUploadTask.snapshot.ref.getDownloadURL();
      });

      await remoteDataSources.postNewTheme(themeName, themeImgUrl);

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> postInfographic(String themeId,
      String themeName, String title, List sources, String destination) async {
    try {
      List<Map<String, dynamic>> _sources = [];
      for (var source in sources) {
        List<String> illustrationList = [];
        for (var illustrationFile in source['illustration']) {
          String filename = basename(illustrationFile.path);
          String filePath =
              "$destination/${DateTime.now().microsecondsSinceEpoch}-${const Uuid().v4()}-${filename.toLowerCase().replaceAll(" ", "_")}";
          final uploadTask = await remoteDataSources.uploadFiletoStorage(
              filePath, illustrationFile);
          await uploadTask.whenComplete(() async {
            String illustrationUrl =
                await uploadTask.snapshot.ref.getDownloadURL();
            illustrationList.add(illustrationUrl);
          });
        }
        _sources.add({
          "source_name": source['source'],
          "description": source['description'],
          "illustrations": illustrationList
        });
      }
      await remoteDataSources.postInfographic(
          themeId, themeName, title, _sources);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteVideoPost(String id, String videoUrl,
      String thumbnailUrl, String collectionPath) async {
    try {
      await remoteDataSources.deleteFromStorage(videoUrl);
      await remoteDataSources.deleteFromStorage(thumbnailUrl);
      await remoteDataSources.deletePost(id, collectionPath);

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteInfographicPost(
      String id, List<dynamic> illustrationsUrl, String collectionPath) async {
    try {
      for (var url in illustrationsUrl) {
        await remoteDataSources.deleteFromStorage(url);
      }
      await remoteDataSources.deletePost(id, collectionPath);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> getExplore() async {
    try {
      final models = await remoteDataSources.getExplore();
      final infographicList = models['infographic_models']
          .map((model) => model.toEntity())
          .toList();
      final videoMateriList = models['video_materi_models']
          .map((model) => model.toEntity())
          .toList();
      final videoSingkatList = models['video_singkat_models']
          .map((model) => model.toEntity())
          .toList();
      final entities = [infographicList, videoMateriList, videoSingkatList];

      final entitiesFlattened = entities.expand((element) => element).toList();
      entitiesFlattened.shuffle();

      return Right(entitiesFlattened);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Infographic>>> getInfographicPosts(
      String query) async {
    try {
      final infographicModels =
          await remoteDataSources.getInfographicPosts(query);
      final infographicList =
          infographicModels.map((model) => model.toEntity()).toList();
      return Right(infographicList);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<VideoMateri>>> getVideoMateriPosts(
      String query) async {
    try {
      final videoMateriModels =
          await remoteDataSources.getVideoMateriPosts(query);
      final videoMateriList =
          videoMateriModels.map((model) => model.toEntity()).toList();
      return Right(videoMateriList);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<bool> isVideoMateriAddedToWatchlist(String id) async {
    final result = await localDataSources.getVideoMateriBookmarkById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeVideoMateriFromBookmark(
      VideoMateri video) async {
    try {
      final result = await localDataSources
          .removeVideoMateriFromBookmark(VideoMateriTable.fromEntity(video));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<VideoSingkat>>> getVideoSingkatPosts(
      String query) async {
    try {
      final videoSingkatModels =
          await remoteDataSources.getVideoSingkatPosts(query);
      final videoSingkatList =
          videoSingkatModels.map((model) => model.toEntity()).toList();
      return Right(videoSingkatList);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveVideoMateriToBookmark(
      VideoMateri video) async {
    try {
      final result = await localDataSources
          .insertVideoMateriToBookmark(VideoMateriTable.fromEntity(video));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> saveInfographicToBookmark(
      Infographic infographic) async {
    try {
      final result = await localDataSources.insertInfographicToBookmark(
          InfographicTable.fromEntity(infographic));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> saveVideoSingkatToBookmark(
      VideoSingkat video) async {
    try {
      final result = await localDataSources
          .insertVideoSingkatToBookmark(VideoSingkatTable.fromEntity(video));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<VideoMateri>>> getVideoMateriBookmark() async {
    try {
      final result = await localDataSources.getVideoMateriBookmark();
      return Right(result.map((data) => data.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<Infographic>>> getInfographicBookmark() async {
    final result = await localDataSources.getInfographicBookmark();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<Either<Failure, List<VideoSingkat>>> getVideoSingkatBookmark() async {
    try {
      final result = await localDataSources.getVideoSingkatBookmark();
      return Right(result.map((data) => data.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> getAllBookmark() async {
    try {
      final videoSingkat = await localDataSources
          .getInfographicBookmark()
          .then((value) => value.map((e) => e.toEntity()).toList());
      final videoMateri = await localDataSources
          .getVideoMateriBookmark()
          .then((value) => value.map((e) => e.toEntity()).toList());
      final infographic = await localDataSources
          .getInfographicBookmark()
          .then((value) => value.map((e) => e.toEntity()).toList());

      final entities = [videoSingkat, videoMateri, infographic];

      final entitiesFlattened = entities.expand((element) => element).toList();
      entitiesFlattened.shuffle();
      return (Right(entitiesFlattened));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }
}
