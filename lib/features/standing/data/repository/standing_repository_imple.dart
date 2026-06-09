import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/exceptions.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/standing/data/datasource/standing_romoute_datasorce.dart';
import 'package:matchup/features/standing/domain/entities/standing.dart';
import 'package:matchup/features/standing/domain/repository/standing_repository.dart';

class StandingRepositoryImple extends StandingRepository {
  final StandingRomouteDatasorce standingRomouteDatasorce;

  StandingRepositoryImple({required this.standingRomouteDatasorce});


  @override
  Future<Either<Failure, Standingg>> getStandings(
      {required int leagueId, required int season}) async {
    try {
      final standing = await standingRomouteDatasorce.getStandings(
          leagueId: leagueId, season: season);
      return Right(standing);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}