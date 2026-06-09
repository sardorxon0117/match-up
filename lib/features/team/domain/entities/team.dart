class TeamProfile {
  String teamProfileGet;
  Parameters parameters;
  List<dynamic> errors;
  int results;
  Paging paging;
  List<Response> response;

  TeamProfile({
    required this.teamProfileGet,
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

class Response {
  Team team;
  Venue venue;

  Response({
    required this.team,
    required this.venue,
  });
}

class Team {
  int id;
  String name;
  String code;
  String country;
  int founded;
  bool national;
  String logo;

  Team({
    required this.id,
    required this.name,
    required this.code,
    required this.country,
    required this.founded,
    required this.national,
    required this.logo,
  });
}

class Venue {
  int id;
  String name;
  String address;
  String city;
  int capacity;
  String surface;
  String image;

  Venue({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.capacity,
    required this.surface,
    required this.image,
  });
}
