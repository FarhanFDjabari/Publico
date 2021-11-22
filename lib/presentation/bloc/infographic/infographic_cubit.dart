import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/entities/theme.dart';
import 'package:publico/domain/usecases/admin/delete_infographic_post.dart';
import 'package:publico/domain/usecases/admin/get_infographic_by_theme_id.dart';
import 'package:publico/domain/usecases/admin/get_infographic_themes_by_uid.dart';
import 'package:publico/domain/usecases/admin/post_infographic.dart';
import 'package:publico/domain/usecases/admin/post_infographic_theme.dart';
import 'package:publico/domain/usecases/user/get_infographics_by_query.dart';
import 'package:publico/domain/usecases/user/save_infographic.dart';

part 'infographic_state.dart';

class InfographicCubit extends Cubit<InfographicState> {
  InfographicCubit({
    required this.postInfographicTheme,
    required this.getInfographicThemesByUid,
    required this.postInfographic,
    required this.getInfographicsByThemeId,
    required this.deleteInfographicPost,
    required this.getInfographicsByQuery,
    required this.saveInfographic,
  }) : super(InfographicInitial());

  final PostInfographic postInfographic;
  final PostInfographicTheme postInfographicTheme;
  final GetInfographicThemesByUid getInfographicThemesByUid;
  final GetInfographicsByThemeId getInfographicsByThemeId;
  final DeleteInfographicPost deleteInfographicPost;
  final GetInfographicsByQuery getInfographicsByQuery;
  final SaveInfographic saveInfographic;

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

  void getInfographicsByThemeIdFirestore(String themeId) async {
    emit(GetInfographicsByThemeIdLoading());
    final result = await getInfographicsByThemeId.execute(themeId);
    result.fold((l) => emit(GetInfographicsByThemeIdError(l.message)),
        (r) => emit(GetInfographicsByThemeIdSuccess(r)));
  }

  void getInfographicThemesByUidFirestore(String uid) async {
    emit(GetInfographicThemesByUidLoading());
    final result = await getInfographicThemesByUid.execute(uid);
    result.fold(
      (l) => emit(GetInfographicThemesByUidError(l.message)),
      (r) => emit(GetInfographicThemesByUidSuccess(r)),
    );
  }

  void deleteInfographicPostFirestore(
      String id, List<dynamic> illustrationsUrl, String collectionPath) async {
    emit(InfographicLoading());
    final result = await deleteInfographicPost.execute(
        id, illustrationsUrl, collectionPath);
    result.fold(
        (l) => emit(InfographicError(l.message)),
        (r) => emit(
            const DeleteInfographicSucces('Berhasil menghapus infografis')));
  }

  void postInfographicFirestore(String themeId, String themeName, String title,
      List sources, String destination) async {
    emit(PostInfographicLoading());
    final result = await postInfographic.execute(
        themeId, themeName, title, sources, destination);
    result.fold(
      (l) => emit(PostInfographicError(l.message)),
      (r) =>
          emit(const PostInfographicSuccess('Infografis berhasil ditambahkan')),
    );
  }

  void getInfographicPosts(String query) async {
    emit(InfographicLoading());
    final result = await getInfographicsByQuery.execute(query);
    result.fold(
      (l) => emit(InfographicError(l.message)),
      (r) => emit(GetInfographicsByQuerySuccess(r)),
    );
  }

  void insertInfographicToBookmark(Infographic infographic) async {
    emit(InfographicLoading());
    final result = await saveInfographic.execute(infographic);
    result.fold(
      (l) => emit(InfographicError(l.message)),
      (r) => emit(const InsertInfographicBookmarkSuccess(
          'Infografis berhasil ditambahkan pada bookmark')),
    );
  }
}
