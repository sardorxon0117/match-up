import 'package:dio/dio.dart';
import 'package:matchup/core/errors/exceptions.dart';
import 'package:matchup/features/standing/data/model/standing_model.dart';
import 'package:matchup/features/standing/domain/entities/standing.dart';

abstract class StandingRomouteDatasorce {
  Future<Standingg> getStandings({required int leagueId, required int season});
}


class StandingRomouteDatasorceImple implements StandingRomouteDatasorce {
  final Dio dio;

  StandingRomouteDatasorceImple({required this.dio});

  @override
  Future<Standingg> getStandings({required int leagueId, required int season}) async {
    try {
      final response = await dio.get('https://v3.football.api-sports.io/standings?league=$leagueId&season=$season');
      return StandinggModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
          message: e.message ?? "Network Error!",
          statusCode: e.response?.statusCode ?? 500
      );
    }
  }
}