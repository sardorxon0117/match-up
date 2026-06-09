part of 'date_games_bloc.dart';

abstract class DateGamesState extends Equatable {
  const DateGamesState();

  @override
  List<Object?> get props => [];
}

class DateGamesInitial extends DateGamesState {}

class DateGamesLoading extends DateGamesState {}

class DateGamesLoaded extends DateGamesState {
  final AllGames allGames;

  DateGamesLoaded(this.allGames);

  @override
  List<Object?> get props => [allGames];
}

class DateGamesError extends DateGamesState {
  final String message;

  DateGamesError(this.message);

  @override
  List<Object?> get props => [message];
}