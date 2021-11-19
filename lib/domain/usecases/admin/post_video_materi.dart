import 'package:dartz/dartz.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class PostVideoMateri {
  final Repository repository;

  PostVideoMateri(this.repository);

  Future<Either<Failure, void>> execute(title, description, videoDestination,
      thumbnailDestination, videoFile, thumbnailFile, duration) async {
    return repository.postVideoMateri(title, description, videoDestination,
        thumbnailDestination, videoFile, thumbnailFile, duration);
  }
}
