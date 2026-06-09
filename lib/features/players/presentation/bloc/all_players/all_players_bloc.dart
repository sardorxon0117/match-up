import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchup/features/players/domain/entitys/all_players.dart';
import 'package:matchup/features/players/domain/usecases/get_all_players_usecase.dart';
import 'package:matchup/features/players/domain/usecases/search_players_usecase.dart';

part 'all_players_event.dart';

part 'all_players_state.dart';

class AllPlayersBloc extends Bloc<AllPlayersEvent, AllPlayersState> {
  GetAllPlayersUsecase getAllPlayersUsecase;
  SearchPlayersUsecase searchPlayersUsecase;

  AllPlayersBloc({
    required this.getAllPlayersUsecase,
    required this.searchPlayersUsecase,
  }) : super(AllPlayersInitial()) {
    on<AllPlayersRequested>(getAllPlayers);
    on<SearchPlayersRequested>(searchPlayers);
  }

  Future<void> getAllPlayers(
      AllPlayersRequested event,
      Emitter<AllPlayersState> emit
      ) async {
    emit(AllPlayersLoading());
    final result = await getAllPlayersUsecase.call();
    result.fold(
        (failure) => emit(AllPlayersError(message: failure.message)),
        (players) => emit(AllPlayersLoaded(players: players))
    );
  }

  Future<void> searchPlayers(
      SearchPlayersRequested event,
      Emitter<AllPlayersState> emit
      ) async {
    emit(AllPlayersLoading());
    final result = await searchPlayersUsecase.call(query: event.query);
    result.fold(
            (failure) => emit(AllPlayersError(message: failure.message)),
            (players) => emit(AllPlayersLoaded(players: players))
    );
  }
}
