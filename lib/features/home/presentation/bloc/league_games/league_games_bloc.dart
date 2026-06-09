import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchup/features/home/domain/entities/all_games.dart';
import 'package:matchup/features/home/domain/usecases/get_all_games_by_league_usecase.dart';

part 'league_games_event.dart';

part 'league_games_state.dart';

class LeagueGamesBloc extends Bloc<LeagueGamesEvent, LeagueGamesState> {
  final GetAllGamesByLeagueUsecase getAllGamesByLeagueUsecase;

  LeagueGamesBloc({required this.getAllGamesByLeagueUsecase})
    : super(LeagueGamesInitial()) {
    on<LeagueGamesRequested>(getGamesByLeague);
  }

  Future<void> getGamesByLeague(
    LeagueGamesRequested event,
    Emitter<LeagueGamesState> emit,
  ) async {
    emit(LeagueGamesLoading());
    final result = await getAllGamesByLeagueUsecase.call(
      event.leagueId,
      event.season,
    );
    result.fold(
      (failure) => emit(LeagueGamesError(failure.message)),
      (games) => emit(LeagueGamesLoaded(games)),
    );
  }
}
