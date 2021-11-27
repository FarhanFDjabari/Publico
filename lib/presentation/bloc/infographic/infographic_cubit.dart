import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/entities/theme.dart';
import 'package:publico/domain/usecases/admin/delete_infographic_post.dart';
import 'package:publico/domain/usecases/admin/edit_infographic_post.dart';
import 'package:publico/domain/usecases/admin/get_infographic_by_theme_id.dart';
import 'package:publico/domain/usecases/admin/get_infographic_posts_by_uid_query.dart';
import 'package:publico/domain/usecases/admin/get_infographic_themes_by_uid.dart';
import 'package:publico/domain/usecases/admin/post_infographic.dart';
import 'package:publico/domain/usecases/admin/post_infographic_theme.dart';
import 'package:publico/domain/usecases/user/check_infographic_bookmark.dart';
import 'package:publico/domain/usecases/user/get_infographic_bookmark_status.dart';
import 'package:publico/domain/usecases/user/get_infographics_by_query.dart';
import 'package:publico/domain/usecases/user/remove_infographic_from_bookmark.dart';
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
    required this.getInfographicPostsByUidQuery,
    required this.saveInfographic,
    required this.removeInfographicFromBookmark,
    required this.getInfographicBookmarkStatus,
    required this.checkInfographicBookmark,
    required this.editInfographicPost,
  }) : super(InfographicInitial());

  final PostInfographic postInfographic;
  final PostInfographicTheme postInfographicTheme;
  final GetInfographicThemesByUid getInfographicThemesByUid;
  final GetInfographicsByThemeId getInfographicsByThemeId;
  final DeleteInfographicPost deleteInfographicPost;
  final GetInfographicsByQuery getInfographicsByQuery;
  final GetInfographicPostsByUidQuery getInfographicPostsByUidQuery;
  final SaveInfographic saveInfographic;
  final RemoveInfographicFromBookmark removeInfographicFromBookmark;
  final GetInfographicBookmarkStatus getInfographicBookmarkStatus;
  final CheckInfographicBookmark checkInfographicBookmark;
  final EditInfographicPost editInfographicPost;

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

  void getInfographicPostsByUidQueryFirestore(String uid, String query) async {
    emit(InfographicLoading());
    final result = await getInfographicPostsByUidQuery.execute(uid, query);
    result.fold(
      (l) => emit(InfographicError(l.message)),
      (r) => emit(GetInfographicsByUidQuerySuccess(r)),
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

  void editInfographicFirestore(String id, String themeId, String themeName,
      String title, List oldSources, List newSources) async {
    emit(InfographicLoading());
    final result = await editInfographicPost.execute(
        id, themeId, themeName, title, oldSources, newSources);
    result.fold(
      (l) => emit(InfographicError(l.message)),
      (r) =>
          emit(const EditInfographicPostSuccess('Infografis berhasil diedit')),
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

  void getAdminInfographicPostsByQuery(String uid, String query) async {
    emit(InfographicLoading());
    final result = await getInfographicPostsByUidQuery.execute(uid, query);
    result.fold(
      (l) => emit(InfographicError(l.message)),
      (r) => emit(GetInfographicsByQuerySuccess(r)),
    );
  }

  void insertInfographicToBookmark(Infographic infographic, String id) async {
    emit(InfographicLoading());
    final result = await saveInfographic.execute(infographic, id);
    result.fold(
      (l) => emit(InfographicError(l.message)),
      (r) => emit(
          const InsertInfographicBookmarkSuccess('Ditambahkan ke bookmark')),
    );
  }

  void removeInfographicToBookmark(Infographic infographic, String id) async {
    emit(InfographicLoading());
    final result = await removeInfographicFromBookmark.execute(infographic, id);
    result.fold(
      (l) => emit(InfographicError(l.message)),
      (r) =>
          emit(const RemoveInfographicBookmarkSuccess('Dihapus dari bookmark')),
    );
  }

  void checkIsBookmarked(String id) async {
    final isBookmarked = await checkInfographicBookmark.execute(id);
    if (isBookmarked) {
      emit(InfographicBookmarked());
    } else {
      emit(InfographicNotBookmarked());
    }
  }
}
