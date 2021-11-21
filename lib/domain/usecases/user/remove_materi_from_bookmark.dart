import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class RemoveMateriFromBookmark {
  final Repository repository;

  RemoveMateriFromBookmark(this.repository);

  Future<Either<Failure, String>> execute(VideoMateri video) async {
    return repository.removeVideoMateriFromBookmark(video);
  }
}
