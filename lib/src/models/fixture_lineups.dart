class TeamLineupModel {
  Team? team;
  Coach? coach;
  String? formation;
  List<StartXI>? startXI;
  List<Substitutes>? substitutes;

  TeamLineupModel(
      {this.team, this.coach, this.formation, this.startXI, this.substitutes});

  TeamLineupModel.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    coach = json['coach'] != null ? Coach.fromJson(json['coach']) : null;
    formation = json['formation'];
    if (json['startXI'] != null) {
      startXI = <StartXI>[];
      json['startXI'].forEach((v) {
        startXI!.add(StartXI.fromJson(v));
      });
    }
    if (json['substitutes'] != null) {
      substitutes = <Substitutes>[];
      json['substitutes'].forEach((v) {
        substitutes!.add(Substitutes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (team != null) {
      data['team'] = team!.toJson();
    }
    if (coach != null) {
      data['coach'] = coach!.toJson();
    }
    data['formation'] = formation;
    if (startXI != null) {
      data['startXI'] = startXI!.map((v) => v.toJson()).toList();
    }
    if (substitutes != null) {
      data['substitutes'] = substitutes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Team {
  int? id;
  String? name;
  String? logo;
  ColorsTeam? colors;

  Team({this.id, this.name, this.logo, this.colors});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    colors =
        json['colors'] != null ? ColorsTeam.fromJson(json['colors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['logo'] = logo;
    if (colors != null) {
      data['colors'] = colors!.toJson();
    }
    return data;
  }
}

class ColorsTeam {
  ColorPlayer? player;
  ColorPlayer? goalkeeper;

  ColorsTeam({this.player, this.goalkeeper});

  ColorsTeam.fromJson(Map<String, dynamic> json) {
    player =
        json['player'] != null ? ColorPlayer.fromJson(json['player']) : null;
    goalkeeper = json['goalkeeper'] != null
        ? ColorPlayer.fromJson(json['goalkeeper'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (player != null) {
      data['player'] = player!.toJson();
    }
    if (goalkeeper != null) {
      data['goalkeeper'] = goalkeeper!.toJson();
    }
    return data;
  }
}

class ColorPlayer {
  String? primary;
  String? number;
  String? border;

  ColorPlayer({this.primary, this.number, this.border});

  ColorPlayer.fromJson(Map<String, dynamic> json) {
    primary = json['primary'];
    number = json['number'];
    border = json['border'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['primary'] = primary;
    data['number'] = number;
    data['border'] = border;
    return data;
  }
}

class Coach {
  int? id;
  String? name;
  String? photo;

  Coach({this.id, this.name, this.photo});

  Coach.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['photo'] = photo;
    return data;
  }
}

class StartXI {
  Player? player;

  StartXI({this.player});

  StartXI.fromJson(Map<String, dynamic> json) {
    player =
        json['player'] != null ? Player.fromJson(json['player']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (player != null) {
      data['player'] = player!.toJson();
    }
    return data;
  }
}

class Player {
  int? id;
  String? name;
  int? number;
  String? pos;
  String? grid;

  Player({this.id, this.name, this.number, this.pos, this.grid});

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    pos = json['pos'];
    grid = json['grid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['number'] = number;
    data['pos'] = pos;
    data['grid'] = grid;
    return data;
  }
}



class Substitutes {
  Player? player;

  Substitutes({this.player});

  Substitutes.fromJson(Map<String, dynamic> json) {
    player =
        json['player'] != null ? Player.fromJson(json['player']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (player != null) {
      data['player'] = player!.toJson();
    }
    return data;
  }
}