class OneGame {
  String? oneGameGet;
  OneParameters parameters;
  List<dynamic>? errors;
  int results;
  OnePaging paging;
  List<OneResponse>? response;

  OneGame({
    required this.oneGameGet,
    required this.parameters,
    required this.errors,
    required this.results,
    required this.paging,
    required this.response,
  });
}

class OnePaging {
  int? current;
  int? total;

  OnePaging({
    required this.current,
    required this.total,
  });
}

class OneParameters {
  String? id;

  OneParameters({
    required this.id,
  });
}

class OneResponse {
  OneFixture fixture;
  OneLeague league;
  OneTeamsClass teams;
  OneGoalsClass goals;
  OneScore score;
  List<OneEvent>? events;
  List<OneLineup>? lineups;
  List<OneResponseStatistic>? statistics;
  List<OneResponsePlayer>? players;

  OneResponse({
    required this.fixture,
    required this.league,
    required this.teams,
    required this.goals,
    required this.score,
    required this.events,
    required this.lineups,
    required this.statistics,
    required this.players,
  });
}

class OneEvent {
  OneTime time;
  OneTeam team;
  OneEventPlayer player;
  OneAssist assist;
  String? type;
  String? detail;
  String? comments;

  OneEvent({
    required this.time,
    required this.team,
    required this.player,
    required this.assist,
    required this.type,
    required this.detail,
    required this.comments,
  });
}

class OneEventPlayer {
  int? id;
  String? name;

  OneEventPlayer({
    required this.id,
    required this.name,
  });
}

class OneAssist {
  int? id;
  String? name;

  OneAssist({
    required this.id,
    required this.name,
  });
}


class OneTeam {
  int? id;
  String? name;
  String? logo;
  OneColors? colors;
  DateTime? update;
  bool? winner;

  OneTeam({
    required this.id,
    required this.name,
    required this.logo,
    this.colors,
    this.update,
    this.winner,
  });
}

class OneColors {
  OneGoalkeeper player;
  OneGoalkeeper goalkeeper;

  OneColors({
    required this.player,
    required this.goalkeeper,
  });
}

class OneGoalkeeper {
  String? primary;
  String? number;
  String? border;

  OneGoalkeeper({
    required this.primary,
    required this.number,
    required this.border,
  });
}

class OneTime {
  int? elapsed;
  int? extra;

  OneTime({
    required this.elapsed,
    required this.extra,
  });
}

class OneFixture {
  int? id;
  String? referee;
  String? timezone;
  DateTime? date;
  int? timestamp;
  OnePeriods periods;
  OneVenue venue;
  OneStatus status;

  OneFixture({
    required this.id,
    required this.referee,
    required this.timezone,
    required this.date,
    required this.timestamp,
    required this.periods,
    required this.venue,
    required this.status,
  });
}

class OnePeriods {
  int? first;
  int? second;

  OnePeriods({
    required this.first,
    required this.second,
  });
}

class OneStatus {
  String? long;
  String? short;
  int? elapsed;
  int? extra;

  OneStatus({
    required this.long,
    required this.short,
    required this.elapsed,
    required this.extra,
  });
}

class OneVenue {
  int? id;
  String? name;
  String? city;

  OneVenue({
    required this.id,
    required this.name,
    required this.city,
  });
}

class OneTeamsClass {
  OneTeam home;
  OneTeam away;

  OneTeamsClass({
    required this.home,
    required this.away,
  });
}

class OneGoalsClass {
  dynamic home;
  dynamic away;

  OneGoalsClass({
    required this.home,
    required this.away,
  });
}

class OneLeague {
  int? id;
  String? name;
  String? country;
  String? logo;
  String? flag;
  int? season;
  String? round;
  bool? standings;

  OneLeague({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.flag,
    required this.season,
    required this.round,
    required this.standings,
  });
}

class OneLineup {
  OneTeam team;
  OneCoach coach;
  String? formation;
  List<OneStartXi>? startXi;
  List<OneStartXi>? substitutes;

  OneLineup({
    required this.team,
    required this.coach,
    required this.formation,
    required this.startXi,
    required this.substitutes,
  });
}

class OneCoach {
  int? id;
  String? name;
  String? photo;

  OneCoach({
    required this.id,
    required this.name,
    required this.photo,
  });
}

class OneStartXi {
  OneStartXiPlayer player;

  OneStartXi({
    required this.player,
  });
}

class OneStartXiPlayer {
  int? id;
  String? name;
  int? number;
  String? pos;
  String? grid;

  OneStartXiPlayer({
    required this.id,
    required this.name,
    required this.number,
    required this.pos,
    required this.grid,
  });
}

class OneResponsePlayer {
  OneTeam team;
  List<OnePlayer>? players;

  OneResponsePlayer({
    required this.team,
    required this.players,
  });
}

class OnePlayer {
  OneCoach player;
  List<OnePlayerStatistic>? statistics;

  OnePlayer({
    required this.player,
    required this.statistics,
  });
}

class OnePlayerStatistic {
  OneGames games;
  int? offsides;
  OneShots shots;
  OneStatisticGoals goals;
  OnePasses passes;
  OneTackles tackles;
  OneDuels duels;
  OneDribbles dribbles;
  OneFouls fouls;
  OneCards cards;
  OnePenalty penalty;

  OnePlayerStatistic({
    required this.games,
    required this.offsides,
    required this.shots,
    required this.goals,
    required this.passes,
    required this.tackles,
    required this.duels,
    required this.dribbles,
    required this.fouls,
    required this.cards,
    required this.penalty,
  });
}

class OneCards {
  int? yellow;
  int? red;

  OneCards({
    required this.yellow,
    required this.red,
  });
}

class OneDribbles {
  int? attempts;
  int? success;
  int? past;

  OneDribbles({
    required this.attempts,
    required this.success,
    required this.past,
  });
}

class OneDuels {
  int? total;
  int? won;

  OneDuels({
    required this.total,
    required this.won,
  });
}

class OneFouls {
  int? drawn;
  int? committed;

  OneFouls({
    required this.drawn,
    required this.committed,
  });
}

class OneGames {
  int? minutes;
  int? number;
  String? position;
  String? rating;
  bool? captain;
  bool? substitute;

  OneGames({
    required this.minutes,
    required this.number,
    required this.position,
    required this.rating,
    required this.captain,
    required this.substitute,
  });
}

class OneStatisticGoals {
  int? total;
  int? conceded;
  int? assists;
  int? saves;

  OneStatisticGoals({
    required this.total,
    required this.conceded,
    required this.assists,
    required this.saves,
  });
}

class OnePasses {
  int? total;
  int? key;
  String? accuracy;

  OnePasses({
    required this.total,
    required this.key,
    required this.accuracy,
  });
}

class OnePenalty {
  int? won;
  int? commited;
  int? scored;
  int? missed;
  int? saved;

  OnePenalty({
    required this.won,
    required this.commited,
    required this.scored,
    required this.missed,
    required this.saved,
  });
}

class OneShots {
  int? total;
  int? on;

  OneShots({
    required this.total,
    required this.on,
  });
}

class OneTackles {
  int? total;
  int? blocks;
  int? interceptions;

  OneTackles({
    required this.total,
    required this.blocks,
    required this.interceptions,
  });
}

class OneScore {
  OneGoalsClass halftime;
  OneGoalsClass fulltime;
  OneGoalsClass extratime;
  OneGoalsClass penalty;

  OneScore({
    required this.halftime,
    required this.fulltime,
    required this.extratime,
    required this.penalty,
  });
}

class OneResponseStatistic {
  OneTeam team;
  List<OneStatistic>? statistics;

  OneResponseStatistic({
    required this.team,
    required this.statistics,
  });
}

class OneStatistic {
  String? type;
  dynamic value;

  OneStatistic({
    required this.type,
    required this.value,
  });
}
