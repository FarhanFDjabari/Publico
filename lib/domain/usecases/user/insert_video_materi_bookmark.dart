import 'package:dartz/dartz.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class InsertVideoMateriBookmark {
  final Repository repository;

  const InsertVideoMateriBookmark(this.repository);

  Future<Either<Failure, void>> execute(videoMateri) async {
    return repository.insertVideoMateriBookmark(videoMateri);
  }
}
