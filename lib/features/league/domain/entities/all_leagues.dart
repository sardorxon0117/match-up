import 'package:matchup/features/league/domain/entities/one_league.dart';

class Leaguees {
  String leaguesGet;
  Parameters parameters;
  List<dynamic> errors;
  int results;
  Paging paging;
  List<OneLeaguee> response;

  Leaguees({
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
  String? search;

  Parameters({
    required this.search,
  });
}