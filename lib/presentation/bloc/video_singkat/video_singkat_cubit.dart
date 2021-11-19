import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/usecases/admin/post_video_singkat.dart';

part 'video_singkat_state.dart';

class VideoSingkatCubit extends Cubit<VideoSingkatState> {
  VideoSingkatCubit({required this.postVideoSingkat})
      : super(VideoSingkatInitial());

  final PostVideoSingkat postVideoSingkat;

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
          const PostVideoSingkatSuccess("Video singkat berhasil diposting.")),
    );
  }
}
