import 'package:publico/domain/repositories/repository.dart';

class GetInfographicBookmarkStatus {
  final Repository repository;

  GetInfographicBookmarkStatus(this.repository);

  Future<bool> execute(String id) async {
    return repository.isInfographicAddedToBookmark(id);
  }
}
