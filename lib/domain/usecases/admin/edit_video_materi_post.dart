import 'package:dartz/dartz.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class EditVideoMateriPost {
  final Repository repository;
  const EditVideoMateriPost(this.repository);

  Future<Either<Failure, void>> execute(id, title, description, oldVideoUrl,
      oldThumbnailUrl, newVideoFile, newThumbnailFile, duration) async {
    return repository.editVideoMateri(id, title, description, oldVideoUrl,
        oldThumbnailUrl, newVideoFile, newThumbnailFile, duration);
  }
}
