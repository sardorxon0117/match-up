part of 'one_game_bloc.dart';

abstract class OneGameState extends Equatable {
  OneGameState();

  @override
  List<Object?> get props => [];
}

class OneGameInitial extends OneGameState {}

class OneGameLoading extends OneGameState {}

class OneGameLoaded extends OneGameState {
  final OneGame game;

  OneGameLoaded(this.game);

  @override
  List<Object?> get props => [game];
}

class OneGameError extends OneGameState {
  final String message;

  OneGameError(this.message);

  @override
  List<Object?> get props => [message];
}