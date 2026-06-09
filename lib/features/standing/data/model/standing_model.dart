import 'package:matchup/features/standing/domain/entities/standing.dart';

class StandinggModel extends Standingg {
  StandinggModel({
    required super.allLeagueGet,
    required super.parameters,
    required super.errors,
    required super.results,
    required super.paging,
    required super.response,
  });

  factory StandinggModel.fromJson(Map<String, dynamic> json) {
    return StandinggModel(
      allLeagueGet: json["get"]?.toString() ?? "",
      parameters: ParametersModel.fromJson(
        json["parameters"] ?? {},
      ),
      errors: List<dynamic>.from(
        (json["errors"] ?? []).map((x) => x),
      ),
      results: json["results"] ?? 0,
      paging: PagingModel.fromJson(
        json["paging"] ?? {},
      ),
      response: List<ResponseModel>.from(
        (json["response"] ?? [])
            .map((x) => ResponseModel.fromJson(x)),
      ),
    );
  }
}

class PagingModel extends Paging {
  PagingModel({
    required super.current,
    required super.total,
  });

  factory PagingModel.fromJson(Map<String, dynamic> json) {
    return PagingModel(
      current: json["current"] ?? 0,
      total: json["total"] ?? 0,
    );
  }
}

class ParametersModel extends Parameters {
  ParametersModel({
    required super.league,
    required super.season,
  });

  factory ParametersModel.fromJson(Map<String, dynamic> json) {
    return ParametersModel(
      league: json["league"]?.toString() ?? "",
      season: json["season"]?.toString() ?? "",
    );
  }
}

class ResponseModel extends Response {
  ResponseModel({
    required super.league,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      league: LeagueModel.fromJson(
        json["league"] ?? {},
      ),
    );
  }
}

class LeagueModel extends League {
  LeagueModel({
    required super.id,
    required super.name,
    required super.country,
    required super.logo,
    required super.flag,
    required super.season,
    required super.standings,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) {
    return LeagueModel(
      id: json["id"] ?? 0,
      name: json["name"]?.toString() ?? "",
      country: json["country"]?.toString() ?? "",
      logo: json["logo"]?.toString() ?? "",
      flag: json["flag"]?.toString() ?? "",
      season: json["season"] ?? 0,
      standings: List<List<StandingModel>>.from(
        (json["standings"] ?? []).map(
              (group) => List<StandingModel>.from(
            (group ?? []).map(
                  (item) => StandingModel.fromJson(item),
            ),
          ),
        ),
      ),
    );
  }
}

class StandingModel extends Standing {
  StandingModel({
    required super.rank,
    required super.team,
    required super.points,
    required super.goalsDiff,
    required super.group,
    required super.form,
    required super.status,
    required super.description,
    required super.all,
    required super.home,
    required super.away,
    required super.update,
  });

  factory StandingModel.fromJson(Map<String, dynamic> json) {
    return StandingModel(
      rank: json["rank"] ?? 0,
      team: TeamModel.fromJson(
        json["team"] ?? {},
      ),
      points: json["points"] ?? 0,
      goalsDiff: json["goalsDiff"] ?? 0,
      group: json["group"]?.toString() ?? "",
      form: json["form"]?.toString() ?? "",
      status: json["status"]?.toString() ?? "",
      description: json["description"]?.toString(),
      all: AllModel.fromJson(
        json["all"] ?? {},
      ),
      home: AllModel.fromJson(
        json["home"] ?? {},
      ),
      away: AllModel.fromJson(
        json["away"] ?? {},
      ),
      update: DateTime.tryParse(
        json["update"]?.toString() ?? "",
      ) ??
          DateTime.now(),
    );
  }
}

class AllModel extends All {
  AllModel({
    required super.played,
    required super.win,
    required super.draw,
    required super.lose,
    required super.goals,
  });

  factory AllModel.fromJson(Map<String, dynamic> json) {
    return AllModel(
      played: json["played"] ?? 0,
      win: json["win"] ?? 0,
      draw: json["draw"] ?? 0,
      lose: json["lose"] ?? 0,
      goals: GoalsModel.fromJson(
        json["goals"] ?? {},
      ),
    );
  }
}

class GoalsModel extends Goals {
  GoalsModel({
    required super.goalsFor,
    required super.against,
  });

  factory GoalsModel.fromJson(Map<String, dynamic> json) {
    return GoalsModel(
      goalsFor: json["for"] ?? 0,
      against: json["against"] ?? 0,
    );
  }
}

class TeamModel extends Team {
  TeamModel({
    required super.id,
    required super.name,
    required super.logo,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json["id"] ?? 0,
      name: json["name"]?.toString() ?? "Unknown Team",
      logo: json["logo"]?.toString() ?? "",
    );
  }
}