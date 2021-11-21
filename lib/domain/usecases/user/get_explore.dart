import 'package:dartz/dartz.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class GetExplore {
  final Repository repository;

  const GetExplore(this.repository);

  Future<Either<Failure, List<dynamic>>> execute() {
    return repository.getExplore();
  }
}
