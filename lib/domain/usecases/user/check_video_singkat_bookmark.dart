import 'package:publico/domain/repositories/repository.dart';

class CheckVideoSingkatBookmark {
  final Repository repository;
  const CheckVideoSingkatBookmark(this.repository);

  Future<bool> execute(id) async {
    return repository.isVideoSingkatAddedToBookmark(id);
  }
}
