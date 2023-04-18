import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iotanic_app_dev/view/App/index.dart';
import 'package:iotanic_app_dev/view/Auth/signin.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import '../model/auth.dart';
import '../model/user.dart';

class LoginBloC extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  // User user = User();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> signin(BuildContext context) async {
    var headers = {'Content-Type': 'application/json', 'x-api-key': API_KEY};

    try {
      // expected to post http://localhost:5000/auth/signin
      var url = Uri.parse(Auth.baseUrl + Auth.authEndPoints.signin);
      Map body = {
        'email': email.text,
        'password': password.text,
      };

      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == true) {
          var token = json['token'];
          final SharedPreferences prefs = await _prefs;

          await prefs.setString('token', token);
          email.clear();
          password.clear();

          // save prefs attribut user from token
          Map<String, dynamic> session = JwtDecoder.decode(token);
          print(session['user']['address']['id']);
          // print(session['address']['id']);

          User.saveAuth(
            session['user']['name'],
            session['user']['email'],
            session['user']['phone_number'],
            session['user']['address']['id'],
            session['user']['role'],
            session['user']['created_at'],
            session['user']['updated_at'],
          );

          // go to homepage()
          Get.snackbar(
            "Login Berhasil",
            'Selamat datang user',
            colorText: Theme.of(context).primaryColor,
            margin: const EdgeInsets.all(20),
          );
          Get.off(const Index());
        } else {
          Get.snackbar(
            "Login Gagal",
            'Unknown Error',
            colorText: Theme.of(context).primaryColor,
            margin: const EdgeInsets.all(20),
          );
        }
      } else {
        // print("status: " + response.statusCode.toString());
        Get.snackbar(
          "Email / Password Salah",
          'Periksa kembali email dan password anda',
          colorText: Theme.of(context).primaryColor,
          margin: const EdgeInsets.all(20),
        );
      }
    } catch (e) {
      // Get.back();
      Get.snackbar(
        "Login Gagal",
        'Tidak Terhubung ke Server Aplikasi',
        colorText: Theme.of(context).primaryColor,
        margin: const EdgeInsets.all(20),
      );
    }
  }

  Future<void> signout() async {
    final SharedPreferences prefs = await _prefs;
    print(prefs.getString('token'));
    prefs.remove('token');

    Get.off(const SignIn());
  }
}
