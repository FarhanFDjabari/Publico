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
