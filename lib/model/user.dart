import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  String? id;
  String? email;

  User({this.id, this.email});

  factory User.createUser(Map<String, dynamic> object) {
    return User(
      id: object['id'],
      email: object['email'],
    );
  }

  static Future<User> connectToApi(String email) async {
    String apiURL = "http://34.101.57.46:8080/user/?role=USER?email=" + email;

    var apiResult = await http.get(apiURL as Uri);
    var jsonObject = json.decode(apiResult.body);
    var userData = (jsonObject as Map<String, dynamic>);

    return User.createUser(userData);
  }
}

class UninitializedUser extends User {}
