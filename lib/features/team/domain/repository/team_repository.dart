import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/team/domain/entities/team.dart';

abstract class TeamRepository {
  Future<Either<Failure, TeamProfile>> getTeam({
    required int teamId,
  });
}
