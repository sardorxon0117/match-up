import 'package:matchup/features/league/data/model/one_league_model.dart';
import 'package:matchup/features/league/domain/entities/all_leagues.dart';

class LeagueesModel extends Leaguees {
  LeagueesModel({
    required super.leaguesGet,
    required super.parameters,
    required super.errors,
    required super.results,
    required super.paging,
    required super.response,
  });

  factory LeagueesModel.fromJson(Map<String, dynamic> json) => LeagueesModel(
    leaguesGet: json["get"],

    parameters: json["parameters"] is Map<String, dynamic>
        ? ParametersModel.fromJson(json["parameters"])
        : ParametersModel(search: ""),

    errors: json["errors"] is List
        ? List<dynamic>.from(json["errors"])
        : [json["errors"]],

    results: json["results"],

    paging: PagingModel.fromJson(json["paging"]),

    response: List<OneLeagueeModel>.from(
      json["response"].map((x) => OneLeagueeModel.fromJson(x)),
    ),
  );
}

class PagingModel extends Paging {
  PagingModel({required super.current, required super.total});

  factory PagingModel.fromJson(Map<String, dynamic> json) =>
      PagingModel(current: json["current"], total: json["total"]);
}

class ParametersModel extends Parameters {
  ParametersModel({required super.search});

  factory ParametersModel.fromJson(Map<String, dynamic> json) =>
      ParametersModel(search: json["search"]);
}
