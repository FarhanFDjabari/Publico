part of 'video_materi_cubit.dart';

abstract class VideoMateriState extends Equatable {
  const VideoMateriState();
}

class VideoMateriInitial extends VideoMateriState {
  @override
  List<Object?> get props => [];
}

class VideoMateriLoading extends VideoMateriState {
  @override
  List<Object?> get props => [];
}

class PostVideoMateriLoading extends VideoMateriState {
  @override
  List<Object> get props => [];
}

class DeleteVideoMateriLoading extends VideoMateriState {
  @override
  List<Object> get props => [];
}

class PostVideoMateriSuccess extends VideoMateriState {
  final String message;
  const PostVideoMateriSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class DeleteVideoMateriSuccess extends VideoMateriState {
  final String message;
  const DeleteVideoMateriSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class VideoMateriError extends VideoMateriState {
  final String message;
  const VideoMateriError(this.message);
  @override
  List<Object> get props => [message];
}

class GetVideoMateriPostsByUidLoading extends VideoMateriState {
  @override
  List<Object> get props => [];
}

class GetVideoMateriPostsByUidSuccess extends VideoMateriState {
  final List<VideoMateri> videoMateriList;
  const GetVideoMateriPostsByUidSuccess(this.videoMateriList);
  @override
  List<Object> get props => [videoMateriList];
}

class GetVideoMateriPostsByUidError extends VideoMateriState {
  final String message;
  const GetVideoMateriPostsByUidError(this.message);

  @override
  List<Object> get props => [message];
}

class GetVideoMateriByQuerySuccess extends VideoMateriState {
  final List<VideoMateri> videoMateriList;
  const GetVideoMateriByQuerySuccess(this.videoMateriList);

  @override
  List<Object?> get props => [videoMateriList];
}

class InsertVideoMateriBookmarkSuccess extends VideoMateriState {
  final String message;
  const InsertVideoMateriBookmarkSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class RemoveVideoMateriBookmarkSuccess extends VideoMateriState {
  final String message;
  const RemoveVideoMateriBookmarkSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class VideoMateriBookmarked extends VideoMateriState {
  @override
  List<Object?> get props => [];
}

class VideoMateriNotBookmarked extends VideoMateriState {
  @override
  List<Object?> get props => [];
}
