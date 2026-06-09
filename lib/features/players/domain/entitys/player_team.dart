class PlayerTeams {
  String playerTeamsGet;
  Parameters parameters;
  List<dynamic> errors;
  int results;
  Paging paging;
  List<Response> response;

  PlayerTeams({
    required this.playerTeamsGet,
    required this.parameters,
    required this.errors,
    required this.results,
    required this.paging,
    required this.response,
  });

  factory PlayerTeams.fromJson(Map<String, dynamic> json) => PlayerTeams(
    playerTeamsGet: json["get"],
    parameters: Parameters.fromJson(json["parameters"]),
    errors: List<dynamic>.from(json["errors"].map((x) => x)),
    results: json["results"],
    paging: Paging.fromJson(json["paging"]),
    response: List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
  );
}

class Paging {
  int current;
  int total;

  Paging({
    required this.current,
    required this.total,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
    current: json["current"],
    total: json["total"],
  );
}

class Parameters {
  String player;

  Parameters({
    required this.player,
  });

  factory Parameters.fromJson(Map<String, dynamic> json) => Parameters(
    player: json["player"],
  );
}

class Response {
  Team team;
  List<int> seasons;

  Response({
    required this.team,
    required this.seasons,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    team: Team.fromJson(json["team"]),
    seasons: List<int>.from(json["seasons"].map((x) => x)),
  );
}

class Team {
  int id;
  String name;
  String logo;

  Team({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
  );
}
