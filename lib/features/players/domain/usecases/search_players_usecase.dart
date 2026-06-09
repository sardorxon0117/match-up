import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/players/domain/entitys/all_players.dart';
import 'package:matchup/features/players/domain/repository/players_repository.dart';

class SearchPlayersUsecase {
  final PlayersRepository repository;

  SearchPlayersUsecase(this.repository);

  Future<Either<Failure, AllPlayers>> call({required String query}) async {
    return await repository.searchPlayers(query: query);
  }
}