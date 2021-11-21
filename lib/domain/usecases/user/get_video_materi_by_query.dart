import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class GetVideoMateriByQuery {
  final Repository repository;

  const GetVideoMateriByQuery(this.repository);

  Future<Either<Failure, List<VideoMateri>>> execute(query) async {
    return repository.getVideoMateriPosts(query);
  }
}
