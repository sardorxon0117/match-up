import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/league/domain/entities/all_leagues.dart';
import 'package:matchup/features/league/domain/entities/one_league.dart';

abstract class LeagueRepository {
  Future<Either<Failure, Leaguee>> getLeague({required int id});

  Future<Either<Failure, Leaguees>> getAllLeagues();

  Future<Either<Failure, Leaguees>> searchLeagues({required String query});
}