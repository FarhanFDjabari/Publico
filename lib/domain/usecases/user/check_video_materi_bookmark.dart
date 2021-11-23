import 'package:publico/domain/repositories/repository.dart';

class CheckVideoMateriBookmark {
  final Repository repository;
  const CheckVideoMateriBookmark(this.repository);

  Future<bool> execute(id) async {
    return repository.isVideoMateriAddedToBookmark(id);
  }
}
