import 'package:matchup/features/team/domain/entities/team.dart';

class TeamProfileModel extends TeamProfile {
  TeamProfileModel({
    required super.teamProfileGet,
    required super.parameters,
    required super.errors,
    required super.results,
    required super.paging,
    required super.response,
  });

  factory TeamProfileModel.fromJson(Map<String, dynamic> json) => TeamProfileModel(
    teamProfileGet: json["get"] ?? "",
    parameters: ParametersModel.fromJson(json["parameters"]),
    errors: List<dynamic>.from(json["errors"].map((x) => x)),
    results: json["results"] ?? 0,
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
    current: json["current"] ?? 0,
    total: json["total"] ?? 0,
  );
}

class ParametersModel extends Parameters {
  ParametersModel({
    required super.id,
  });

  factory ParametersModel.fromJson(Map<String, dynamic> json) => ParametersModel(
    id: json["id"] ?? 0,
  );
}

class ResponseModel extends Response {
  ResponseModel({
    required super.team,
    required super.venue,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    team: TeamModel.fromJson(json["team"]),
    venue: VenueModel.fromJson(json["venue"]),
  );
}

class TeamModel extends Team {
  TeamModel({
    required super.id,
    required super.name,
    required super.code,
    required super.country,
    required super.founded,
    required super.national,
    required super.logo,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    code: json["code"] ?? "",
    country: json["country"] ?? "",
    founded: json["founded"] ?? 0,
    national: json["national"] ?? false,
    logo: json["logo"] ?? "",
  );
}

class VenueModel extends Venue {
  VenueModel({
    required super.id,
    required super.name,
    required super.address,
    required super.city,
    required super.capacity,
    required super.surface,
    required super.image,
  });

  factory VenueModel.fromJson(Map<String, dynamic> json) => VenueModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    address: json["address"] ?? "",
    city: json["city"] ?? "",
    capacity: json["capacity"] ?? 0,
    surface: json["surface"] ?? "",
    image: json["image"] ?? "",
  );
}
