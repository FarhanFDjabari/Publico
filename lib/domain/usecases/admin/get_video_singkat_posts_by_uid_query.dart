import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/video_singkat.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class GetVideoSingkatPostsByUidQuery {
  final Repository repository;

  const GetVideoSingkatPostsByUidQuery(this.repository);

  Future<Either<Failure, List<VideoSingkat>>> execute(uid, query) async {
    return repository.getVideoSingkatPostsByUidQuery(uid, query);
  }
}
