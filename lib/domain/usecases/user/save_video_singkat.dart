import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/video_singkat.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class SaveVideoSingkat {
  final Repository repository;

  SaveVideoSingkat(this.repository);

  Future<Either<Failure, String>> execute(VideoSingkat video, String id) async {
    return repository.saveVideoSingkatToBookmark(video, id);
  }
}
