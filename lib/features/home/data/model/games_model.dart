import 'package:matchup/features/home/data/model/game_model.dart';
import '../../domain/entities/all_games.dart';

class AllGamesModel extends AllGames {
  AllGamesModel({
    required super.gamesGet,
    required super.parameters,
    required super.errors,
    required super.results,
    required super.paging,
    required super.response,
  });

  factory AllGamesModel.fromJson(Map<String, dynamic> json) => AllGamesModel(
    gamesGet: json["get"],
    parameters: ParametersModel.fromJson(json["parameters"]),
    errors: List<dynamic>.from(json["errors"].map((x) => x)),
    results: json["results"],
    paging: PagingModel.fromJson(json["paging"]),
    response: List<OneResponseModel>.from(json["response"].map((x) => OneResponseModel.fromJson(x))),
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
    required super.date,
  });

  factory ParametersModel.fromJson(Map<String, dynamic> json) => ParametersModel(
    date: DateTime.parse(json["date"] ?? "2026-06-04"),
  );
}