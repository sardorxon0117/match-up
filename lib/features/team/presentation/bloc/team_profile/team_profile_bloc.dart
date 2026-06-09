import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchup/features/team/domain/usecases/get_team_usecase.dart';

import '../../../domain/entities/team.dart';


part 'team_profile_event.dart';
part 'team_profile_state.dart';

class TeamProfileBloc extends Bloc<TeamProfileEvent, TeamProfileState> {
  GetTeamUsecase getTeamUsecase;

  TeamProfileBloc({
    required this.getTeamUsecase
  }) : super(TeamProfileInitial()) {
    on<TeamProfileRequested>(getTeam);
  }

  Future<void> getTeam(
      TeamProfileRequested event,
      Emitter<TeamProfileState> emit
      ) async {
    emit(TeamProfileLoading());
    final result = await getTeamUsecase.call(teamId: event.teamId);
    result.fold(
            (failure) => emit(TeamProfileError(message: failure.message)),
            (team) => emit(TeamProfileLoaded(team: team))
    );
  }
}
