import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/home/domain/entities/all_games.dart';
import 'package:matchup/features/home/domain/repository/game_repository.dart';

class GetAllGamesByLeagueUsecase {
  final GameRepository gameRepository;

  GetAllGamesByLeagueUsecase(this.gameRepository);

  Future<Either<Failure, AllGames>> call(int league, int season) {
    return gameRepository.getAllGamesByLeague(league: league, season: season);
  }
}