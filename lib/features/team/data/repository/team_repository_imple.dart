import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/exceptions.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/team/data/datasource/team_remoute_datasource.dart';
import 'package:matchup/features/team/domain/entities/team.dart';
import 'package:matchup/features/team/domain/repository/team_repository.dart';

class TeamRepositoryImple extends TeamRepository {
  final TeamRemouteDatasource teamRemouteDatasource;

  TeamRepositoryImple({required this.teamRemouteDatasource});


  @override
  Future<Either<Failure, TeamProfile>> getTeam(
      {required int teamId}) async {
    try {
      final team = await teamRemouteDatasource.getTeam(
          teamId: teamId);
      return Right(team);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}