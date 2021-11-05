import 'package:dartz/dartz.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class Logout {
  final Repository repository;

  Logout(this.repository);

  Future<Either<Failure, void>> execute() {
    return repository.logout();
  }
}
