import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class GetVideoMateriBookmark {
  final Repository repository;

  const GetVideoMateriBookmark(this.repository);

  Future<Either<Failure, List<VideoMateri>>> execute() async {
    throw UnimplementedError();
  }
}
