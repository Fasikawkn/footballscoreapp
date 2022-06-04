class CoachModel {
  int? id;
  String? name;
  String? firstname;
  String? lastname;
  int? age;
  Birth? birth;
  String? nationality;
  String? height;
  String? weight;
  String? photo;
  Team? team;
  List<Career>? career;

  CoachModel(
      {this.id,
      this.name,
      this.firstname,
      this.lastname,
      this.age,
      this.birth,
      this.nationality,
      this.height,
      this.weight,
      this.photo,
      this.team,
      this.career});

  CoachModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    age = json['age'];
    birth = json['birth'] != null ? Birth.fromJson(json['birth']) : null;
    nationality = json['nationality'];
    height = json['height'];
    weight = json['weight'];
    photo = json['photo'];
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    if (json['career'] != null) {
      career = <Career>[];
      json['career'].forEach((v) {
        career!.add(Career.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['age'] = age;
    if (birth != null) {
      data['birth'] = birth!.toJson();
    }
    data['nationality'] = nationality;
    data['height'] = height;
    data['weight'] = weight;
    data['photo'] = photo;
    if (team != null) {
      data['team'] = team!.toJson();
    }
    if (career != null) {
      data['career'] = career!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Birth {
  String? date;
  String? place;
  String? country;

  Birth({this.date, this.place, this.country});

  Birth.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    place = json['place'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['place'] = place;
    data['country'] = country;
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

class Career {
  Team? team;
  String? start;
  String? end;

  Career({this.team, this.start, this.end});

  Career.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (team != null) {
      data['team'] = team!.toJson();
    }
    data['start'] = start;
    data['end'] = end;
    return data;
  }
}