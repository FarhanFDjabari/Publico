import 'package:dartz/dartz.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class DeleteInfographicPost {
  final Repository repository;

  DeleteInfographicPost(this.repository);

  Future<Either<Failure, void>> execute(
      id, illustrationsUrl, collectionPath) async {
    return repository.deleteInfographicPost(
        id, illustrationsUrl, collectionPath);
  }
}
