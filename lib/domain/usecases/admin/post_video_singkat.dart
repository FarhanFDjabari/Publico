import 'package:dartz/dartz.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class PostVideoSingkat {
  final Repository repository;

  PostVideoSingkat(this.repository);

  Future<Either<Failure, void>> execute(title, description, tiktokUrl, destination, file) async {
    return repository.postVideoSingkat(title, description, tiktokUrl, destination, file);
  }
}
