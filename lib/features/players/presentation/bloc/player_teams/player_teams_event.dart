part of 'player_teams_bloc.dart';

abstract class PlayerTeamsEvent extends Equatable {
  PlayerTeamsEvent();

  @override
  List<Object?> get props => [];
}

class PlayerTeamsRequested extends PlayerTeamsEvent {
  final int playerId;
  PlayerTeamsRequested({required this.playerId});

  @override
  List<Object?> get props => [];
}