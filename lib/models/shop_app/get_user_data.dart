class GetUserData {
  late bool status;
  Userinfo? data;

  GetUserData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Userinfo.fromJson(json['data']) : null;
  }
}

class Userinfo {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  Userinfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
