import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/theme.dart';
import 'package:publico/domain/usecases/admin/get_infographic_themes_by_uid.dart';
import 'package:publico/domain/usecases/admin/post_infographic.dart';
import 'package:publico/domain/usecases/admin/post_infographic_theme.dart';

part 'infographic_state.dart';

class InfographicCubit extends Cubit<InfographicState> {
  InfographicCubit(
      {required this.postInfographicTheme,
      required this.getInfographicThemesByUid,
      required this.postInfographic})
      : super(InfographicInitial());

  final PostInfographic postInfographic;
  final PostInfographicTheme postInfographicTheme;
  final GetInfographicThemesByUid getInfographicThemesByUid;

  void postNewInfographicTheme(
      String themeName, String destination, File themeImage) async {
    emit(InfographicLoading());
    final result = await postInfographicTheme.execute(
      themeName,
      themeImage,
      destination,
    );
    result.fold(
      (l) => emit(InfographicError(l.message)),
      (r) =>
          emit(const PostInfographicThemeSuccess('Tema berhasil ditambahkan')),
    );
  }

  void getInfographicThemesByUidFirestore(String uid) async {
    emit(GetInfographicThemesByUidLoading());
    final result = await getInfographicThemesByUid.execute(uid);
    result.fold(
      (l) => emit(GetInfographicThemesByUidError(l.message)),
      (r) => emit(GetInfographicThemesByUidSuccess(r)),
    );
  }

  void postInfographicFirestore(
      String themeId, String title, List sources, String destination) async {
    emit(PostInfographicLoading());
    final result =
        await postInfographic.execute(themeId, title, sources, destination);
    result.fold(
      (l) => emit(PostInfographicError(l.message)),
      (r) =>
          emit(const PostInfographicSuccess('Infografis berhasil ditambahkan')),
    );
  }
}
