import 'package:dartz/dartz.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class GetAllSearch {
  final Repository repository;

  const GetAllSearch(this.repository);

  Future<Either<Failure, List<dynamic>>> execute(query) {
    return repository.getAllByQuery(query);
  }
}
