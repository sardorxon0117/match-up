import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchup/features/players/domain/usecases/get_player_team_usecase.dart';
import '../../../domain/entitys/player_team.dart';

part 'player_teams_event.dart';

part 'player_teams_state.dart';

class PlayerTeamsBloc extends Bloc<PlayerTeamsEvent, PlayerTeamsState> {
  GetPlayerTeamUsecase getPlayerTeamUsecase;

  PlayerTeamsBloc({required this.getPlayerTeamUsecase})
    : super(PlayerTeamsInitial()) {
    on<PlayerTeamsRequested>(getPlayerTeams);
  }

  Future<void> getPlayerTeams(
    PlayerTeamsRequested event,
    Emitter<PlayerTeamsState> emit,
  ) async {
    emit(PlayerTeamsLoading());
    final result = await getPlayerTeamUsecase.call(playerId: event.playerId);
    result.fold(
      (failure) => emit(PlayerTeamsError(message: failure.message)),
      (player) => emit(PlayerTeamsLoaded(playerTeams: player)),
    );
  }
}
