
import 'package:footballscoreapp/src/models/league.dart';

class TeamLeagueModel{
  League? league;
  TeamModel? teamModel;

  TeamLeagueModel({
    this.league,
    this.teamModel
  });
}


class TeamModel {
  Team? team;
  Venue? venue;

  TeamModel({this.team, this.venue});

  TeamModel.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (team != null) {
      data['team'] = team!.toJson();
    }
    if (venue != null) {
      data['venue'] = venue!.toJson();
    }
    return data;
  }
}

class Team {
  int? id;
  String? name;
  String? code;
  String? country;
  int? founded;
  bool? national;
  String? logo;

  Team(
      {this.id,
      this.name,
      this.code,
      this.country,
      this.founded,
      this.national,
      this.logo});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    country = json['country'];
    founded = json['founded'];
    national = json['national'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['country'] = country;
    data['founded'] = founded;
    data['national'] = national;
    data['logo'] = logo;
    return data;
  }
}

class Venue {
  int? id;
  String? name;
  String? address;
  String? city;
  int? capacity;
  String? surface;
  String? image;

  Venue(
      {this.id,
      this.name,
      this.address,
      this.city,
      this.capacity,
      this.surface,
      this.image});

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    capacity = json['capacity'];
    surface = json['surface'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['city'] = city;
    data['capacity'] = capacity;
    data['surface'] = surface;
    data['image'] = image;
    return data;
  }
}