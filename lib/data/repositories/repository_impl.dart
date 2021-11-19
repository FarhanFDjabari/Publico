import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:publico/data/datasources/remote_datasources.dart';
import 'package:publico/domain/entities/user.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/exception.dart';
import 'package:publico/util/failure.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSources remoteDataSources;

  RepositoryImpl({required this.remoteDataSources});

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(String email, String password) async {
    try {
      final result = await remoteDataSources.loginWithEmailPassword(email, password);
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
  Future<Either<Failure, UploadTask>> uploadFile(String destination, File file) async {
    try {
      final result = await remoteDataSources.uploadFiletoStorage(destination, file);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> postVideoSingkat(String title, String description, String tiktokUrl, String destination, File file) async {
    try {
      final filename = basename(file.path);
      final path = "$destination/${DateTime.now().microsecondsSinceEpoch}-${const Uuid().v4()}-${filename.toLowerCase().replaceAll(" ", "_")}";
      final uploadTask = await remoteDataSources.uploadFiletoStorage(path, file);
      String videoUrl = '';
      await uploadTask.whenComplete(() async {
        videoUrl = await uploadTask.snapshot.ref.getDownloadURL();
      });
      await remoteDataSources.postVideoSingkat(title, description, videoUrl, tiktokUrl);

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
