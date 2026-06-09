import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/team/domain/entities/team.dart';
import 'package:matchup/features/team/domain/repository/team_repository.dart';

class GetTeamUsecase {
  TeamRepository repository;

  GetTeamUsecase(this.repository);

  Future<Either<Failure, TeamProfile>> call({required int teamId}) async {
    return await repository.getTeam(teamId: teamId);
  }
}