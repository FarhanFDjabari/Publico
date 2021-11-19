part of 'video_singkat_cubit.dart';

abstract class VideoSingkatState extends Equatable {
  const VideoSingkatState();

  @override
  List<Object> get props => [];
}

class VideoSingkatInitial extends VideoSingkatState {}

class PostVideoSingkatLoading extends VideoSingkatState {
  @override
  List<Object> get props => [];
}

class DeleteVideoSingkatLoading extends VideoSingkatState {
  @override
  List<Object> get props => [];
}

class PostVideoSingkatSuccess extends VideoSingkatState {
  final String message;
  const PostVideoSingkatSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class DeleteVideoSingkatSuccess extends VideoSingkatState {
  final String message;
  const DeleteVideoSingkatSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class VideoSingkatError extends VideoSingkatState {
  final String message;
  const VideoSingkatError(this.message);
  @override
  List<Object> get props => [message];
}

class GetVideoSingkatPostsByUidLoading extends VideoSingkatState {
  @override
  List<Object> get props => [];
}

class GetVideoSingkatPostsByUidSuccess extends VideoSingkatState {
  final List<VideoSingkat> videoSingkats;
  const GetVideoSingkatPostsByUidSuccess(this.videoSingkats);
  @override
  List<Object> get props => [videoSingkats];
}

class GetVideoSingkatPostsByUidError extends VideoSingkatState {
  final String message;
  const GetVideoSingkatPostsByUidError(this.message);

  @override
  List<Object> get props => [message];
}
