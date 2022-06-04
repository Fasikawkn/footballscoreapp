class Country {
  String? name;
  String? code;
  String? flag;

  Country({this.name, this.code, this.flag});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['flag'] = flag;
    return data;
  }
}