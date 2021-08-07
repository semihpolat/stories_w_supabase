class UserModel {
  int? id;
  String? username;
  String? password;
  String? pp;
  String? bio;

  UserModel({this.id, this.username, this.password, this.pp, this.bio});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    pp = json['pp'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['pp'] = this.pp;
    data['bio'] = this.bio;
    return data;
  }
}
