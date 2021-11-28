import 'package:dartz/dartz.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class EditInfographicPost {
  final Repository repository;

  const EditInfographicPost(this.repository);

  Future<Either<Failure, void>> execute(
      id, themeId, themeName, title, newSources) async {
    return repository.editInfographic(
        id, themeId, themeName, title, newSources);
  }
}
