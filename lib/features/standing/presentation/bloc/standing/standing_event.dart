part of 'standing_bloc.dart';

abstract class StandingEvent extends Equatable {
  StandingEvent();

  @override
  List<Object?> get props => [];
}

class StandingRequested extends StandingEvent {
  final int leagueId;
  final int season;

  StandingRequested({required this.leagueId, required this.season});

  @override
  List<Object?> get props => [leagueId, season];
}