import 'package:publico/domain/repositories/repository.dart';

class GetSingkatBookmarkStatus {
  final Repository repository;

  GetSingkatBookmarkStatus(this.repository);

  Future<bool> execute(String id) async {
    return repository.isVideoSingkatAddedToBookmark(id);
  }
}
