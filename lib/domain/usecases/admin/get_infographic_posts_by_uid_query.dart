import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class GetInfographicPostsByUidQuery {
  final Repository repository;

  const GetInfographicPostsByUidQuery(this.repository);

  Future<Either<Failure, List<Infographic>>> execute(uid, query) async {
    return repository.getInfographicPostsByUidQuery(uid, query);
  }
}
