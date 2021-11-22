part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String message;
  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class GetVideoMateriSearchSuccess extends SearchState {
  final List<VideoMateri> videoMateriList;
  const GetVideoMateriSearchSuccess(this.videoMateriList);

  @override
  List<Object> get props => [videoMateriList];
}

class GetInfographicSearchSuccess extends SearchState {
  final List<Infographic> infographicList;
  const GetInfographicSearchSuccess(this.infographicList);

  @override
  List<Object> get props => [infographicList];
}

class GetVideoSingkatSearchSuccess extends SearchState {
  final List<VideoSingkat> videoSingkatList;
  const GetVideoSingkatSearchSuccess(this.videoSingkatList);

  @override
  List<Object> get props => [videoSingkatList];
}

class GetAllSearchSuccess extends SearchState {
  final List<dynamic> bookmarks;
  const GetAllSearchSuccess(this.bookmarks);

  @override
  List<Object> get props => [bookmarks];
}
