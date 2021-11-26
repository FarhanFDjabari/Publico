import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/video_singkat.dart';
import 'package:publico/domain/usecases/admin/delete_video_post.dart';
import 'package:publico/domain/usecases/admin/edit_video_singkat_post.dart';
import 'package:publico/domain/usecases/admin/get_video_singkat_posts_by_uid.dart';
import 'package:publico/domain/usecases/admin/get_video_singkat_posts_by_uid_query.dart';
import 'package:publico/domain/usecases/admin/post_video_singkat.dart';
import 'package:publico/domain/usecases/user/check_video_singkat_bookmark.dart';
import 'package:publico/domain/usecases/user/get_singkat_bookmark_status.dart';
import 'package:publico/domain/usecases/user/get_video_singkat_by_query.dart';
import 'package:publico/domain/usecases/user/remove_singkat_from_bookmark.dart';
import 'package:publico/domain/usecases/user/save_video_singkat.dart';

part 'video_singkat_state.dart';

class VideoSingkatCubit extends Cubit<VideoSingkatState> {
  VideoSingkatCubit({
    required this.postVideoSingkat,
    required this.getVideoSingkatPostsByUid,
    required this.getVideoSingkatPostsByUidQuery,
    required this.deleteVideoPost,
    required this.getVideoSingkatByQuery,
    required this.editVideoSingkatPost,
    required this.saveVideoSingkat,
    required this.removeSingkatFromBookmark,
    required this.getSingkatBookmarkStatus,
    required this.checkVideoSingkatBookmark,
  }) : super(VideoSingkatInitial());

  final PostVideoSingkat postVideoSingkat;
  final GetVideoSingkatPostsByUid getVideoSingkatPostsByUid;
  final GetVideoSingkatPostsByUidQuery getVideoSingkatPostsByUidQuery;
  final DeleteVideoPost deleteVideoPost;
  final GetVideoSingkatByQuery getVideoSingkatByQuery;
  final EditVideoSingkatPost editVideoSingkatPost;
  final SaveVideoSingkat saveVideoSingkat;
  final RemoveSingkatFromBookmark removeSingkatFromBookmark;
  final GetSingkatBookmarkStatus getSingkatBookmarkStatus;
  final CheckVideoSingkatBookmark checkVideoSingkatBookmark;

  void postVideoSingkatFirestore(
      String title,
      String description,
      String tiktokUrl,
      String videoDestination,
      String thumbnailDestination,
      File videoFile,
      File thumbnailFile,
      int duration) async {
    emit(PostVideoSingkatLoading());
    final result = await postVideoSingkat.execute(
        title,
        description,
        tiktokUrl,
        videoDestination,
        thumbnailDestination,
        videoFile,
        thumbnailFile,
        duration);
    result.fold(
      (l) => emit(VideoSingkatError(l.message)),
      (r) => emit(
          const PostVideoSingkatSuccess("Video singkat berhasil diposting")),
    );
  }

  void editVideoSingkatFirestore(
      String id,
      String title,
      String description,
      String oldVideoUrl,
      String oldThumbnailUrl,
      File newVideoFile,
      File newThumbnailFile,
      String tiktokUrl,
      int duration) async {
    emit(VideoSingkatLoading());
    final result = await editVideoSingkatPost.execute(
        id,
        title,
        description,
        oldVideoUrl,
        oldThumbnailUrl,
        newVideoFile,
        newThumbnailFile,
        tiktokUrl,
        duration);
    result.fold(
      (l) => emit(VideoSingkatError(l.message)),
      (r) =>
          emit(const EditVideoSingkatSuccess("Video singkat berhasil diedit")),
    );
  }

  void deleteVideoSingkatFirestore(String id, String videoUrl,
      String thumbnailUrl, String collectionPath) async {
    emit(DeleteVideoSingkatLoading());
    final result = await deleteVideoPost.execute(
      id,
      videoUrl,
      thumbnailUrl,
      collectionPath,
    );
    result.fold(
      (l) => emit(VideoSingkatError(l.message)),
      (r) => emit(
          const DeleteVideoSingkatSuccess('Berhasil menghapus video singkat')),
    );
  }

  void getVideoSingkatPostsByUidFirestore(String uid) async {
    emit(GetVideoSingkatPostsByUidLoading());
    final result = await getVideoSingkatPostsByUid.execute(uid);
    result.fold(
        (l) => emit(
            const GetVideoSingkatPostsByUidError("Tidak ada video singkat")),
        (r) => emit(GetVideoSingkatPostsByUidSuccess(r)));
  }

  void getVideoSingkatPostsByUidQueryFirestore(String uid, String query) async {
    emit(GetVideoSingkatPostsByUidLoading());
    final result = await getVideoSingkatPostsByUidQuery.execute(uid, query);
    result.fold(
      (l) =>
          emit(const GetVideoSingkatPostsByUidError("Tidak ada video singkat")),
      (r) => emit(GetVideoSingkatPostsByUidSuccess(r)),
    );
  }

  void getVideoSingkatPosts(String query) async {
    emit(VideoSingkatLoading());
    final result = await getVideoSingkatByQuery.execute(query);
    result.fold(
      (l) => emit(VideoSingkatError(l.message)),
      (r) => emit(GetVideoSingkatByQuerySuccess(r)),
    );
  }

  void insertVideoSingkatToBookmark(VideoSingkat video) async {
    emit(VideoSingkatLoading());
    final result = await saveVideoSingkat.execute(video);
    result.fold(
      (l) => emit(VideoSingkatError(l.message)),
      (r) => emit(
          const InsertVideoSingkatBookmarkSuccess('Ditambahkan ke bookmark')),
    );
  }

  void removeVideoSingkatToBookmark(VideoSingkat video) async {
    emit(VideoSingkatLoading());
    final result = await removeSingkatFromBookmark.execute(video);
    result.fold(
      (l) => emit(VideoSingkatError(l.message)),
      (r) => emit(
          const RemoveVideoSingkatBookmarkSuccess('Dihapus dari bookmark')),
    );
  }

  void checkIsBookmarked(String id) async {
    final isBookmarked = await checkVideoSingkatBookmark.execute(id);
    if (isBookmarked) {
      emit(VideoSingkatBookmarked());
    } else {
      emit(VideoSingkatNotBookmarked());
    }
  }
}
