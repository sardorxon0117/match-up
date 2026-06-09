import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/exceptions.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/home/data/datasource/game_remoute_datasource.dart';
import 'package:matchup/features/home/domain/entities/all_games.dart';
import 'package:matchup/features/home/domain/entities/game.dart';
import 'package:matchup/features/home/domain/repository/game_repository.dart';

class GameRepositoryImple implements GameRepository {
  final GameRemouteDatasource gameRemouteDatasource;

  GameRepositoryImple({required this.gameRemouteDatasource});

  @override
  Future<Either<Failure, AllGames>> getAllGamesByDate({
    required String? date,
  }) async {
    try {
      final games = await gameRemouteDatasource.getAllGamesByDate(date: date!);
      return Right(games);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AllGames>> getAllGamesByLeague({
    required int? league,
    required int? season,
  }) async {
    try {
      final games = await gameRemouteDatasource.getAllGamesByLeague(
        league: league!,
        season: season!,
      );
      return Right(games);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, OneGame>> getGame({required int id}) async {
    try {
      final game = await gameRemouteDatasource.getGame(id: id);
      return Right(game);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
