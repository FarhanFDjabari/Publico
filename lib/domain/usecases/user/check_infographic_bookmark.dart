import 'package:publico/domain/repositories/repository.dart';

class CheckInfographicBookmark {
  final Repository repository;
  const CheckInfographicBookmark(this.repository);

  Future<bool> execute(id) async {
    return repository.isInfographicAddedToBookmark(id);
  }
}
