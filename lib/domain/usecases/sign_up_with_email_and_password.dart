import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/user.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class SignUpWithEmailAndPassword {
  final Repository repository;

  SignUpWithEmailAndPassword(this.repository);

  Future<Either<Failure, User>> execute(email, password) {
    return repository.signUpWithEmailPassword(email, password);
  }
}
