part of 'infographic_cubit.dart';

abstract class InfographicState extends Equatable {
  const InfographicState();
}

class InfographicInitial extends InfographicState {
  @override
  List<Object> get props => [];
}

class InfographicLoading extends InfographicState {
  @override
  List<Object> get props => [];
}

class PostInfographicThemeSuccess extends InfographicState {
  final String message;
  const PostInfographicThemeSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class InfographicError extends InfographicState {
  final String message;
  const InfographicError(this.message);
  @override
  List<Object> get props => [message];
}

class GetInfographicsByThemeIdLoading extends InfographicState {
  @override
  List<Object?> get props => [];
}

class GetInfographicsByThemeIdSuccess extends InfographicState {
  final List<Infographic> infographicList;
  const GetInfographicsByThemeIdSuccess(this.infographicList);

  @override
  List<Object?> get props => [infographicList];
}

class GetInfographicThemeNameSuccess extends InfographicState {
  final String themeName;
  const GetInfographicThemeNameSuccess(this.themeName);

  @override
  List<Object?> get props => [themeName];
}

class GetInfographicsByThemeIdError extends InfographicState {
  final String message;
  const GetInfographicsByThemeIdError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetInfographicThemesByUidLoading extends InfographicState {
  @override
  List<Object?> get props => [];
}

class GetInfographicThemesByUidSuccess extends InfographicState {
  final List<Theme> themeList;
  const GetInfographicThemesByUidSuccess(this.themeList);

  @override
  List<Object?> get props => [themeList];
}

class GetInfographicThemesByUidError extends InfographicState {
  final String message;
  const GetInfographicThemesByUidError(this.message);

  @override
  List<Object?> get props => [message];
}

class PostInfographicLoading extends InfographicState {
  @override
  List<Object?> get props => [];
}

class PostInfographicSuccess extends InfographicState {
  final String message;
  const PostInfographicSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class PostInfographicError extends InfographicState {
  final String message;
  const PostInfographicError(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteInfographicSucces extends InfographicState {
  final String message;
  const DeleteInfographicSucces(this.message);

  @override
  List<Object?> get props => [message];
}

class GetInfographicsByQuerySuccess extends InfographicState {
  final List<Infographic> infographicList;
  const GetInfographicsByQuerySuccess(this.infographicList);

  @override
  List<Object?> get props => [infographicList];
}

class GetInfographicsByUidQuerySuccess extends InfographicState {
  final List<Infographic> infographicList;
  const GetInfographicsByUidQuerySuccess(this.infographicList);

  @override
  List<Object?> get props => [infographicList];
}

class InsertInfographicBookmarkSuccess extends InfographicState {
  final String message;
  const InsertInfographicBookmarkSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class RemoveInfographicBookmarkSuccess extends InfographicState {
  final String message;
  const RemoveInfographicBookmarkSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class InfographicBookmarked extends InfographicState {
  @override
  List<Object?> get props => [];
}

class InfographicNotBookmarked extends InfographicState {
  @override
  List<Object?> get props => [];
}
