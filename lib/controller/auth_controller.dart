import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iotanic_app_dev/view/App/index.dart';
import 'package:iotanic_app_dev/view/Auth/signin.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import '../model/conn.dart';
import '../model/user.dart';

class AuthController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController repassword = TextEditingController();
  TextEditingController province = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController regency = TextEditingController();
  TextEditingController village = TextEditingController();
  // User user = User();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /// Melakukan proses autentikasi login pengguna.
  ///
  /// Fungsi ini mengirim permintaan HTTP POST ke endpoint API untuk proses autentikasi login pengguna.
  /// Permintaan tersebut mencakup email dan password yang diambil dari kontroler `email` dan `password`.
  ///
  /// Fungsi ini tidak mengembalikan nilai (`void`), tetapi mengubah status aplikasi dan menampilkan notifikasi
  /// atau tampilan sesuai dengan hasil autentikasi.
  ///
  /// Perhatian: Fungsi ini mengharapkan adanya konstanta `API_KEY` yang telah didefinisikan sebelumnya.
  ///
  /// Throws:
  ///   - Jika terjadi kesalahan selama permintaan HTTP atau pemrosesan data, fungsi ini akan melempar Exception.

  Future<void> signin(BuildContext context) async {
    var headers = {'Content-Type': 'application/json', 'x-api-key': API_KEY};

    try {
      // expected to post http://localhost:5000/auth/signin
      var url = Uri.parse(Conn.baseUrl + Conn.endPoints.signin);
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
          print(session['user']);
          // print(session['address']['id']);

          User.saveAuth(
            session['user']['id'],
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
        'Tidak Terhubung ke Server Aplikasi | $e',
        colorText: Theme.of(context).primaryColor,
        margin: const EdgeInsets.all(20),
      );
    }
  }

  Future<void> signout() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove('token');

    Get.off(const SignIn());
  }

  Future<void> signup(BuildContext context) async {
    var headers = {'Content-Type': 'application/json', 'x-api-key': API_KEY};
    try {
      var url = Uri.parse(Conn.baseUrl + Conn.endPoints.signup);
      var address = province.text + '.' + district.text + '.' + regency.text + '.' + village.text;
      Map body = {
        'name': name.text,
        'email': email.text,
        'password': password.text,
        'phone_number': phone.text,
        'address': '33.72.01.1005',
      };

      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == true) {
          Get.snackbar(
            "Sign Up Berhasil",
            'Akun berhasil terdaftar',
            colorText: Theme.of(context).primaryColor,
            margin: const EdgeInsets.all(20),
          );
          Get.off(const SignIn());
        }
      } else {
        final json = jsonDecode(response.body);
        if (json['success'] == false) {
          Get.snackbar(
            "Sign Up Gagal",
            json['error'],
            colorText: Theme.of(context).primaryColor,
            margin: const EdgeInsets.all(20),
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        "Sign Up Gagal",
        'Nomor handphone sudah terdaftar',
        colorText: Theme.of(context).primaryColor,
        margin: const EdgeInsets.all(20),
      );
    }
  }
}
