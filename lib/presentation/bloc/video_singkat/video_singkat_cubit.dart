import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/usecases/admin/delete_video_post.dart';
import 'package:publico/domain/usecases/admin/post_video_singkat.dart';

part 'video_singkat_state.dart';

class VideoSingkatCubit extends Cubit<VideoSingkatState> {
  VideoSingkatCubit(
      {required this.postVideoSingkat, required this.deleteVideoPost})
      : super(VideoSingkatInitial());

  final PostVideoSingkat postVideoSingkat;
  final DeleteVideoPost deleteVideoPost;

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
}
