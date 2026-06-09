part of 'one_league_bloc.dart';

abstract class OneLeagueEvent extends Equatable {
  OneLeagueEvent();

  @override
  List<Object?> get props => [];
}

class OneLeagueRequested extends OneLeagueEvent {
  final int id;
  OneLeagueRequested({required this.id});

  @override
  List<Object?> get props => [id];
}