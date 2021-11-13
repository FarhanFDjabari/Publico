import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class UploadFileToStorage {
  final Repository repository;

  UploadFileToStorage(this.repository);

  Future<Either<Failure, UploadTask>> execute(destination, file) {
    return repository.uploadFile(destination, file);
  }
}
