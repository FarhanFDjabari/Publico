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
  final List<bool> videoMateriLabels;
  const GetVideoMateriBookmarkSuccess(
      this.videoMateriList, this.videoMateriLabels);

  @override
  List<Object> get props => [videoMateriList, videoMateriLabels];
}

class GetInfographicBookmarkSuccess extends BookmarkState {
  final List<Infographic> infographicList;
  final List<bool> infographicLabels;
  const GetInfographicBookmarkSuccess(
      this.infographicList, this.infographicLabels);

  @override
  List<Object> get props => [infographicList];
}

class GetVideoSingkatBookmarkSuccess extends BookmarkState {
  final List<VideoSingkat> videoSingkatList;
  final List<bool> videoSingkatLabels;
  const GetVideoSingkatBookmarkSuccess(
      this.videoSingkatList, this.videoSingkatLabels);

  @override
  List<Object> get props => [videoSingkatList, videoSingkatLabels];
}

class GetAllBookmarkSuccess extends BookmarkState {
  final List<dynamic> bookmarks;
  final List<bool> bookmarkLabels;
  const GetAllBookmarkSuccess(this.bookmarks, this.bookmarkLabels);

  @override
  List<Object> get props => [bookmarks, bookmarkLabels];
}
