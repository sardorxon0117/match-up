part of 'player_teams_bloc.dart';

abstract class PlayerTeamsState extends Equatable {
  PlayerTeamsState();

  @override
  List<Object?> get props => [];
}

class PlayerTeamsInitial extends PlayerTeamsState {}

class PlayerTeamsLoading extends PlayerTeamsState {}

class PlayerTeamsLoaded extends PlayerTeamsState {
  PlayerTeams playerTeams;

  PlayerTeamsLoaded({required this.playerTeams});

  @override
  List<Object?> get props => [playerTeams];
}

class PlayerTeamsError extends PlayerTeamsState {
  String message;

  PlayerTeamsError({required this.message});

  @override
  List<Object?> get props => [message];
}