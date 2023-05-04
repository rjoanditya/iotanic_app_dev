import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import '../constant.dart';
import '../model/conn.dart';
import '../model/user.dart';

class Land extends GetxController {
  // String id;
  // String user;

  // Land(this.id, this.user);

  static Future<Map> getLandById() async {
    User.getUser('id');
    var headers = {'Content-Type': 'application/json', 'x-api-key': API_KEY};
    // Map<String, dynamic> result;

    // expected to get http://localhost:5000/land
    var url = Uri.parse(Conn.baseUrl + Conn.endPoints.land + '?user_id=' + '${User.getUser('id')}');
    http.Response response = await http.get(url, headers: headers);
    final jsonData = json.decode(response.body);

    // Mapping data menjadi list of Map dengan hanya mengambil title dan id dari setiap data
    Map<String, dynamic> result = JwtDecoder.decode(jsonData['data']);

    return result;
  }
}
