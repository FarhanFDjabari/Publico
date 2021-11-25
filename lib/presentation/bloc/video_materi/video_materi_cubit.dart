import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/domain/usecases/admin/delete_video_post.dart';
import 'package:publico/domain/usecases/admin/get_video_materi_posts_by_uid.dart';
import 'package:publico/domain/usecases/admin/get_video_materi_posts_by_uid_query.dart';
import 'package:publico/domain/usecases/admin/post_video_materi.dart';
import 'package:publico/domain/usecases/user/check_video_materi_bookmark.dart';
import 'package:publico/domain/usecases/user/get_materi_bookmark_status.dart';
import 'package:publico/domain/usecases/user/get_video_materi_by_query.dart';
import 'package:publico/domain/usecases/user/remove_materi_from_bookmark.dart';
import 'package:publico/domain/usecases/user/save_video_materi.dart';

part 'video_materi_state.dart';

class VideoMateriCubit extends Cubit<VideoMateriState> {
  VideoMateriCubit({
    required this.postVideoMateri,
    required this.getVideoMateriPostsByUid,
    required this.getVideoMateriPostsByUidQuery,
    required this.deleteVideoPost,
    required this.getVideoMateriByQuery,
    required this.saveVideoMateri,
    required this.removeMateriFromBookmark,
    required this.getMateriBookmarkStatus,
    required this.checkVideoMateriBookmark,
  }) : super(VideoMateriInitial());

  final PostVideoMateri postVideoMateri;
  final GetVideoMateriPostsByUid getVideoMateriPostsByUid;
  final GetVideoMateriPostsByUidQuery getVideoMateriPostsByUidQuery;
  final DeleteVideoPost deleteVideoPost;
  final GetVideoMateriByQuery getVideoMateriByQuery;
  final SaveVideoMateri saveVideoMateri;
  final RemoveMateriFromBookmark removeMateriFromBookmark;
  final GetMateriBookmarkStatus getMateriBookmarkStatus;
  final CheckVideoMateriBookmark checkVideoMateriBookmark;

  void postVideoMateriFirestore(
      String title,
      String description,
      String videoDestination,
      String thumbnailDestination,
      File videoFile,
      File thumbnailFile,
      int duration) async {
    emit(PostVideoMateriLoading());
    final result = await postVideoMateri.execute(
        title,
        description,
        videoDestination,
        thumbnailDestination,
        videoFile,
        thumbnailFile,
        duration);
    result.fold(
      (l) => emit(VideoMateriError(l.message)),
      (r) =>
          emit(const PostVideoMateriSuccess("Video materi berhasil diposting")),
    );
  }

  void getVideoMateriPostsByUidFirestore(String uid) async {
    emit(GetVideoMateriPostsByUidLoading());
    final result = await getVideoMateriPostsByUid.execute(uid);
    result.fold(
      (l) => emit(GetVideoMateriPostsByUidError(l.message)),
      (r) => emit(GetVideoMateriPostsByUidSuccess(r)),
    );
  }

  void getVideoMateriPostsByUidQueryFirestore(String uid, String query) async {
    emit(GetVideoMateriPostsByUidLoading());
    final result = await getVideoMateriPostsByUidQuery.execute(uid, query);
    result.fold(
      (l) => emit(GetVideoMateriPostsByUidError(l.message)),
      (r) => emit(GetVideoMateriPostsByUidSuccess(r)),
    );
  }

  void deleteVideoMateriFirestore(String id, String videoUrl,
      String thumbnailUrl, String collectionPath) async {
    emit(DeleteVideoMateriLoading());
    final result = await deleteVideoPost.execute(
      id,
      videoUrl,
      thumbnailUrl,
      collectionPath,
    );
    result.fold(
      (l) => emit(VideoMateriError(l.message)),
      (r) => emit(
          const DeleteVideoMateriSuccess('Berhasil menghapus video materi')),
    );
  }

  void getVideoMateriPosts(String query) async {
    emit(VideoMateriLoading());
    final result = await getVideoMateriByQuery.execute(query);
    result.fold(
      (l) => emit(VideoMateriError(l.message)),
      (r) => emit(GetVideoMateriByQuerySuccess(r)),
    );
  }

  void insertVideoMateriToBookmark(VideoMateri videoMateri) async {
    emit(VideoMateriLoading());
    final result = await saveVideoMateri.execute(videoMateri);
    result.fold(
      (l) => emit(VideoMateriError(l.message)),
      (r) => emit(
          const InsertVideoMateriBookmarkSuccess('Ditambahkan ke bookmark')),
    );
  }

  void removeVideoMateriToBookmark(VideoMateri videoMateri) async {
    emit(VideoMateriLoading());
    final result = await removeMateriFromBookmark.execute(videoMateri);
    result.fold(
      (l) => emit(VideoMateriError(l.message)),
      (r) =>
          emit(const RemoveVideoMateriBookmarkSuccess('Dihapus dari bookmark')),
    );
  }

  void checkIsBookmarked(String id) async {
    final isBookmarked = await checkVideoMateriBookmark.execute(id);
    if (isBookmarked) {
      emit(VideoMateriBookmarked());
    } else {
      emit(VideoMateriNotBookmarked());
    }
  }
}
