import 'package:vehicles_app/models/response.dart';

class Token {
  // Response response = [];
  Response response = Response(errors: []);
  String token = '';
  String userId = '';
  String userName = '';
  String name = '';
  List<String> roles = [];

  Token(
      {required this.response,
      required this.token,
      required this.userId,
      required this.userName,
      required this.name,
      required this.roles});

  Token.fromJson(Map<String, dynamic> json) {
    //  response = json['response'];

    response = Response.fromJson(json['response']);

    token = json['token'];
    userId = json['userId'];
    userName = json['userName'];
    name = json['name'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    data['token'] = token;
    data['userId'] = userId;
    data['userName'] = userName;
    data['name'] = name;
    data['roles'] = roles;
    return data;
  }
}
