import 'package:matchup/features/players/domain/entitys/one_player.dart';

class AllPlayers {
  String allPLayersGet;
  List<dynamic> parameters;
  List<dynamic> errors;
  int results;
  Paging paging;
  List<Response> response;

  AllPlayers({
    required this.allPLayersGet,
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

class Response {
  Player player;

  Response({
    required this.player,
  });
}