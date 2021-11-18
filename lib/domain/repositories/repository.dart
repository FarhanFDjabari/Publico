import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:publico/domain/entities/user.dart';
import 'package:publico/util/failure.dart';

abstract class Repository {
  Future<Either<Failure, User>> loginWithEmailPassword(
      String email, String password);
  Future<Either<Failure, void>> sendForgetPasswordSignal(String email);
  Future<Either<Failure, UploadTask>> uploadFile(String destination, File file);
  Future<Either<Failure, void>> logout();

  Future<Either<Failure, void>> postVideoSingkat(String title,
      String description, String tiktokUrl, String destination, File file);
}
