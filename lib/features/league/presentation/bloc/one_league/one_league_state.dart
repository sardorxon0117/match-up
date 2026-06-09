part of 'one_league_bloc.dart';

abstract class OneLeagueState extends Equatable {
  OneLeagueState();

  @override
  List<Object?> get props => [];
}

class OneLeagueInitial extends OneLeagueState {}

class OneLeagueLoading extends OneLeagueState {}

class OneLeagueLoaded extends OneLeagueState {
  Leaguee leaguee;

  OneLeagueLoaded({required this.leaguee});

  @override
  List<Object?> get props => [leaguee];
}

class OneLeagueError extends OneLeagueState {
  String message;

  OneLeagueError({required this.message});

  @override
  List<Object?> get props => [message];
}