import 'package:dartz/dartz.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class PostInfographic {
  final Repository repository;

  const PostInfographic(this.repository);

  Future<Either<Failure, void>> execute(
      themeId, themeName, title, sources, destination) async {
    return repository.postInfographic(
        themeId, themeName, title, sources, destination);
  }
}
