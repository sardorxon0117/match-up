import 'package:matchup/features/league/domain/entities/one_league.dart';

class LeagueeModel extends Leaguee {
  LeagueeModel({
    required super.leaguesGet,
    required super.parameters,
    required super.errors,
    required super.results,
    required super.paging,
    required super.response,
  });

  factory LeagueeModel.fromJson(Map<String, dynamic> json) => LeagueeModel(
    leaguesGet: json["get"],
    parameters: ParametersModel.fromJson(json["parameters"]),
    errors: List<dynamic>.from(json["errors"].map((x) => x)),
    results: json["results"],
    paging: PagingModel.fromJson(json["paging"]),
    response: List<OneLeagueeModel>.from(json["response"].map((x) => OneLeagueeModel.fromJson(x))),
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
    required super.id,
  });

  factory ParametersModel.fromJson(Map<String, dynamic> json) => ParametersModel(
    id: json["id"],
  );
}

class OneLeagueeModel extends OneLeaguee {
  OneLeagueeModel({
    required super.league,
    required super.country,
    required super.seasons,
  });

  factory OneLeagueeModel.fromJson(Map<String, dynamic> json) => OneLeagueeModel(
    league: LeagueModel.fromJson(json["league"]),
    country: CountryModel.fromJson(json["country"]),
    seasons: List<Season>.from(json["seasons"].map((x) => SeasonModel.fromJson(x))),
  );
}

class CountryModel extends Country {
  CountryModel({
    required super.name,
    required super.code,
    required super.flag,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    name: json["name"] ?? "",
    code: json["code"],
    flag: json["flag"],
  );
}

class LeagueModel extends League {
  LeagueModel({
    required super.id,
    required super.name,
    required super.type,
    required super.logo,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) => LeagueModel(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    logo: json["logo"],
  );
}

class SeasonModel extends Season {
  SeasonModel({
    required super.year,
    required super.start,
    required super.end,
    required super.current,
    required super.coverage,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
    year: json["year"],
    start: DateTime.parse(json["start"] ?? "2000-01-01"),
    end: DateTime.parse(json["end"] ?? "2000-01-01"),
    current: json["current"],
    coverage: CoverageModel.fromJson(json["coverage"]),
  );
}

class CoverageModel extends Coverage {
  CoverageModel({
    required super.fixtures,
    required super.standings,
    required super.players,
    required super.topScorers,
    required super.topAssists,
    required super.topCards,
    required super.injuries,
    required super.predictions,
    required super.odds,
  });

  factory CoverageModel.fromJson(Map<String, dynamic> json) => CoverageModel(
    fixtures: FixturesModel.fromJson(json["fixtures"]),
    standings: json["standings"],
    players: json["players"],
    topScorers: json["top_scorers"],
    topAssists: json["top_assists"],
    topCards: json["top_cards"],
    injuries: json["injuries"],
    predictions: json["predictions"],
    odds: json["odds"],
  );
}

class FixturesModel extends Fixtures {
  FixturesModel({
    required super.events,
    required super.lineups,
    required super.statisticsFixtures,
    required super.statisticsPlayers,
  });

  factory FixturesModel.fromJson(Map<String, dynamic> json) => FixturesModel(
    events: json["events"],
    lineups: json["lineups"],
    statisticsFixtures: json["statistics_fixtures"],
    statisticsPlayers: json["statistics_players"],
  );
}
