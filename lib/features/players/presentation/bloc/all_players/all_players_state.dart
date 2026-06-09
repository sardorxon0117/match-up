part of 'all_players_bloc.dart';

abstract class AllPlayersState extends Equatable {
  AllPlayersState();

  @override
  List<Object?> get props => [];
}

class AllPlayersInitial extends AllPlayersState {}

class AllPlayersLoading extends AllPlayersState {}

class AllPlayersLoaded extends AllPlayersState {
  AllPlayers players;

  AllPlayersLoaded({required this.players});

  @override
  List<Object?> get props => [players];
}

class AllPlayersError extends AllPlayersState {
  String message;

  AllPlayersError({required this.message});

  @override
  List<Object?> get props => [message];
}