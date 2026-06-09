import 'package:dio/dio.dart';
import 'package:matchup/core/errors/exceptions.dart';
import 'package:matchup/features/team/data/models/team_model.dart';
import 'package:matchup/features/team/domain/entities/team.dart';

abstract class TeamRemouteDatasource {
  Future<TeamProfile> getTeam({required int teamId});
}


class TeamRemouteDatasourceImple implements TeamRemouteDatasource {
  final Dio dio;

  TeamRemouteDatasourceImple({required this.dio});

  @override
  Future<TeamProfile> getTeam({required int teamId}) async {
    try {
      final response = await dio.get('https://v3.football.api-sports.io/teams?id=$teamId');
      return TeamProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
          message: e.message ?? "Network Error!",
          statusCode: e.response?.statusCode ?? 500
      );
    }
  }
}