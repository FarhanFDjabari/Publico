import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/video_singkat.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class GetVideoSingkatPostsByUid {
  final Repository repository;

  GetVideoSingkatPostsByUid(this.repository);

  Future<Either<Failure, List<VideoSingkat>>> execute(uid) async {
    return repository.getVideoSingkatPostsByUid(uid);
  }
}
