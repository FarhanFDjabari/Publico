import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class GetInfographicsByThemeId {
  final Repository repository;

  const GetInfographicsByThemeId(this.repository);

  Future<Either<Failure, List<Infographic>>> execute(themeId) async {
    return repository.getInfographicsByThemeId(themeId);
  }
}
