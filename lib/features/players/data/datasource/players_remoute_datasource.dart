import 'package:dio/dio.dart';
import 'package:matchup/core/errors/exceptions.dart';
import 'package:matchup/features/players/data/models/all_players_model.dart';
import 'package:matchup/features/players/data/models/one_player_model.dart';
import 'package:matchup/features/players/domain/entitys/all_players.dart';
import 'package:matchup/features/players/domain/entitys/one_player.dart';
import 'package:matchup/features/players/domain/entitys/player_team.dart';

abstract class PlayersRemouteDatasource {
  Future<AllPlayers> getAllPlayers();
  
  Future<AllPlayers> searchPLayer({required String query});
  
  Future<PlayerProfile> getSinglePlayer({required int playerId});
  
  Future<PlayerTeams> getPlayerTeams({required int playerId});
}

class PlayersRemouteDatasourceImple implements PlayersRemouteDatasource {
  final Dio dio;
  
  PlayersRemouteDatasourceImple({required this.dio});

  @override
  Future<AllPlayers> getAllPlayers() async {
    try {
      final response = await dio.get('https://v3.football.api-sports.io/players/profiles?');
      return AllPLayersModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
          message: e.message ?? "Network Error!",
          statusCode: e.response?.statusCode ?? 500
      );
    }
  }

  @override
  Future<PlayerTeams> getPlayerTeams({required int playerId}) async {
    try {
      final response = await dio.get('https://v3.football.api-sports.io/players/teams?player=$playerId');
      return PlayerTeams.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
          message: e.message ?? "Network Error!",
          statusCode: e.response?.statusCode ?? 500
      );
    }
  }

  @override
  Future<PlayerProfile> getSinglePlayer({required int playerId}) async {
    try {
      final response = await dio.get('https://v3.football.api-sports.io/players/profiles?player=$playerId');
      return PlayerProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
          message: e.message ?? "Network Error!",
          statusCode: e.response?.statusCode ?? 500
      );
    }
  }

  @override
  Future<AllPlayers> searchPLayer({required String query}) async {
    try {
      final response = await dio.get('https://v3.football.api-sports.io/players/profiles?search=$query');
      return AllPLayersModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
          message: e.message ?? "Network Error!",
          statusCode: e.response?.statusCode ?? 500
      );
    }
  }
  
  
}