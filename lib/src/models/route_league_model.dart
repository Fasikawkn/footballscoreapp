// To parse this JSON data, do
//
//     final routeLeagueModel = routeLeagueModelFromJson(jsonString);

import 'dart:convert';

RouteLeagueModel routeLeagueModelFromJson(String str) => RouteLeagueModel.fromJson(json.decode(str));

String routeLeagueModelToJson(RouteLeagueModel data) => json.encode(data.toJson());

class RouteLeagueModel {
    RouteLeagueModel({
        this.id,
        this.name,
        this.country,
        this.logo,
        this.flag,
        this.season,
        this.round,
    });

    int? id;
    String? name;
    String? country;
    String? logo;
    String? flag;
    int? season;
    String? round;

    RouteLeagueModel copyWith({
        int? id,
    String? name,
    String? country,
    String? logo,
    String? flag,
    int? season,
    String? round,
    }) => 
        RouteLeagueModel(
            id: id ?? this.id,
            name: name ?? this.name,
            country: country ?? this.country,
            logo: logo ?? this.logo,
            flag: flag ?? this.flag,
            season: season ?? this.season,
            round: round ?? this.round,
        );

    factory RouteLeagueModel.fromJson(Map<String, dynamic> json) => RouteLeagueModel(
        id: json["id"],
        name: json["name"],
        country: json["country"],
        logo: json["logo"],
        flag: json["flag"],
        season: json["season"],
        round: json["round"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
        "logo": logo,
        "flag": flag,
        "season": season,
        "round": round,
    };
}
