import 'package:matchup/features/players/data/models/one_player_model.dart';
import 'package:matchup/features/players/domain/entitys/all_players.dart';

class AllPLayersModel extends AllPlayers {
  AllPLayersModel({
    required super.allPLayersGet,
    required super.parameters,
    required super.errors,
    required super.results,
    required super.paging,
    required super.response,
  });

  factory AllPLayersModel.fromJson(Map<String, dynamic> json) =>
      AllPLayersModel(
        allPLayersGet: json["get"] ?? "",
        parameters: [],
        errors: List<dynamic>.from(json["errors"] ?? []),
        results: json["results"] ?? 0,
        paging: PagingModel.fromJson(json["paging"]),
        response: List<Response>.from(
          (json["response"] as List)
              .map((x) => ResponseModel.fromJson(x)),
        ),
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

class ResponseModel extends Response {
  ResponseModel({
    required super.player,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    player: PlayerModel.fromJson(json["player"]),
  );
}