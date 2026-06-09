import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchup/features/standing/domain/entities/standing.dart';
import 'package:matchup/features/standing/domain/usecase/get_standings_usecase.dart';

part 'standing_event.dart';
part 'standing_state.dart';

class StandingBloc extends  Bloc<StandingEvent, StandingState> {
  final GetStandingsUsecase getStandingsUsecase;

  StandingBloc({required this.getStandingsUsecase})
  : super(StandingInitial()) {
    on<StandingRequested>(getStanding);
  }

  Future<void> getStanding(
      StandingRequested event,
      Emitter<StandingState> emit
      ) async {
    emit(StandingLoading());
    final result = await getStandingsUsecase.call(leagueId: event.leagueId, season: event.season);
    result.fold(
        (failure) => emit(StandingError(failure.message)),
        (standing) => emit(StandingLoaded(standing))
    );
  }
}