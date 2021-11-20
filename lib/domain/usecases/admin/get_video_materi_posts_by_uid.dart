import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class GetVideoMateriPostsByUid {
  final Repository repository;

  const GetVideoMateriPostsByUid(this.repository);

  Future<Either<Failure, List<VideoMateri>>> execute(uid) async {
    return repository.getVideoMateriPostsByUid(uid);
  }
}
