part of 'league_games_bloc.dart';

abstract class LeagueGamesState extends Equatable {
  LeagueGamesState();

  @override
  List<Object?> get props => [];
}


class LeagueGamesInitial extends LeagueGamesState {}

class LeagueGamesLoading extends LeagueGamesState {}

class LeagueGamesLoaded extends LeagueGamesState {
  final AllGames allGames;

  LeagueGamesLoaded(this.allGames);

  @override
  List<Object?> get props => [allGames];
}

class LeagueGamesError extends LeagueGamesState {
  final String message;

  LeagueGamesError(this.message);

  @override
  List<Object?> get props => [message];
}