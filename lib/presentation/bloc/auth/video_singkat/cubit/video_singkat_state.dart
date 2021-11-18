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

class PostVideoSingkatSuccess extends VideoSingkatState {
  @override
  List<Object> get props => [];
}

class VideoSingkatError extends VideoSingkatState {
  final String message;
  const VideoSingkatError(this.message);
  @override
  List<Object> get props => [message];
}
