import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/domain/entities/video_singkat.dart';
import 'package:publico/domain/usecases/user/check_infographic_bookmark.dart';
import 'package:publico/domain/usecases/user/check_video_materi_bookmark.dart';
import 'package:publico/domain/usecases/user/check_video_singkat_bookmark.dart';
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
    required this.checkInfographicBookmark,
    required this.checkVideoSingkatBookmark,
    required this.checkVideoMateriBookmark,
  }) : super(BookmarkInitial());
  final GetVideoMateriBookmark getVideoMateriBookmark;
  final GetInfographicBookmark getInfographicBookmark;
  final GetVideoSingkatBookmark getVideoSingkatBookmark;
  final GetAllBookmark getAllBookmark;
  final CheckInfographicBookmark checkInfographicBookmark;
  final CheckVideoSingkatBookmark checkVideoSingkatBookmark;
  final CheckVideoMateriBookmark checkVideoMateriBookmark;

  void getVideoMateriFromBookmark() async {
    emit(BookmarkLoading());
    final result = await getVideoMateriBookmark.execute();
    result.fold(
      (l) => emit(BookmarkError(l.message)),
      (r) async {
        List<bool> labels = [];
        for (var item in r) {
          final label = await checkVideoMateriBookmark.execute(item.id);
          labels.add(label);
        }
        return emit(GetVideoMateriBookmarkSuccess(r, labels));
      },
    );
  }

  void getInfographicFromBookmark() async {
    emit(BookmarkLoading());
    final result = await getInfographicBookmark.execute();
    result.fold(
      (l) => emit(BookmarkError(l.message)),
      (r) async {
        List<bool> labels = [];
        for (var item in r) {
          final label = await checkInfographicBookmark.execute(item.id);
          labels.add(label);
        }
        return emit(GetInfographicBookmarkSuccess(r, labels));
      },
    );
  }

  void getVideoSingkatFromBookmark() async {
    emit(BookmarkLoading());
    final result = await getVideoSingkatBookmark.execute();
    result.fold(
      (l) => emit(BookmarkError(l.message)),
      (r) async {
        List<bool> labels = [];
        for (var item in r) {
          final label = await checkVideoSingkatBookmark.execute(item.id);
          labels.add(label);
        }
        return emit(GetVideoSingkatBookmarkSuccess(r, labels));
      },
    );
  }

  void getAllFromBookmark() async {
    emit(BookmarkLoading());
    final result = await getAllBookmark.execute();
    result.fold(
      (l) => emit(BookmarkError(l.message)),
      (r) async {
        List<bool> bookmarkLabel = [];
        for (var item in r) {
          if (item is Infographic) {
            final label = await checkInfographicBookmark.execute(item.id);
            bookmarkLabel.add(label);
          } else if (item is VideoSingkat) {
            final label = await checkVideoSingkatBookmark.execute(item.id);
            bookmarkLabel.add(label);
          } else if (item is VideoMateri) {
            final label = await checkVideoMateriBookmark.execute(item.id);
            bookmarkLabel.add(label);
          }
        }
        return emit(
          GetAllBookmarkSuccess(r, bookmarkLabel),
        );
      },
    );
  }
}
