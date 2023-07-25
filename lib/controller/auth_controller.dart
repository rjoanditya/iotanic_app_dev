// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iotanic_app_dev/view/App/index.dart';
import 'package:iotanic_app_dev/view/Auth/signin.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/jwt.dart';
import '../service/api.dart';
import '../constant.dart';
import '../model/conn.dart';
import '../model/user.dart';

class AuthController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController repassword = TextEditingController();
  TextEditingController address = TextEditingController();

  TextEditingController province = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController regency = TextEditingController();
  TextEditingController village = TextEditingController();

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

  // Future<void> signin() async {
  //   final url = Conn.baseUrl + Conn.endPoints.signin; // Ganti dengan URL sign-in API yang sesuai
  //   final body = {'email': email.text, 'password': password.text};

  //   final response = await api.post(Uri.parse(url), body: body);
  //   if (response.statusCode == 200) {
  //     final token = jsonDecode(response.body)['token'];
  //     await setToken(token);

  //     print('Sign-in successful');
  //   } else {
  //     print('Sign-in failed');
  //   }
  // }

  Future<void> signin(BuildContext context) async {
    String baseUrl = await getApi();
    try {
      // expected to post http://localhost:5000/auth/signin
      var url = Uri.parse(baseUrl + Conn.endPoints.signin);
      Map body = {
        'email': email.text,
        'password': password.text,
      };

      final response = await api.post(url, body: body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == true) {
          var token = json['token'];

          await setToken(token);
          print(await getToken());
          // final SharedPreferences prefs = await _prefs;

          // await prefs.setString('token', token);
          email.clear();
          password.clear();

          // save prefs attribut user from token
          Map<String, dynamic> session = JwtDecoder.decode(token);

          User.saveAuth(
            session['payload']['id'],
            session['payload']['name'],
            session['payload']['email'],
            session['payload']['role'],
            // session['payload']['updated_at'],
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
        '$e',
        colorText: Theme.of(context).primaryColor,
        margin: const EdgeInsets.all(20),
      );
    }
  }

  /// Signs out the user and clears the token from shared preferences.
  ///
  /// This method removes the authentication token from the shared preferences,
  /// effectively signing out the user. After signing out, the user is navigated
  /// to the SignIn screen.
  ///
  /// Example usage:
  /// ```dart
  /// await signout();
  /// ```
  Future<void> signout() async {
    final SharedPreferences prefs = await _prefs;
    await destroyToken();

    Get.off(const SignIn());
  }

  /// Melakukan proses pendaftaran pengguna baru.
  ///
  /// Method ini digunakan untuk melakukan proses pendaftaran pengguna baru
  /// ke dalam aplikasi. Pengguna baru akan mengisi informasi seperti nama,
  /// email, password, nomor telepon, dan alamat. Setelah pendaftaran berhasil,
  /// pengguna akan diarahkan ke halaman SignIn.
  ///
  /// Parameter [context] digunakan untuk mendapatkan konteks dari widget yang
  /// memanggil method ini.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// await signup(context);
  /// ```
  Future<void> signup(BuildContext context) async {
    String baseUrl = await getApi();
    try {
      var url = Uri.parse(baseUrl + Conn.endPoints.signup);

      Map body = {
        'name': name.text,
        'email': email.text,
        'password': password.text,
        'phone_number': phone.text,
        'address': village.text,
      };

      http.Response response = await api.post(url, body: body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == true) {
          Get.snackbar(
            "Sign Up Berhasil",
            'Akun berhasil terdaftar',
            colorText: Theme.of(context).primaryColor,
            margin: const EdgeInsets.all(20),
          );

          province.clear();
          regency.clear();
          district.clear();
          village.clear();

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
