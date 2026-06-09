import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/players/domain/entitys/one_player.dart';
import 'package:matchup/features/players/domain/repository/players_repository.dart';

class GetSinglePlayerUsecase {
  PlayersRepository repository;

  GetSinglePlayerUsecase(this.repository);

  Future<Either<Failure, PlayerProfile>> call({required int playerId}) async {
    return await repository.getSinglePlayer(id: playerId);
  }
}