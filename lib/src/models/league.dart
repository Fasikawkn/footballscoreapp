

// To parse this JSON data, do
//
//     final league = leagueFromJson(jsonString);

import 'dart:convert';

League leagueFromJson(String str) => League.fromJson(json.decode(str));

String leagueToJson(League data) => json.encode(data.toJson());

class League {
    League({
        this.league,
        this.country,
        this.seasons,
    });

    LeagueClass? league;
    Country? country;
    List<Season>? seasons;

    factory League.fromJson(Map<String, dynamic> json) => League(
        league: LeagueClass.fromJson(json["league"]),
        country: Country.fromJson(json["country"]),
        seasons: List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "league": league!.toJson(),
        "country": country!.toJson(),
        "seasons": List<dynamic>.from(seasons!.map((x) => x.toJson())),
    };
}

class Country {
    Country({
        this.name,
        this.code,
        this.flag,
    });

    String? name;
    dynamic code;
    dynamic flag;

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json["name"],
        code: json["code"],
        flag: json["flag"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "flag": flag,
    };
}

class LeagueClass {
    LeagueClass({
        this.id,
        this.name,
        this.type,
        this.logo,
    });

    int? id;
    String? name;
    String? type;
    String? logo;

    factory LeagueClass.fromJson(Map<String, dynamic> json) => LeagueClass(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        logo: json["logo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "logo": logo,
    };
}

class Season {
    Season({
        this.year,
        this.start,
        this.end,
        this.current,
        this.coverage,
    });

    int? year;
    DateTime? start;
    DateTime? end;
    bool? current;
    Coverage? coverage;

    factory Season.fromJson(Map<String, dynamic> json) => Season(
        year: json["year"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        current: json["current"],
        coverage: Coverage.fromJson(json["coverage"]),
    );

    Map<String, dynamic> toJson() => {
        "year": year,
        "start": "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
        "end": "${end!.year.toString().padLeft(4, '0')}-${end!.month.toString().padLeft(2, '0')}-${end!.day.toString().padLeft(2, '0')}",
        "current": current,
        "coverage": coverage!.toJson(),
    };
}

class Coverage {
    Coverage({
        this.fixtures,
        this.standings,
        this.players,
        this.topScorers,
        this.topAssists,
        this.topCards,
        this.injuries,
        this.predictions,
        this.odds,
    });

    Fixtures? fixtures;
    bool? standings;
    bool? players;
    bool? topScorers;
    bool? topAssists;
    bool? topCards;
    bool? injuries;
    bool? predictions;
    bool? odds;

    factory Coverage.fromJson(Map<String, dynamic> json) => Coverage(
        fixtures: Fixtures.fromJson(json["fixtures"]),
        standings: json["standings"],
        players: json["players"],
        topScorers: json["top_scorers"],
        topAssists: json["top_assists"],
        topCards: json["top_cards"],
        injuries: json["injuries"],
        predictions: json["predictions"],
        odds: json["odds"],
    );

    Map<String, dynamic> toJson() => {
        "fixtures": fixtures!.toJson(),
        "standings": standings,
        "players": players,
        "top_scorers": topScorers,
        "top_assists": topAssists,
        "top_cards": topCards,
        "injuries": injuries,
        "predictions": predictions,
        "odds": odds,
    };
}

class Fixtures {
    Fixtures({
        this.events,
        this.lineups,
        this.statisticsFixtures,
        this.statisticsPlayers,
    });

    bool? events;
    bool? lineups;
    bool? statisticsFixtures;
    bool? statisticsPlayers;

    factory Fixtures.fromJson(Map<String, dynamic> json) => Fixtures(
        events: json["events"],
        lineups: json["lineups"],
        statisticsFixtures: json["statistics_fixtures"],
        statisticsPlayers: json["statistics_players"],
    );

    Map<String, dynamic> toJson() => {
        "events": events,
        "lineups": lineups,
        "statistics_fixtures": statisticsFixtures,
        "statistics_players": statisticsPlayers,
    };
}
