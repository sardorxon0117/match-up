import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/standing/domain/entities/standing.dart';
import 'package:matchup/features/standing/domain/repository/standing_repository.dart';

class GetStandingsUsecase {
  StandingRepository repository;

  GetStandingsUsecase(this.repository);

  Future<Either<Failure, Standingg>> call({required int leagueId, required int season}) async {
    return await repository.getStandings(leagueId: leagueId, season: season);
  }
}