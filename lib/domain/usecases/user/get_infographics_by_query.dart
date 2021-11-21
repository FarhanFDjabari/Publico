import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class GetInfographicsByQuery {
  final Repository repository;

  const GetInfographicsByQuery(this.repository);

  Future<Either<Failure, List<Infographic>>> execute(query) async {
    return repository.getInfographicPosts(query);
  }
}
