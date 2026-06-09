class Leaguee {
  String leaguesGet;
  Parameters parameters;
  List<dynamic> errors;
  int results;
  Paging paging;
  List<OneLeaguee> response;

  Leaguee({
    required this.leaguesGet,
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
}

class Parameters {
  String id;

  Parameters({
    required this.id,
  });
}

class OneLeaguee {
  League league;
  Country country;
  List<Season> seasons;

  OneLeaguee({
    required this.league,
    required this.country,
    required this.seasons,
  });
}

class Country {
  String name;
  String? code;
  String? flag;

  Country({
    required this.name,
    required this.code,
    required this.flag,
  });
}

class League {
  int id;
  String name;
  String type;
  String logo;

  League({
    required this.id,
    required this.name,
    required this.type,
    required this.logo,
  });
}

class Season {
  int year;
  DateTime? start;
  DateTime? end;
  bool current;
  Coverage coverage;

  Season({
    required this.year,
    required this.start,
    required this.end,
    required this.current,
    required this.coverage,
  });
}

class Coverage {
  Fixtures fixtures;
  bool standings;
  bool players;
  bool topScorers;
  bool topAssists;
  bool topCards;
  bool injuries;
  bool predictions;
  bool odds;

  Coverage({
    required this.fixtures,
    required this.standings,
    required this.players,
    required this.topScorers,
    required this.topAssists,
    required this.topCards,
    required this.injuries,
    required this.predictions,
    required this.odds,
  });
}

class Fixtures {
  bool events;
  bool lineups;
  bool statisticsFixtures;
  bool statisticsPlayers;

  Fixtures({
    required this.events,
    required this.lineups,
    required this.statisticsFixtures,
    required this.statisticsPlayers,
  });
}
