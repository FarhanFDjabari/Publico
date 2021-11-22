import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/video_singkat.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class RemoveSingkatFromBookmark {
  final Repository repository;

  RemoveSingkatFromBookmark(this.repository);

  Future<Either<Failure, String>> execute(VideoSingkat video) async {
    return repository.removeVideoSingkatFromBookmark(video);
  }
}
