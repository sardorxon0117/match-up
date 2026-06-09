import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/home/domain/entities/all_games.dart';
import 'package:matchup/features/home/domain/entities/game.dart';

abstract class GameRepository {
  Future<Either<Failure, OneGame>> getGame({required int id});

  Future<Either<Failure, AllGames>> getAllGamesByLeague({
    required int? league,
    required int? season,
  });

  Future<Either<Failure, AllGames>> getAllGamesByDate({required String? date});
}
