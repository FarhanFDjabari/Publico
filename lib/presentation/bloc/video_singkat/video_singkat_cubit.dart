import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/entities/video_singkat.dart';
import 'package:publico/domain/usecases/admin/get_video_singkat_posts_by_uid.dart';
import 'package:publico/domain/usecases/admin/delete_video_post.dart';
import 'package:publico/domain/usecases/admin/post_video_singkat.dart';
import 'package:publico/domain/usecases/user/get_video_singkat_by_query.dart';

part 'video_singkat_state.dart';

class VideoSingkatCubit extends Cubit<VideoSingkatState> {
  VideoSingkatCubit({
    required this.postVideoSingkat,
    required this.getVideoSingkatPostsByUid,
    required this.deleteVideoPost,
    required this.getVideoSingkatByQuery,
  }) : super(VideoSingkatInitial());

  final PostVideoSingkat postVideoSingkat;
  final GetVideoSingkatPostsByUid getVideoSingkatPostsByUid;
  final DeleteVideoPost deleteVideoPost;
  final GetVideoSingkatByQuery getVideoSingkatByQuery;

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

  void getVideoSingkatPosts(String query) async {
    emit(VideoSingkatLoading());
    final result = await getVideoSingkatByQuery.execute(query);
    result.fold(
      (l) => emit(VideoSingkatError(l.message)),
      (r) => emit(GetVideoSingkatByQuerySuccess(r)),
    );
  }
}
