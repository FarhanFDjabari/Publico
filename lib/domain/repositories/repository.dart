import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/user.dart';
import 'package:publico/util/failure.dart';

abstract class Repository {
  Future<Either<Failure, User>> loginWithEmailPassword(
      String email, String password);
  Future<Either<Failure, User>> signUpWithEmailPassword(
      String email, String password);
  Future<Either<Failure, void>> logout();
}
