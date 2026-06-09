import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/league/data/datasource/league_remoute_datasource.dart';
import 'package:matchup/features/league/domain/entities/all_leagues.dart';
import 'package:matchup/features/league/domain/entities/one_league.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/repository/league_repository.dart';

class LeagueRepositoryImple extends LeagueRepository {
  final LeagueRemouteDatasource leagueRemouteDatasource;

  LeagueRepositoryImple({
    required this.leagueRemouteDatasource
  });

  @override
  Future<Either<Failure, Leaguees>> getAllLeagues() async {
    try {
      final leagues = await leagueRemouteDatasource.getAllLeagues();
      return Right(leagues);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Leaguee>> getLeague({required int id}) async {
    try {
      final league = await leagueRemouteDatasource.getLeague(id: id);
      return Right(league);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Leaguees>> searchLeagues({
    required String query,
  }) async {
    try {
      final league = await leagueRemouteDatasource.searchLeagues(query: query);
      return Right(league);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
