import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/domain/entities/video_singkat.dart';
import 'package:publico/domain/usecases/user/check_infographic_bookmark.dart';
import 'package:publico/domain/usecases/user/check_video_materi_bookmark.dart';
import 'package:publico/domain/usecases/user/check_video_singkat_bookmark.dart';
import 'package:publico/domain/usecases/user/get_explore.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit({
    required this.getExplore,
    required this.checkInfographicBookmark,
    required this.checkVideoSingkatBookmark,
    required this.checkVideoMateriBookmark,
  }) : super(ExploreInitial());

  final GetExplore getExplore;
  final CheckInfographicBookmark checkInfographicBookmark;
  final CheckVideoSingkatBookmark checkVideoSingkatBookmark;
  final CheckVideoMateriBookmark checkVideoMateriBookmark;

  void getExploreData() async {
    emit(ExploreLoading());
    final result = await getExplore.execute();
    result.fold(
      (l) => emit(ExploreError(l.message)),
      (r) async {
        List<bool> exploreLabel = [];
        for (var item in r) {
          if (item is Infographic) {
            final label = await checkInfographicBookmark.execute(item.id);
            exploreLabel.add(label);
          } else if (item is VideoSingkat) {
            final label = await checkVideoSingkatBookmark.execute(item.id);
            exploreLabel.add(label);
          } else if (item is VideoMateri) {
            final label = await checkVideoMateriBookmark.execute(item.id);
            exploreLabel.add(label);
          }
        }
        emit(ExploreSuccess(r, exploreLabel));
      },
    );
  }
}
