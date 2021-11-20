import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/theme.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class GetInfographicThemesByUid {
  final Repository repository;

  const GetInfographicThemesByUid(this.repository);

  Future<Either<Failure, List<Theme>>> execute(uid) async {
    return repository.getInfographicThemesByUid(uid);
  }
}
