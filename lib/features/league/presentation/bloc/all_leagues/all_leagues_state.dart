part of 'all_leagues_bloc.dart';

abstract class AllLeaguesState extends Equatable {
  AllLeaguesState();

  @override
  List<Object?> get props => [];
}

class AllLeaguesInitial extends AllLeaguesState {}

class AllLeaguesLoading extends AllLeaguesState {}

class AllLeaguesLoaded extends AllLeaguesState {
  final Leaguees leaguees;

  AllLeaguesLoaded({required this.leaguees});

  @override
  List<Object?> get props => [leaguees];
}

class AllLeaguesError extends AllLeaguesState {
  final String message;

  AllLeaguesError({required this.message});

  @override
  List<Object?> get props => [message];
}