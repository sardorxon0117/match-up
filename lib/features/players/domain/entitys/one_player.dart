class PlayerProfile {
  String playerProfileGet;
  Parameters parameters;
  List<dynamic> errors;
  int results;
  Paging paging;
  List<Response> response;

  PlayerProfile({
    required this.playerProfileGet,
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
}

class Parameters {
  String player;

  Parameters({
    required this.player,
  });
}

class Response {
  Player player;

  Response({
    required this.player,
  });
}

class Player {
  int id;
  String name;
  String? firstname;
  String? lastname;
  int? age;
  Birth? birth;
  String? nationality;
  String? height;
  String? weight;
  int? number;
  String? position;
  String photo;

  Player({
    required this.id,
    required this.name,
    required this.firstname,
    required this.lastname,
    required this.age,
    required this.birth,
    required this.nationality,
    required this.height,
    required this.weight,
    required this.number,
    required this.position,
    required this.photo,
  });
}

class Birth {
  DateTime? date;
  String? place;
  String? country;

  Birth({
    required this.date,
    required this.place,
    required this.country,
  });
}
