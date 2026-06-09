part of 'standing_bloc.dart';

abstract class StandingState extends Equatable {
  StandingState();

  @override
  List<Object?> get props => [];
}

class StandingInitial extends StandingState {}

class StandingLoading extends StandingState {}

class StandingLoaded extends StandingState {
  final Standingg standing;

  StandingLoaded(this.standing);

  @override
  List<Object?> get props => [standing];
}

class StandingError extends StandingState {
  final String message;

  StandingError(this.message);

  @override
  List<Object?> get props => [message];
}