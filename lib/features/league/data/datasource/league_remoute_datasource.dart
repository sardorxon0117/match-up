// abstract class GameRemouteDatasource {
//   Future<OneGameModel> getGame({required int id});
//
//   Future<AllGamesModel> getAllGamesByDate({required String date});
//
//   Future<AllGamesModel> getAllGamesByLeague({required int league, required int season});
// }
//
// class GameRemouteDatasourceImple implements GameRemouteDatasource {
//   final Dio dio;
//
//   GameRemouteDatasourceImple({required this.dio});
//
//   @override
//   Future<OneGameModel> getGame({required int id}) async {
//     try {
//       final response = await dio.get('/fixtures?id=$id');
//       return OneGameModel.fromJson(response.data);
//     } on DioException catch (e) {
//       throw ServerException(
//           message: e.response?.data['errors']['required'] ?? "Get game failed",
//           statusCode: e.response?.statusCode ?? 404
//       );
//     }
//   }
//
//   @override
//   Future<AllGamesModel> getAllGamesByLeague({int? league, int? season}) async {
//     try {
//       final response = await dio.get('/fixtures?league=$league&season=$season');
//       return AllGamesModel.fromJson(response.data);
//     } on DioException catch (e) {
//       throw ServerException(
//           message: e.response!.data['errors']['required'] ?? "Get all home by league failed",
//           statusCode: e.response!.statusCode ?? 404
//       );
//     }
//   }
//
//   @override
//   Future<AllGamesModel> getAllGamesByDate({String? date}) async {
//     try {
//       final response = await dio.get('/fixtures?date=$date');
//       return AllGamesModel.fromJson(response.data);
//     } on DioException catch (e) {
//       throw ServerException(
//           message: e.response!.data['errors']['required'] ?? "Get all home by date failed",
//           statusCode: e.response!.statusCode ?? 404
//       );
//     }
//   }
// }


import 'package:dio/dio.dart';
import 'package:matchup/core/errors/exceptions.dart';
import 'package:matchup/features/league/data/model/all_leagues_model.dart';
import 'package:matchup/features/league/data/model/one_league_model.dart';
import 'package:matchup/features/league/domain/entities/all_leagues.dart';
import 'package:matchup/features/league/domain/entities/one_league.dart';

abstract class LeagueRemouteDatasource {
  Future<Leaguee> getLeague({required int id});

  Future<Leaguees> getAllLeagues();

  Future<Leaguees> searchLeagues({required String query});
}

class LeagueRemouteDatasourceImple implements LeagueRemouteDatasource {
  final Dio dio;

  LeagueRemouteDatasourceImple({required this.dio});

  @override
  Future<Leaguees> getAllLeagues() async {
    try {
      final response = await dio.get('https://v3.football.api-sports.io/leagues');
      return LeagueesModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
          message: e.message ?? "Network Error!",
          statusCode: e.response?.statusCode ?? 500
      );
    }
  }

  @override
  Future<Leaguee> getLeague({required int id}) async {
    try {
      final response = await dio.get('https://v3.football.api-sports.io/leagues?id=$id');
      return LeagueeModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
          message: e.message ?? "Network Error!",
          statusCode: e.response?.statusCode ?? 500
      );
    }
  }

  @override
  Future<Leaguees> searchLeagues({required String query}) async {
    try {
      final response = await dio.get('https://v3.football.api-sports.io/leagues?search=$query');
      return LeagueesModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
          message: e.message ?? "Network Error!",
          statusCode: e.response?.statusCode ?? 500
      );
    }
  }
}