part of 'team_profile_bloc.dart';

abstract class TeamProfileEvent extends Equatable {
  TeamProfileEvent();

  @override
  List<Object?> get props => [];
}

class TeamProfileRequested extends TeamProfileEvent {
  final int teamId;
  TeamProfileRequested({required this.teamId});

  @override
  List<Object?> get props => [teamId];
}