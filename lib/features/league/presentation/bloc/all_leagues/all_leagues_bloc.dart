import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchup/features/league/domain/entities/all_leagues.dart';
import 'package:matchup/features/league/domain/usecases/get_all_leagues_usecase.dart';
import 'package:matchup/features/league/domain/usecases/search_leagues_usecase.dart';

part 'all_leagues_event.dart';
part 'all_leagues_state.dart';


class AllLeaguesBloc extends Bloc<AllLeaguesEvent, AllLeaguesState> {
  final GetAllLeaguesUseCase getAllLeaguesUseCase;
  final SearchLeaguesUseCase searchLeaguesUseCase;

  AllLeaguesBloc({
    required this.getAllLeaguesUseCase,
    required this.searchLeaguesUseCase
  }) :super(AllLeaguesInitial()) {
    on<AllLeaguesRequested>(getAllLeagues);
    on<SearchLeaguesRequested>(searchLeagues);
  }

  Future<void> getAllLeagues(
      AllLeaguesRequested event,
      Emitter<AllLeaguesState> emit,
      ) async {
    emit(AllLeaguesLoading());
    final result = await getAllLeaguesUseCase.call();
    result.fold(
        (failure) => emit(AllLeaguesError(message: failure.message)),
        (leagues) => emit(AllLeaguesLoaded(leaguees: leagues))
    );
  }

  Future<void> searchLeagues(
      SearchLeaguesRequested event,
      Emitter<AllLeaguesState> emit,
      ) async {
    emit(AllLeaguesLoading());
    final result = await searchLeaguesUseCase.call(query: event.query);
    result.fold(
          (failure) => emit(AllLeaguesError(message: failure.message)),
          (leagues) => emit(AllLeaguesLoaded(leaguees: leagues)),
    );
  }
}