import 'package:dartz/dartz.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class PostInfographic {
  final Repository repository;

  const PostInfographic(this.repository);

  Future<Either<Failure, void>> execute(
      themeId, title, sources, destination) async {
    return repository.postInfographic(themeId, title, sources, destination);
  }
}
