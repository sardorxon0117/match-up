class Standingg {
  String allLeagueGet;
  Parameters parameters;
  List<dynamic> errors;
  int results;
  Paging paging;
  List<Response> response;

  Standingg({
    required this.allLeagueGet,
    required this.parameters,
    required this.errors,
    required this.results,
    required this.paging,
    required this.response,
  });
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

  Map<String, dynamic> toJson() => {
    "current": current,
    "total": total,
  };
}

class Parameters {
  String league;
  String season;

  Parameters({
    required this.league,
    required this.season,
  });

  factory Parameters.fromJson(Map<String, dynamic> json) => Parameters(
    league: json["league"],
    season: json["season"],
  );

  Map<String, dynamic> toJson() => {
    "league": league,
    "season": season,
  };
}

class Response {
  League league;

  Response({
    required this.league,
  });
}

class League {
  int id;
  String name;
  String country;
  String logo;
  String flag;
  int season;
  List<List<Standing>> standings;

  League({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.flag,
    required this.season,
    required this.standings,
  });
}

class Standing {
  int rank;
  Team team;
  int points;
  int goalsDiff;
  String group;
  String form;
  String status;
  String? description;
  All all;
  All home;
  All away;
  DateTime update;

  Standing({
    required this.rank,
    required this.team,
    required this.points,
    required this.goalsDiff,
    required this.group,
    required this.form,
    required this.status,
    required this.description,
    required this.all,
    required this.home,
    required this.away,
    required this.update,
  });
}

class All {
  int played;
  int win;
  int draw;
  int lose;
  Goals goals;

  All({
    required this.played,
    required this.win,
    required this.draw,
    required this.lose,
    required this.goals,
  });
}

class Goals {
  int goalsFor;
  int against;

  Goals({
    required this.goalsFor,
    required this.against,
  });
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
}