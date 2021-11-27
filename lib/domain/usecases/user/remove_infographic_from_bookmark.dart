import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class RemoveInfographicFromBookmark {
  final Repository repository;

  RemoveInfographicFromBookmark(this.repository);

  Future<Either<Failure, String>> execute(Infographic info, String id) async {
    return repository.removeInfographicFromBookmark(info, id);
  }
}
