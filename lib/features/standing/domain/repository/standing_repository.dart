import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/standing/domain/entities/standing.dart';

abstract class StandingRepository {
  Future<Either<Failure, Standingg>> getStandings({
    required int leagueId,
    required int season,
  });
}
