import 'package:matchup/features/players/domain/entitys/one_player.dart';

class PlayerProfileModel extends PlayerProfile {
  PlayerProfileModel({
    required super.playerProfileGet,
    required super.parameters,
    required super.errors,
    required super.results,
    required super.paging,
    required super.response,
  });

  factory PlayerProfileModel.fromJson(Map<String, dynamic> json) => PlayerProfileModel(
    playerProfileGet: json["get"],
    parameters: ParametersModel.fromJson(json["parameters"]),
    errors: List<dynamic>.from(json["errors"].map((x) => x)),
    results: json["results"],
    paging: Paging.fromJson(json["paging"]),
    response: List<Response>.from(json["response"].map((x) => ResponseModel.fromJson(x))),
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
    required super.player,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    player: PlayerModel.fromJson(json["player"]),
  );
}

class PlayerModel extends Player {
  PlayerModel({
    required super.id,
    required super.name,
    required super.firstname,
    required super.lastname,
    required super.age,
    required super.birth,
    required super.nationality,
    required super.height,
    required super.weight,
    required super.number,
    required super.position,
    required super.photo,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    firstname: json["firstname"] ?? "",
    lastname: json["lastname"] ?? "",
    age: json["age"] ?? 0,
    birth: BirthModel.fromJson(json["birth"] ?? {}),
    nationality: json["nationality"] ?? "",
    height: json["height"] ?? "",
    weight: json["weight"] ?? "",
    number: json["number"] ?? 0,
    position: json["position"] ?? "",
    photo: json["photo"] ?? "",
  );
}

class BirthModel extends Birth {
  BirthModel({
    required super.date,
    required super.place,
    required super.country,
  });

  factory BirthModel.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate;

    try {
      parsedDate = json["date"] != null
          ? DateTime.parse(json["date"].toString())
          : DateTime(2000, 1, 1);
    } catch (_) {
      parsedDate = DateTime(2000, 1, 1);
    }

    return BirthModel(
      date: parsedDate,
      place: json["place"]?.toString() ?? "",
      country: json["country"]?.toString() ?? "",
    );
  }
}

