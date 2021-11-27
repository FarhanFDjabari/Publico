import 'package:dartz/dartz.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/repositories/repository.dart';
import 'package:publico/util/failure.dart';

class SaveInfographic {
  final Repository repository;

  SaveInfographic(this.repository);

  Future<Either<Failure, String>> execute(
      Infographic infographic, String id) async {
    return repository.saveInfographicToBookmark(infographic, id);
  }
}
