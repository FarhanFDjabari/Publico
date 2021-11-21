import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/usecases/user/get_explore.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit({required this.getExplore}) : super(ExploreInitial());

  final GetExplore getExplore;

  void getExploreData() async {
    emit(ExploreLoading());
    final result = await getExplore.execute();
    result.fold(
      (l) => emit(ExploreError(l.message)),
      (r) => emit(ExploreSuccess(r)),
    );
  }
}
