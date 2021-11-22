import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class SaveVideoMateri {
  final Repository repository;

  SaveVideoMateri(this.repository);

  Future<Either<Failure, String>> execute(VideoMateri video) async {
    return repository.saveVideoMateriToBookmark(video);
  }
}
