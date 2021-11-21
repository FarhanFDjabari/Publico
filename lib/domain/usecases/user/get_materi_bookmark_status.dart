import 'package:publico/domain/repositories/repository.dart';

class GetMateriBookmarkStatus {
  final Repository repository;

  GetMateriBookmarkStatus(this.repository);

  Future<bool> execute(String id) async {
    return repository.isVideoMateriAddedToWatchlist(id);
  }
}
