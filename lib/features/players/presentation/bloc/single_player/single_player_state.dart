part of 'single_player_bloc.dart';


abstract class SinglePlayerState extends Equatable {
  SinglePlayerState();

  @override
  List<Object?> get props => [];
}

class SinglePlayerInitial extends SinglePlayerState {}

class SinglePlayerLoading extends SinglePlayerState {}

class SinglePlayerLoaded extends SinglePlayerState {
  PlayerProfile player;

  SinglePlayerLoaded({required this.player});

  @override
  List<Object?> get props => [player];
}

class SinglePlayerError extends SinglePlayerState {
  String message;

  SinglePlayerError({required this.message});

  @override
  List<Object?> get props => [message];
}