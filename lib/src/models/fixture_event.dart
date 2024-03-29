class FixtureEvent {
  Time? time;
  Team? team;
  Player? player;
  Player? assist;
  String? type;
  String? detail;
  String? comments;

  FixtureEvent(
      {this.time,
      this.team,
      this.player,
      this.assist,
      this.type,
      this.detail,
      this.comments});

  FixtureEvent.fromJson(Map<String, dynamic> json) {
    time = json['time'] != null ? Time.fromJson(json['time']) : null;
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    player =
        json['player'] != null ? Player.fromJson(json['player']) : null;
    assist =
        json['assist'] != null ? Player.fromJson(json['assist']) : null;
    type = json['type'];
    detail = json['detail'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (time != null) {
      data['time'] = time!.toJson();
    }
    if (team != null) {
      data['team'] = team!.toJson();
    }
    if (player != null) {
      data['player'] = player!.toJson();
    }
    if (assist != null) {
      data['assist'] = assist!.toJson();
    }
    data['type'] = type;
    data['detail'] = detail;
    data['comments'] = comments;
    return data;
  }
}

class Time {
  int? elapsed;
  int? extra;

  Time({this.elapsed, this.extra});

  Time.fromJson(Map<String, dynamic> json) {
    elapsed = json['elapsed'];
    extra = json['extra'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['elapsed'] = elapsed;
    data['extra'] = extra;
    return data;
  }
}

class Team {
  int? id;
  String? name;
  String? logo;

  Team({this.id, this.name, this.logo});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['logo'] = logo;
    return data;
  }
}

class Player {
  int? id;
  String? name;

  Player({this.id, this.name});

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}