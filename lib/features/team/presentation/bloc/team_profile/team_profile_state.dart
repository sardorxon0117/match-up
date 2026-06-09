part of 'team_profile_bloc.dart';



abstract class TeamProfileState extends Equatable {
  TeamProfileState();

  @override
  List<Object?> get props => [];
}

class TeamProfileInitial extends TeamProfileState {}

class TeamProfileLoading extends TeamProfileState {}

class TeamProfileLoaded extends TeamProfileState {
  TeamProfile team;

  TeamProfileLoaded({required this.team});

  @override
  List<Object?> get props => [team];
}

class TeamProfileError extends TeamProfileState {
  String message;

  TeamProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}