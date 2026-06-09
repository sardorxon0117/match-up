import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/players/domain/entitys/all_players.dart';
import 'package:matchup/features/players/domain/entitys/one_player.dart';
import 'package:matchup/features/players/domain/entitys/player_team.dart';

abstract class PlayersRepository {
  Future<Either<Failure, AllPlayers>> getAllPlayers();

  Future<Either<Failure, AllPlayers>> searchPlayers({required String query});

  Future<Either<Failure, PlayerTeams>> getPlayerTeam({required int id});

  Future<Either<Failure, PlayerProfile>> getSinglePlayer({required int id});
}