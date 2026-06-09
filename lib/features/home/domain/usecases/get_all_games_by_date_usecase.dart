import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/home/domain/entities/all_games.dart';
import 'package:matchup/features/home/domain/repository/game_repository.dart';

class GetAllGamesByDateUsecase {
  final GameRepository gameRepository;

  GetAllGamesByDateUsecase(this.gameRepository);

  Future<Either<Failure, AllGames>> call({required String date}) {
    return gameRepository.getAllGamesByDate(date: date);
  }
}