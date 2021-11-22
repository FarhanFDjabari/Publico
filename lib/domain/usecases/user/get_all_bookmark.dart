import 'package:dartz/dartz.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class GetAllBookmark {
  final Repository repository;

  GetAllBookmark(this.repository);

  Future<Either<Failure, List<dynamic>>> execute() {
    return repository.getAllBookmark();
  }
}
