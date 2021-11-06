import 'package:dartz/dartz.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class SendForgetPassword {
  final Repository repository;

  SendForgetPassword(this.repository);

  Future<Either<Failure, void>> execute(email) {
    return repository.sendForgetPasswordSignal(email);
  }
}
