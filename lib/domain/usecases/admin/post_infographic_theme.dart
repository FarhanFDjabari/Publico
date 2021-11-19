import 'package:dartz/dartz.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class PostInfographicTheme {
  final Repository repository;

  PostInfographicTheme(this.repository);

  Future<Either<Failure, void>> execute(
      themeName, themeImage, destination) async {
    return repository.postInfographicTheme(themeName, themeImage, destination);
  }
}
