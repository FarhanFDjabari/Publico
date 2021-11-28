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
  final List<bool> videoMateriLabel;
  const GetVideoMateriSearchSuccess(
      this.videoMateriList, this.videoMateriLabel);

  @override
  List<Object> get props => [videoMateriList];
}

class GetInfographicSearchSuccess extends SearchState {
  final List<Infographic> infographicList;
  final List<bool> infographicLabel;
  const GetInfographicSearchSuccess(
      this.infographicList, this.infographicLabel);

  @override
  List<Object> get props => [infographicList];
}

class GetVideoSingkatSearchSuccess extends SearchState {
  final List<VideoSingkat> videoSingkatList;
  final List<bool> videoSingkatLabel;
  const GetVideoSingkatSearchSuccess(
      this.videoSingkatList, this.videoSingkatLabel);

  @override
  List<Object> get props => [videoSingkatList];
}

class GetAllSearchSuccess extends SearchState {
  final List<dynamic> allList;
  final List<bool> itemLabel;
  const GetAllSearchSuccess(this.allList, this.itemLabel);

  @override
  List<Object> get props => [allList];
}
