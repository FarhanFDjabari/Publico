import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class GetInfographicBookmark {
  final Repository repository;

  GetInfographicBookmark(this.repository);

  Future<Either<Failure, List<Infographic>>> execute() {
    return repository.getInfographicBookmark();
  }
}
