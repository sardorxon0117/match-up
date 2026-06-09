import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchup/features/home/domain/usecases/get_all_games_by_date_usecase.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/all_games.dart';
part 'date_games_event.dart';
part 'date_games_state.dart';

class DateGamesBloc extends Bloc<DateGamesEvent, DateGamesState> {
  final GetAllGamesByDateUsecase getAllGamesByDateUsecase;

  DateGamesBloc({required this.getAllGamesByDateUsecase})
    : super(DateGamesInitial()) {
    on<DateGamesRequested>(getGamesByDate);
  }

  Future<void> getGamesByDate(
    DateGamesRequested event,
    Emitter<DateGamesState> emit,
  ) async {
    emit(DateGamesLoading());
    final result = await getAllGamesByDateUsecase.call(date: event.date);
    result.fold(
      (failure) => emit(DateGamesError(failure.message)),
      (game) => emit(DateGamesLoaded(game)),
    );
  }
}
