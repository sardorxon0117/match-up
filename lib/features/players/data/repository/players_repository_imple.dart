import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/players/data/datasource/players_remoute_datasource.dart';
import 'package:matchup/features/players/domain/entitys/all_players.dart';
import 'package:matchup/features/players/domain/entitys/one_player.dart';
import 'package:matchup/features/players/domain/entitys/player_team.dart';
import 'package:matchup/features/players/domain/repository/players_repository.dart';
import '../../../../core/errors/exceptions.dart';

class PlayersRepositoryImple extends PlayersRepository {
  final PlayersRemouteDatasource playersRemouteDatasource;

  PlayersRepositoryImple({required this.playersRemouteDatasource});

  @override
  Future<Either<Failure, AllPlayers>> getAllPlayers() async {
    try {
      final players = await playersRemouteDatasource.getAllPlayers();
      return Right(players);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PlayerTeams>> getPlayerTeam({required int id}) async {
    try {
      final playerTeams = await playersRemouteDatasource.getPlayerTeams(playerId: id);
      return Right(playerTeams);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PlayerProfile>> getSinglePlayer({required int id}) async {
    try {
      final player = await playersRemouteDatasource.getSinglePlayer(playerId: id);
      return Right(player);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AllPlayers>> searchPlayers({required String query}) async {
    try {
      final players = await playersRemouteDatasource.searchPLayer(query: query);
      return Right(players);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}