import 'package:dartz/dartz.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class EditVideoSingkatPost {
  final Repository repository;
  const EditVideoSingkatPost(this.repository);

  Future<Either<Failure, void>> execute(
      id,
      title,
      description,
      oldVideoUrl,
      oldThumbnailUrl,
      newVideoFile,
      newThumbnailFile,
      tiktokUrl,
      duration) async {
    return repository.editVideoSingkat(id, title, description, oldVideoUrl,
        oldThumbnailUrl, newVideoFile, newThumbnailFile, tiktokUrl, duration);
  }
}
