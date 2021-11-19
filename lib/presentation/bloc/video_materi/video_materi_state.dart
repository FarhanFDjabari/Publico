part of 'video_materi_cubit.dart';

abstract class VideoMateriState extends Equatable {
  const VideoMateriState();
}

class VideoMateriInitial extends VideoMateriState {
  @override
  List<Object?> get props => [];
}

class PostVideoMateriLoading extends VideoMateriState {
  @override
  List<Object> get props => [];
}

class PostVideoMateriSuccess extends VideoMateriState {
  final String message;
  const PostVideoMateriSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class VideoMateriError extends VideoMateriState {
  final String message;
  const VideoMateriError(this.message);
  @override
  List<Object> get props => [message];
}
