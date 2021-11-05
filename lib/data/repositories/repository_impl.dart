import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:publico/data/datasources/remote_datasources.dart';
import 'package:publico/domain/entities/user.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSources remoteDataSources;

  RepositoryImpl({required this.remoteDataSources});

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      String email, String password) async {
    try {
      final result =
          await remoteDataSources.loginWithEmailPassword(email, password);
      await GetStorage().write('uid', result.uid);
      return Right(result.toEntity());
    } on Exception catch (e) {
      return const Left(CommonFailure('Auth Error'));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      String email, String password) async {
    try {
      final result =
          await remoteDataSources.signUpWithEmailPassword(email, password);
      return Right(result.toEntity());
    } on Exception {
      return const Left(CommonFailure('Register Error'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSources.logout();
      await GetStorage().remove('uid');
      return const Right(null);
    } on Exception {
      return const Left(CommonFailure('logout Error'));
    }
  }
}
