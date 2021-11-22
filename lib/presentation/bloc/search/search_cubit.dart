import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/domain/entities/video_singkat.dart';
import 'package:publico/domain/usecases/user/get_infographics_by_query.dart';
import 'package:publico/domain/usecases/user/get_video_materi_by_query.dart';
import 'package:publico/domain/usecases/user/get_video_singkat_by_query.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    required this.getVideoMateriByQuery,
    required this.getInfographicByQuery,
    required this.getVideoSingkatByQuery,
  }) : super(SearchInitial());
  final GetVideoMateriByQuery getVideoMateriByQuery;
  final GetInfographicsByQuery getInfographicByQuery;
  final GetVideoSingkatByQuery getVideoSingkatByQuery;

  void getVideoMateriFromSearch(String query) async {
    emit(SearchLoading());
    final result = await getVideoMateriByQuery.execute(query);
    result.fold(
      (l) => emit(SearchError(l.message)),
      (r) => emit(GetVideoMateriSearchSuccess(r)),
    );
  }

  void getInfographicFromSearch(String query) async {
    emit(SearchLoading());
    final result = await getInfographicByQuery.execute(query);
    result.fold(
      (l) => emit(SearchError(l.message)),
      (r) => emit(GetInfographicSearchSuccess(r)),
    );
  }

  void getVideoSingkatFromSearch(String query) async {
    emit(SearchLoading());
    final result = await getVideoSingkatByQuery.execute(query);
    result.fold(
      (l) => emit(SearchError(l.message)),
      (r) => emit(GetVideoSingkatSearchSuccess(r)),
    );
  }

  // void getAllFromBookmark() async {
  //   emit(SearchLoading());
  //   final result = await getAllBookmark.execute();
  //   result.fold(
  //     (l) => emit(SearchError(l.message)),
  //     (r) => emit(GetAllSearchSuccess(r)),
  //   );
  // }
}
