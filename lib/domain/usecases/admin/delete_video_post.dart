import 'package:dartz/dartz.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class DeleteVideoPost {
  final Repository repository;

  DeleteVideoPost(this.repository);

  Future<Either<Failure, void>> execute(
      id, videoUrl, thumbnailUrl, collectionPath) async {
    return repository.deleteVideoPost(
        id, videoUrl, thumbnailUrl, collectionPath);
  }
}
