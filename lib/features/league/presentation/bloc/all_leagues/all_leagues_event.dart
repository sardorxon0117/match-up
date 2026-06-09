part of 'all_leagues_bloc.dart';

abstract class AllLeaguesEvent extends Equatable {
  AllLeaguesEvent();

  @override
  List<Object?> get props => [];
}

class AllLeaguesRequested extends AllLeaguesEvent {
  AllLeaguesRequested();

  @override
  List<Object?> get props => [];
}

class SearchLeaguesRequested extends AllLeaguesEvent {
  final String query;
  SearchLeaguesRequested({required this.query});

  @override
  List<Object?> get props => [query];
}