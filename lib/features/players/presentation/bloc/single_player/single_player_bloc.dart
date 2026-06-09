import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchup/features/players/domain/entitys/all_players.dart';
import 'package:matchup/features/players/domain/usecases/get_all_players_usecase.dart';
import 'package:matchup/features/players/domain/usecases/get_single_player_usecase.dart';
import 'package:matchup/features/players/domain/usecases/search_players_usecase.dart';

import '../../../domain/entitys/one_player.dart';

part 'single_player_event.dart';
part 'single_player_state.dart';

class SinglePlayerBloc extends Bloc<SinglePlayerEvent, SinglePlayerState> {
  GetSinglePlayerUsecase getSinglePlayerUsecase;

  SinglePlayerBloc({
    required this.getSinglePlayerUsecase
  }) : super(SinglePlayerInitial()) {
    on<SinglePlayerRequested>(getSinglelLayer);
  }

  Future<void> getSinglelLayer(
      SinglePlayerRequested event,
      Emitter<SinglePlayerState> emit
      ) async {
    emit(SinglePlayerLoading());
    final result = await getSinglePlayerUsecase.call(playerId: event.playerId);
    result.fold(
            (failure) => emit(SinglePlayerError(message: failure.message)),
            (player) => emit(SinglePlayerLoaded(player: player))
    );
  }
}
