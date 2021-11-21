import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/video_singkat.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class GetVideoSingkatByQuery {
  final Repository repository;

  const GetVideoSingkatByQuery(this.repository);

  Future<Either<Failure, List<VideoSingkat>>> execute(query) async {
    return repository.getVideoSingkatPosts(query);
  }
}
