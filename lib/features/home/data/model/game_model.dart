import 'package:matchup/features/home/domain/entities/game.dart';

class OneGameModel extends OneGame {
  OneGameModel({
    required super.oneGameGet,
    required super.parameters,
    required super.errors,
    required super.results,
    required super.paging,
    required super.response,
  });

  factory OneGameModel.fromJson(Map<String, dynamic> json) => OneGameModel(
    oneGameGet: json["get"],
    parameters: OneParametersModel.fromJson(json["parameters"] ?? {}),
    errors: json["errors"] is List
        ? List<dynamic>.from(json["errors"].map((x) => x))
        : json["errors"],
    results: json["results"],
    paging: OnePagingModel.fromJson(json["paging"] ?? {}),
    response: (json["response"] as List? ?? [])
        .map((x) => OneResponseModel.fromJson(x))
        .toList(),
  );
}

class OnePagingModel extends OnePaging {
  OnePagingModel({required super.current, required super.total});

  factory OnePagingModel.fromJson(Map<String, dynamic> json) =>
      OnePagingModel(current: json["current"], total: json["total"]);
}

class OneParametersModel extends OneParameters {
  OneParametersModel({required super.id});

  factory OneParametersModel.fromJson(Map<String, dynamic> json) =>
      OneParametersModel(id: json["id"]);
}

class OneResponseModel extends OneResponse {
  OneResponseModel({
    required super.fixture,
    required super.league,
    required super.teams,
    required super.goals,
    required super.score,
    required super.events,
    required super.lineups,
    required super.statistics,
    required super.players,
  });

  factory OneResponseModel.fromJson(Map<String, dynamic> json) =>
      OneResponseModel(
        fixture: OneFixtureModel.fromJson(json["fixture"] ?? {}),
        league: OneLeagueModel.fromJson(json["league"] ?? {}),
        teams: OneTeamsClassModel.fromJson(json["teams"] ?? {}),
        goals: OneGoalsClassModel.fromJson(json["goals"] ?? {}),
        score: OneScoreModel.fromJson(json["score"] ?? {}),

        events: (json["events"] as List? ?? [])
            .map((x) => OneEventModel.fromJson(x))
            .toList(),

        lineups: (json["lineups"] as List? ?? [])
            .map((x) => OneLineupModel.fromJson(x))
            .toList(),

        statistics: (json["statistics"] as List? ?? [])
            .map((x) => OneResponseStatisticModel.fromJson(x))
            .toList(),

        players: (json["players"] as List? ?? [])
            .map((x) => OneResponsePlayerModel.fromJson(x))
            .toList(),
      );
}

class OneEventModel extends OneEvent {
  OneEventModel({
    required super.time,
    required super.team,
    required super.player,
    required super.assist,
    required super.type,
    required super.detail,
    required super.comments,
  });

  factory OneEventModel.fromJson(Map<String, dynamic> json) => OneEventModel(
    time: OneTimeModel.fromJson(json["time"] ?? {}),
    team: json["team"] != null
        ? OneTeamModel.fromJson(json["team"])
        : OneTeamModel.fromJson({}),
    player: json["player"] != null
        ? OneEventPlayerModel.fromJson(json["player"])
        : OneEventPlayerModel.fromJson({}),
    assist: json["assist"] != null
        ? OneAssistModel.fromJson(json["assist"])
        : OneAssistModel(id: null, name: null),
    type: json["type"] ?? "",
    detail: json["detail"] ?? "",
    comments: json["comments"] ?? "",
  );
}

class OneEventPlayerModel extends OneEventPlayer {
  OneEventPlayerModel({required super.id, required super.name});

  factory OneEventPlayerModel.fromJson(Map<String, dynamic> json) =>
      OneEventPlayerModel(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class OneAssistModel extends OneAssist {
  OneAssistModel({required super.id, required super.name});

  factory OneAssistModel.fromJson(Map<String, dynamic> json) =>
      OneAssistModel(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class OneTeamModel extends OneTeam {
  OneTeamModel({
    required super.id,
    required super.name,
    required super.logo,
    super.colors,
    super.update,
    super.winner,
  });

  factory OneTeamModel.fromJson(Map<String, dynamic> json) => OneTeamModel(
    id: json["id"],
    name: json["name"] ?? "",
    logo: json["logo"] ?? "",
    colors: json["colors"] != null
        ? OneColorsModel.fromJson(json["colors"])
        : null,
    update: json["update"] != null ? DateTime.tryParse(json["update"]) : null,
    winner: json["winner"],
  );
}

class OneColorsModel extends OneColors {
  OneColorsModel({required super.player, required super.goalkeeper});

  factory OneColorsModel.fromJson(Map<String, dynamic> json) => OneColorsModel(
    player: OneGoalkeeperModel.fromJson(json["player"]),
    goalkeeper: OneGoalkeeperModel.fromJson(json["goalkeeper"]),
  );
}

class OneGoalkeeperModel extends OneGoalkeeper {
  OneGoalkeeperModel({
    required super.primary,
    required super.number,
    required super.border,
  });

  factory OneGoalkeeperModel.fromJson(Map<String, dynamic> json) =>
      OneGoalkeeperModel(
        primary: json["primary"],
        number: json["number"],
        border: json["border"],
      );
}

class OneTimeModel extends OneTime {
  OneTimeModel({required super.elapsed, required super.extra});

  factory OneTimeModel.fromJson(Map<String, dynamic> json) =>
      OneTimeModel(elapsed: json["elapsed"], extra: json["extra"]);
}

class OneFixtureModel extends OneFixture {
  OneFixtureModel({
    required super.id,
    required super.referee,
    required super.timezone,
    required super.date,
    required super.timestamp,
    required super.periods,
    required super.venue,
    required super.status,
  });

  factory OneFixtureModel.fromJson(Map<String, dynamic> json) =>
      OneFixtureModel(
        id: json["id"],
        referee: json["referee"],
        timezone: json["timezone"] ?? "",
        date: DateTime.tryParse(json["date"] ?? "") ?? DateTime(0),
        timestamp: json["timestamp"] ?? 0,
        periods: OnePeriodsModel.fromJson(json["periods"] ?? {}),
        venue: OneVenueModel.fromJson(json["venue"] ?? {}),
        status: OneStatusModel.fromJson(json["status"] ?? {}),
      );
}

class OnePeriodsModel extends OnePeriods {
  OnePeriodsModel({required super.first, required super.second});

  factory OnePeriodsModel.fromJson(Map<String, dynamic> json) =>
      OnePeriodsModel(first: json["first"], second: json["second"]);
}

class OneStatusModel extends OneStatus {
  OneStatusModel({
    required super.long,
    required super.short,
    required super.elapsed,
    required super.extra,
  });

  factory OneStatusModel.fromJson(Map<String, dynamic> json) => OneStatusModel(
    long: json["long"],
    short: json["short"],
    elapsed: json["elapsed"],
    extra: json["extra"],
  );
}

class OneVenueModel extends OneVenue {
  OneVenueModel({required super.id, required super.name, required super.city});

  factory OneVenueModel.fromJson(Map<String, dynamic> json) =>
      OneVenueModel(id: json["id"], name: json["name"], city: json["city"]);
}

class OneTeamsClassModel extends OneTeamsClass {
  OneTeamsClassModel({required super.home, required super.away});

  factory OneTeamsClassModel.fromJson(Map<String, dynamic> json) =>
      OneTeamsClassModel(
        home: OneTeamModel.fromJson(json["home"]),
        away: OneTeamModel.fromJson(json["away"]),
      );
}

class OneGoalsClassModel extends OneGoalsClass {
  OneGoalsClassModel({required super.home, required super.away});

  factory OneGoalsClassModel.fromJson(Map<String, dynamic> json) =>
      OneGoalsClassModel(home: json["home"], away: json["away"]);
}

class OneLeagueModel extends OneLeague {
  OneLeagueModel({
    required super.id,
    required super.name,
    required super.country,
    required super.logo,
    required super.flag,
    required super.season,
    required super.round,
    required super.standings,
  });

  factory OneLeagueModel.fromJson(Map<String, dynamic> json) => OneLeagueModel(
    id: json["id"],
    name: json["name"],
    country: json["country"],
    logo: json["logo"],
    flag: json["flag"],
    season: json["season"],
    round: json["round"],
    standings: json["standings"],
  );
}

class OneLineupModel extends OneLineup {
  OneLineupModel({
    required super.team,
    required super.coach,
    required super.formation,
    required super.startXi,
    required super.substitutes,
  });

  factory OneLineupModel.fromJson(Map<String, dynamic> json) => OneLineupModel(
    team: OneTeamModel.fromJson(json["team"] ?? {}),
    coach: OneCoachModel.fromJson(json["coach"] ?? {}),
    formation: json["formation"] ?? "",

    startXi: (json["startXI"] as List? ?? [])
        .map((x) => OneStartXiModel.fromJson(x))
        .toList(),

    substitutes: (json["substitutes"] as List? ?? [])
        .map((x) => OneStartXiModel.fromJson(x))
        .toList(),
  );
}

class OneCoachModel extends OneCoach {
  OneCoachModel({required super.id, required super.name, required super.photo});

  factory OneCoachModel.fromJson(Map<String, dynamic> json) =>
      OneCoachModel(id: json["id"], name: json["name"], photo: json["photo"]);
}

class OneStartXiModel extends OneStartXi {
  OneStartXiModel({required super.player});

  factory OneStartXiModel.fromJson(Map<String, dynamic> json) =>
      OneStartXiModel(player: OneStartXiPlayerModel.fromJson(json["player"]));
}

class OneStartXiPlayerModel extends OneStartXiPlayer {
  OneStartXiPlayerModel({
    required super.id,
    required super.name,
    required super.number,
    required super.pos,
    required super.grid,
  });

  factory OneStartXiPlayerModel.fromJson(Map<String, dynamic> json) =>
      OneStartXiPlayerModel(
        id: json["id"],
        name: json["name"],
        number: json["number"],
        pos: json["pos"],
        grid: json["grid"],
      );
}

class OneResponsePlayerModel extends OneResponsePlayer {
  OneResponsePlayerModel({required super.team, required super.players});

  factory OneResponsePlayerModel.fromJson(Map<String, dynamic> json) =>
      OneResponsePlayerModel(
        team: OneTeamModel.fromJson(json["team"] ?? {}),
        players: (json["players"] as List? ?? [])
            .map((x) => OnePlayerModel.fromJson(x))
            .toList(),
      );
}

class OnePlayerModel extends OnePlayer {
  OnePlayerModel({required super.player, required super.statistics});

  factory OnePlayerModel.fromJson(Map<String, dynamic> json) => OnePlayerModel(
    player: json["player"] != null
        ? OneCoachModel.fromJson(json["player"])
        : OneCoachModel(id: null, name: "", photo: ""),

    statistics: (json["statistics"] as List? ?? [])
        .map((x) => OnePlayerStatisticModel.fromJson(x))
        .toList(),
  );
}

class OnePlayerStatisticModel extends OnePlayerStatistic {
  OnePlayerStatisticModel({
    required super.games,
    required super.offsides,
    required super.shots,
    required super.goals,
    required super.passes,
    required super.tackles,
    required super.duels,
    required super.dribbles,
    required super.fouls,
    required super.cards,
    required super.penalty,
  });

  factory OnePlayerStatisticModel.fromJson(Map<String, dynamic> json) =>
      OnePlayerStatisticModel(
        games: OneGamesModel.fromJson(json["games"]),
        offsides: json["offsides"],
        shots: OneShotsModel.fromJson(json["shots"]),
        goals: OneStatisticGoalsModel.fromJson(json["goals"]),
        passes: OnePassesModel.fromJson(json["passes"]),
        tackles: OneTacklesModel.fromJson(json["tackles"]),
        duels: OneDuelsModel.fromJson(json["duels"]),
        dribbles: OneDribblesModel.fromJson(json["dribbles"]),
        fouls: OneFoulsModel.fromJson(json["fouls"]),
        cards: OneCardsModel.fromJson(json["cards"]),
        penalty: OnePenaltyModel.fromJson(json["penalty"]),
      );
}

class OneCardsModel extends OneCards {
  OneCardsModel({required super.yellow, required super.red});

  factory OneCardsModel.fromJson(Map<String, dynamic> json) =>
      OneCardsModel(yellow: json["yellow"], red: json["red"]);
}

class OneDribblesModel extends OneDribbles {
  OneDribblesModel({
    required super.attempts,
    required super.success,
    required super.past,
  });

  factory OneDribblesModel.fromJson(Map<String, dynamic> json) =>
      OneDribblesModel(
        attempts: json["attempts"],
        success: json["success"],
        past: json["past"],
      );
}

class OneDuelsModel extends OneDuels {
  OneDuelsModel({required super.total, required super.won});

  factory OneDuelsModel.fromJson(Map<String, dynamic> json) =>
      OneDuelsModel(total: json["total"], won: json["won"]);
}

class OneFoulsModel extends OneFouls {
  OneFoulsModel({required super.drawn, required super.committed});

  factory OneFoulsModel.fromJson(Map<String, dynamic> json) =>
      OneFoulsModel(drawn: json["drawn"], committed: json["committed"]);
}

class OneGamesModel extends OneGames {
  OneGamesModel({
    required super.minutes,
    required super.number,
    required super.position,
    required super.rating,
    required super.captain,
    required super.substitute,
  });

  factory OneGamesModel.fromJson(Map<String, dynamic> json) => OneGamesModel(
    minutes: json["minutes"],
    number: json["number"],
    position: json["position"]!,
    rating: json["rating"],
    captain: json["captain"],
    substitute: json["substitute"],
  );
}

class OneStatisticGoalsModel extends OneStatisticGoals {
  OneStatisticGoalsModel({
    required super.total,
    required super.conceded,
    required super.assists,
    required super.saves,
  });

  factory OneStatisticGoalsModel.fromJson(Map<String, dynamic> json) =>
      OneStatisticGoalsModel(
        total: json["total"],
        conceded: json["conceded"],
        assists: json["assists"],
        saves: json["saves"],
      );
}

class OnePassesModel extends OnePasses {
  OnePassesModel({
    required super.total,
    required super.key,
    required super.accuracy,
  });

  factory OnePassesModel.fromJson(Map<String, dynamic> json) => OnePassesModel(
    total: json["total"],
    key: json["key"],
    accuracy: json["accuracy"],
  );
}

class OnePenaltyModel extends OnePenalty {
  OnePenaltyModel({
    required super.won,
    required super.commited,
    required super.scored,
    required super.missed,
    required super.saved,
  });

  factory OnePenaltyModel.fromJson(Map<String, dynamic> json) =>
      OnePenaltyModel(
        won: json["won"],
        commited: json["commited"],
        scored: json["scored"],
        missed: json["missed"],
        saved: json["saved"],
      );
}

class OneShotsModel extends OneShots {
  OneShotsModel({required super.total, required super.on});

  factory OneShotsModel.fromJson(Map<String, dynamic> json) =>
      OneShotsModel(total: json["total"], on: json["on"]);
}

class OneTacklesModel extends OneTackles {
  OneTacklesModel({
    required super.total,
    required super.blocks,
    required super.interceptions,
  });

  factory OneTacklesModel.fromJson(Map<String, dynamic> json) =>
      OneTacklesModel(
        total: json["total"],
        blocks: json["blocks"],
        interceptions: json["interceptions"],
      );
}

class OneScoreModel extends OneScore {
  OneScoreModel({
    required super.halftime,
    required super.fulltime,
    required super.extratime,
    required super.penalty,
  });

  factory OneScoreModel.fromJson(Map<String, dynamic> json) => OneScoreModel(
    halftime: OneGoalsClassModel.fromJson(json["halftime"] ?? {}),
    fulltime: OneGoalsClassModel.fromJson(json["fulltime"] ?? {}),
    extratime: OneGoalsClassModel.fromJson(json["extratime"] ?? {}),
    penalty: OneGoalsClassModel.fromJson(json["penalty"] ?? {}),
  );
}

class OneResponseStatisticModel extends OneResponseStatistic {
  OneResponseStatisticModel({required super.team, required super.statistics});

  factory OneResponseStatisticModel.fromJson(Map<String, dynamic> json) =>
      OneResponseStatisticModel(
        team: OneTeamModel.fromJson(json["team"]),
        statistics: List<OneStatisticModel>.from(
          json["statistics"].map((x) => OneStatisticModel.fromJson(x)),
        ),
      );
}

class OneStatisticModel extends OneStatistic {
  OneStatisticModel({required super.type, required super.value});

  factory OneStatisticModel.fromJson(Map<String, dynamic> json) =>
      OneStatisticModel(type: json["type"], value: json["value"]);
}
