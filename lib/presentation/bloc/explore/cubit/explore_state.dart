part of 'explore_cubit.dart';

abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object> get props => [];
}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreSuccess extends ExploreState {
  final List<dynamic> exploreList;
  final List<bool> exploreLabel;
  const ExploreSuccess(this.exploreList, this.exploreLabel);

  @override
  List<Object> get props => [exploreList];
}

class ExploreError extends ExploreState {
  final String message;
  const ExploreError(this.message);

  @override
  List<Object> get props => [message];
}
