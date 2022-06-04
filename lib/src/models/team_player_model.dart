class TeamPlayerModel {
  int? id;
  String? name;
  int? age;
  int? number;
  String? position;
  String? photo;

  TeamPlayerModel(
      {this.id, this.name, this.age, this.number, this.position, this.photo});

  TeamPlayerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    number = json['number'];
    position = json['position'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['age'] = this.age;
    data['number'] = this.number;
    data['position'] = this.position;
    data['photo'] = this.photo;
    return data;
  }
}


class TeamSquad{
  final String position;
  final List<TeamPlayerModel> player;

  const TeamSquad({
    required this.player,
    required this.position,
  });
}