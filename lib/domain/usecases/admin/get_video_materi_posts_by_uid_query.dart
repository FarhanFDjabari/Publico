import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class GetVideoMateriPostsByUidQuery {
  final Repository repository;

  const GetVideoMateriPostsByUidQuery(this.repository);

  Future<Either<Failure, List<VideoMateri>>> execute(uid, query) async {
    return repository.getVideoMateriPostsByUidQuery(uid, query);
  }
}
