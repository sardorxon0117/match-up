import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchup/features/home/domain/usecases/get_game_usecase.dart';
import '../../../domain/entities/game.dart';

part 'one_game_event.dart';
part 'one_game_state.dart';

class OneGameBloc extends Bloc<OneGameEvent, OneGameState> {
  final GetGameUseCase getGameUseCase;

  OneGameBloc({required this.getGameUseCase})
      : super(OneGameInitial()) {
    on<OneGameRequested>(getOneGame);
  }

  Future<void> getOneGame(
      OneGameRequested event,
      Emitter<OneGameState> emit,
      ) async {
    emit(OneGameLoading());
    final result = await getGameUseCase.call(id: event.id);
    result.fold(
          (failure) => emit(OneGameError(failure.message)),
          (game) => emit(OneGameLoaded(game)),
    );
  }
}