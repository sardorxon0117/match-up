import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/players/domain/entitys/all_players.dart';
import 'package:matchup/features/players/domain/repository/players_repository.dart';

class GetAllPlayersUsecase {
  final PlayersRepository repository;

  GetAllPlayersUsecase(this.repository);

  Future<Either<Failure, AllPlayers>> call() async {
    return await repository.getAllPlayers();
  }
}