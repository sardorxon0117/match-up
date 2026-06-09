import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/players/domain/entitys/player_team.dart';
import 'package:matchup/features/players/domain/repository/players_repository.dart';

class GetPlayerTeamUsecase {
  final PlayersRepository repository;

  GetPlayerTeamUsecase(this.repository);

  Future<Either<Failure, PlayerTeams>> call({required int playerId}) async {
    return await repository.getPlayerTeam(id: playerId);
  }
}