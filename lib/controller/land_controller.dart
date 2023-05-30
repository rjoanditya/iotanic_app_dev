import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iotanic_app_dev/view/screen_monitoring/detail-lahan.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../constant.dart';
import '../model/conn.dart';
import '../model/user.dart';

class Land extends GetxController {
  // Inisiasi text editing controller untuk form menambahkan lahan
  TextEditingController name = TextEditingController();
  TextEditingController userId = TextEditingController();
  TextEditingController varietyId = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController addressId = TextEditingController();
  TextEditingController location = TextEditingController();

  User user = Get.put(User());

  /// Mendapatkan data lahan berdasarkan ID pengguna.
  ///
  /// Fungsi ini melakukan permintaan HTTP GET ke endpoint API untuk mendapatkan data lahan berdasarkan ID pengguna.
  /// ID pengguna diperoleh melalui metode `getUser('id')` dari objek `user`.
  ///
  /// Fungsi ini mengembalikan hasil dalam bentuk `Future<Map>`, yang berisi data lahan dalam bentuk `Map<String, dynamic>`.
  /// Jika terjadi kesalahan selama permintaan atau pemrosesan data, fungsi ini akan mengembalikan `Map` dengan kunci 'error'
  /// yang berisi pesan kesalahan.
  ///
  /// Perhatian: Fungsi ini mengharapkan terdapat objek `user` dengan metode `getUser('id')` dan konstanta `API_KEY` yang telah
  /// didefinisikan sebelumnya.
  ///
  /// Throws:
  ///   - Jika terjadi kesalahan selama permintaan HTTP atau pemrosesan data, fungsi ini akan melempar Exception.

  Future<Map> getLand() async {
    var user_id = await user.getUser('id');
    var headers = {'Content-Type': 'application/json', 'x-api-key': API_KEY};

    try {
      // expected to get http://localhost:5000/land/?user_id={user_id}
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.land}?user_id=$user_id');

      http.Response response = await http.get(url, headers: headers);

      final jsonData = json.decode(response.body);

      // Mapping json menjadi Map
      Map<String, dynamic> result = (jsonData as Map<String, dynamic>);

      return result;
    } catch (e) {
      return {'error': e};
    }
  }

  Future<void> getLandById(id) async {
    var headers = {'Content-Type': 'application/json', 'x-api-key': API_KEY};
    try {
      // expected to get http://localhost:5000/land/:id
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.land}/$id');
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        Map<String, dynamic> data = (json as Map<String, dynamic>);

        Get.to(DetailLahan(), arguments: data);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> createLand(BuildContext context) async {
    userId.text = await user.getUser('id');
    var headers = {'Content-Type': 'application/json', 'x-api-key': API_KEY};
    try {
      // expected to get http://localhost:5000/land/
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.land}');
      Map body = {
        "name": name.text,
        "user_id": userId.text,
        "variety_id": "0fe39abf-30",
        "area": area.text,
        "address_id": "33.72.01.1004",
        "location": {"lat": -7.711168, "lon": 110.935754}
      };
      var data = [name.text, userId.text, area.text];

      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        Get.snackbar(
          "Berhasil",
          'Lahan ${name.text} berhasil ditambahkan',
          colorText: Theme.of(context).primaryColor,
          margin: const EdgeInsets.all(20),
        );

        name.clear();
        userId.clear();
        area.clear();
        varietyId.clear();
        addressId.clear();
        location.clear();

        // Land result = Get.put(Land());
        getLandById(json['id']);
      }
    } catch (e) {
      print(e);
    }
  }
}
