import 'package:dio/dio.dart';
import 'package:matchup/core/errors/exceptions.dart';
import 'package:matchup/features/home/data/model/game_model.dart';
import 'package:matchup/features/home/data/model/games_model.dart';

abstract class GameRemouteDatasource {
  Future<OneGameModel> getGame({required int id});

  Future<AllGamesModel> getAllGamesByDate({required String date});

  Future<AllGamesModel> getAllGamesByLeague({required int league, required int season});

}

class GameRemouteDatasourceImple implements GameRemouteDatasource {
  final Dio dio;

  GameRemouteDatasourceImple({required this.dio});

  @override
  Future<OneGameModel> getGame({required int id}) async {
    try {
      final response = await dio.get('/fixtures?id=$id');
      return OneGameModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.message ?? "Network Error!",
        statusCode: e.response?.statusCode ?? 500
      );
    }
  }

  @override
  Future<AllGamesModel> getAllGamesByLeague({int? league, int? season}) async {
    try {
      final response = await dio.get('/fixtures?league=$league&season=$season');
      return AllGamesModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
          message: e.message ?? "Network Error!",
          statusCode: e.response?.statusCode ?? 500
      );
    }
  }

  @override
  Future<AllGamesModel> getAllGamesByDate({String? date}) async {
    try {
      final response = await dio.get('/fixtures?date=$date');
      return AllGamesModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
          message: e.message ?? "Network Error!",
          statusCode: e.response?.statusCode ?? 500
      );
    }
  }
}
