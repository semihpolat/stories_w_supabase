class StoriesModel {
  int? id;
  String? name;
  String? pp;

  StoriesModel({this.id, this.name, this.pp});

  StoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pp = json['pp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pp'] = this.pp;
    return data;
  }
}
