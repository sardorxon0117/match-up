part of 'all_players_bloc.dart';

abstract class AllPlayersEvent extends Equatable {
  AllPlayersEvent();

  @override
  List<Object?> get props => [];
}

class AllPlayersRequested extends AllPlayersEvent {
  AllPlayersRequested();

  @override
  List<Object?> get props => [];
}

class SearchPlayersRequested extends AllPlayersEvent {
  final String query;

  SearchPlayersRequested({required this.query});

  @override
  List<Object?> get props => [query];
}