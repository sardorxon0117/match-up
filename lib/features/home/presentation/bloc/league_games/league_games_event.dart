part of 'league_games_bloc.dart';

abstract class LeagueGamesEvent extends Equatable {
  LeagueGamesEvent();

  @override
  List<Object?> get props => [];
}

class LeagueGamesRequested extends LeagueGamesEvent {
  final int leagueId;
  final int season;

  LeagueGamesRequested({required this.leagueId, required this.season});

  @override
  List<Object?> get props => [leagueId, season];
}