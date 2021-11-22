part of 'bookmark_cubit.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkError extends BookmarkState {
  final String message;
  const BookmarkError(this.message);

  @override
  List<Object> get props => [message];
}

class GetVideoMateriBookmarkSuccess extends BookmarkState {
  final List<VideoMateri> videoMateriList;
  const GetVideoMateriBookmarkSuccess(this.videoMateriList);

  @override
  List<Object> get props => [videoMateriList];
}

class GetInfographicBookmarkSuccess extends BookmarkState {
  final List<Infographic> infographicList;
  const GetInfographicBookmarkSuccess(this.infographicList);

  @override
  List<Object> get props => [infographicList];
}

class GetVideoSingkatBookmarkSuccess extends BookmarkState {
  final List<VideoSingkat> videoSingkatList;
  const GetVideoSingkatBookmarkSuccess(this.videoSingkatList);

  @override
  List<Object> get props => [videoSingkatList];
}

class GetAllBookmarkSuccess extends BookmarkState {
  final List<dynamic> bookmarks;
  const GetAllBookmarkSuccess(this.bookmarks);

  @override
  List<Object> get props => [bookmarks];
}
