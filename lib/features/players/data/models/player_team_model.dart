import 'package:matchup/features/players/domain/entitys/player_team.dart';

class PlayerTeamsModel extends PlayerTeams {
  PlayerTeamsModel({
    required super.playerTeamsGet,
    required super.parameters,
    required super.errors,
    required super.results,
    required super.paging,
    required super.response,
  });

  factory PlayerTeamsModel.fromJson(Map<String, dynamic> json) => PlayerTeamsModel(
    playerTeamsGet: json["get"],
    parameters: ParametersModel.fromJson(json["parameters"]),
    errors: List<dynamic>.from(json["errors"].map((x) => x)),
    results: json["results"],
    paging: PagingModel.fromJson(json["paging"]),
    response: List<ResponseModel>.from(json["response"].map((x) => ResponseModel.fromJson(x))),
  );
}

class PagingModel extends Paging {
  PagingModel({
    required super.current,
    required super.total,
  });

  factory PagingModel.fromJson(Map<String, dynamic> json) => PagingModel(
    current: json["current"],
    total: json["total"],
  );
}

class ParametersModel extends Parameters {
  ParametersModel({
    required super.player,
  });

  factory ParametersModel.fromJson(Map<String, dynamic> json) => ParametersModel(
    player: json["player"],
  );
}

class ResponseModel extends Response {
  ResponseModel({
    required super.team,
    required super.seasons,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    team: TeamModel.fromJson(json["team"]),
    seasons: List<int>.from(json["seasons"].map((x) => x)),
  );
}

class TeamModel extends Team {
  TeamModel({
    required super.id,
    required super.name,
    required super.logo,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
  );
}
