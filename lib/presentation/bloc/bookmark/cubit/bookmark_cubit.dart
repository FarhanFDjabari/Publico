import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/domain/entities/video_singkat.dart';
import 'package:publico/domain/usecases/user/get_all_bookmark.dart';
import 'package:publico/domain/usecases/user/get_infographic_bookmark.dart';
import 'package:publico/domain/usecases/user/get_video_materi_bookmark.dart';
import 'package:publico/domain/usecases/user/get_video_singkat_bookmark.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit({
    required this.getVideoMateriBookmark,
    required this.getInfographicBookmark,
    required this.getVideoSingkatBookmark,
    required this.getAllBookmark,
  }) : super(BookmarkInitial());
  final GetVideoMateriBookmark getVideoMateriBookmark;
  final GetInfographicBookmark getInfographicBookmark;
  final GetVideoSingkatBookmark getVideoSingkatBookmark;
  final GetAllBookmark getAllBookmark;

  void getVideoMateriFromBookmark() async {
    emit(BookmarkLoading());
    final result = await getVideoMateriBookmark.execute();
    result.fold(
      (l) => emit(BookmarkError(l.message)),
      (r) => emit(GetVideoMateriBookmarkSuccess(r)),
    );
  }

  void getInfographicFromBookmark() async {
    emit(BookmarkLoading());
    final result = await getInfographicBookmark.execute();
    result.fold(
      (l) => emit(BookmarkError(l.message)),
      (r) => emit(GetInfographicBookmarkSuccess(r)),
    );
  }

  void getVideoSingkatFromBookmark() async {
    emit(BookmarkLoading());
    final result = await getVideoSingkatBookmark.execute();
    result.fold(
      (l) => emit(BookmarkError(l.message)),
      (r) => emit(GetVideoSingkatBookmarkSuccess(r)),
    );
  }

  void getAllFromBookmark() async {
    emit(BookmarkLoading());
    final result = await getAllBookmark.execute();
    result.fold(
      (l) => emit(BookmarkError(l.message)),
      (r) => emit(GetAllBookmarkSuccess(r)),
    );
  }
}
