import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/domain/entities/video_singkat.dart';
import 'package:publico/domain/usecases/user/check_infographic_bookmark.dart';
import 'package:publico/domain/usecases/user/check_video_materi_bookmark.dart';
import 'package:publico/domain/usecases/user/check_video_singkat_bookmark.dart';
import 'package:publico/domain/usecases/user/get_all_search.dart';
import 'package:publico/domain/usecases/user/get_infographics_by_query.dart';
import 'package:publico/domain/usecases/user/get_video_materi_by_query.dart';
import 'package:publico/domain/usecases/user/get_video_singkat_by_query.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    required this.getVideoMateriByQuery,
    required this.getInfographicByQuery,
    required this.getVideoSingkatByQuery,
    required this.getAllSearch,
    required this.checkInfographicBookmark,
    required this.checkVideoMateriBookmark,
    required this.checkVideoSingkatBookmark,
  }) : super(SearchInitial());
  final GetVideoMateriByQuery getVideoMateriByQuery;
  final GetInfographicsByQuery getInfographicByQuery;
  final GetVideoSingkatByQuery getVideoSingkatByQuery;
  final GetAllSearch getAllSearch;
  final CheckInfographicBookmark checkInfographicBookmark;
  final CheckVideoSingkatBookmark checkVideoSingkatBookmark;
  final CheckVideoMateriBookmark checkVideoMateriBookmark;

  void getAllFromSearch(String query) async {
    emit(SearchLoading());
    final result = await getAllSearch.execute(query);
    result.fold((l) => emit(SearchError(l.message)), (r) async {
      List<bool> itemLabel = [];
      for (var item in r) {
        if (item is Infographic) {
          final label = await checkInfographicBookmark.execute(item.id);
          itemLabel.add(label);
        } else if (item is VideoSingkat) {
          final label = await checkVideoSingkatBookmark.execute(item.id);
          itemLabel.add(label);
        } else if (item is VideoMateri) {
          final label = await checkVideoMateriBookmark.execute(item.id);
          itemLabel.add(label);
        }
      }
      emit(GetAllSearchSuccess(r, itemLabel));
    });
  }

  void getVideoMateriFromSearch(String query) async {
    emit(SearchLoading());
    final result = await getVideoMateriByQuery.execute(query);
    result.fold(
      (l) => emit(SearchError(l.message)),
      (r) async {
        List<bool> videoMateriLabel = [];
        for (var item in r) {
          final label = await checkVideoMateriBookmark.execute(item.id);
          videoMateriLabel.add(label);
        }
        emit(GetVideoMateriSearchSuccess(r, videoMateriLabel));
      },
    );
  }

  void getInfographicFromSearch(String query) async {
    emit(SearchLoading());
    final result = await getInfographicByQuery.execute(query);
    result.fold(
      (l) => emit(SearchError(l.message)),
      (r) async {
        List<bool> infographicLabel = [];
        for (var item in r) {
          final label = await checkInfographicBookmark.execute(item.id);
          infographicLabel.add(label);
        }
        emit(GetInfographicSearchSuccess(r, infographicLabel));
      },
    );
  }

  void getVideoSingkatFromSearch(String query) async {
    emit(SearchLoading());
    final result = await getVideoSingkatByQuery.execute(query);
    result.fold(
      (l) => emit(SearchError(l.message)),
      (r) async {
        List<bool> videoSingkatLabel = [];
        for (var item in r) {
          final label = await checkVideoSingkatBookmark.execute(item.id);
          videoSingkatLabel.add(label);
        }
        emit(GetVideoSingkatSearchSuccess(r, videoSingkatLabel));
      },
    );
  }
}
