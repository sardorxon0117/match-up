import 'package:matchup/features/home/domain/entities/game.dart';

class AllGames {
  String? gamesGet;
  Parameters parameters;
  List<dynamic> errors;
  int? results;
  Paging paging;
  List<OneResponse>? response;

  AllGames({
    required this.gamesGet,
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
  DateTime date;

  Parameters({
    required this.date,
  });
}