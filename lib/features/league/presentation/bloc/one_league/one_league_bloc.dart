import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchup/features/league/domain/entities/one_league.dart';
import 'package:matchup/features/league/domain/usecases/get_league_usecase.dart';
import 'package:matchup/features/league/presentation/bloc/all_leagues/all_leagues_bloc.dart';

part 'one_league_event.dart';
part 'one_league_state.dart';


class OneLeagueBloc extends Bloc<OneLeagueEvent, OneLeagueState> {
  final GetLeagueUseCase getLeagueUseCase;

  OneLeagueBloc({
    required this.getLeagueUseCase
}) : super(OneLeagueInitial()) {
    on<OneLeagueRequested>(getOneLeague);
  }

  Future getOneLeague(
      OneLeagueRequested event,
      Emitter<OneLeagueState> emit
      ) async {
    emit(OneLeagueLoading());
    final result = await getLeagueUseCase.call(id: event.id);
    result.fold(
        (failure) => emit(OneLeagueError(message: failure.message)),
        (league) => emit(OneLeagueLoaded(leaguee: league))
    );
  }
}