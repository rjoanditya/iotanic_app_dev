import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iotanic_app_dev/view/screen_monitoring/detail-measurements.dart';

import '../constant.dart';
import '../model/conn.dart';
import '../model/user.dart';
import 'land_controller.dart';

class Measurement extends GetxController {
  User user = Get.put(User());
  Land land = Get.put(Land());

  TextEditingController userId = TextEditingController();
  TextEditingController deviceId = TextEditingController();

  /// Mendapatkan data pengukuran berdasarkan ID lahan.
  ///
  /// Method ini digunakan untuk mendapatkan data pengukuran berdasarkan ID lahan yang
  /// diberikan. Data pengukuran diperoleh dengan mengirimkan request HTTP GET ke URL
  /// endpoint yang disediakan oleh API dengan parameter ID lahan. Jika request berhasil
  /// dan mendapatkan respon dengan kode status 200, data pengukuran akan diambil dari
  /// respon tersebut. Jika terjadi kesalahan dalam mengirim request atau mendapatkan respon,
  /// sebuah Map dengan key 'error' akan dikembalikan.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// Map measurementData = await getMeasurements(landId);
  /// ```
  ///
  /// Parameters:
  /// - `landId` (dynamic): ID lahan yang akan digunakan untuk mendapatkan data pengukuran.
  ///
  /// Returns:
  /// - Map: Data pengukuran jika berhasil, atau Map dengan key 'error' jika terjadi kesalahan.

  Future<Map> getMeasurements(dynamic landId) async {
    var land_id = landId;
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      // expected to get http://localhost:5000/land/?user_id={user_id}
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.measurement}?land_id=$land_id');
      http.Response response = await http.get(url, headers: headers);
      final jsonData = json.decode(response.body);

      // Mapping json menjadi Map
      Map<String, dynamic> result = (jsonData as Map<String, dynamic>);
      return result;
    } catch (e) {
      return {'error': e};
    }
  }

  /// Mengambil data pengukuran berdasarkan ID.
  ///
  /// Method ini digunakan untuk mengambil data pengukuran berdasarkan ID yang diberikan.
  /// Data pengukuran diperoleh dengan mengirimkan request HTTP GET ke URL endpoint yang
  /// disediakan oleh API dengan parameter ID. Jika request berhasil dan mendapatkan respon
  /// dengan kode status 200, data pengukuran akan diambil dari respon tersebut dan
  /// ditampilkan pada halaman DetailMeasurements. Jika terjadi kesalahan dalam mengirim
  /// request atau mendapatkan respon, pesan kesalahan akan dicetak di konsol.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// await getMeasurementById(id);
  /// ```
  ///
  /// Parameters:
  /// - `id` (dynamic): ID data pengukuran yang akan diambil.
  ///
  /// Returns:
  /// - Future<void>: Tidak ada nilai yang dikembalikan.
  Future<void> getMeasurementById(id) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      // expected to get http://localhost:5000/land/:id
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.measurement}/$id');
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        Map<String, dynamic> data = (json as Map<String, dynamic>);

        Get.to(DetailMeasurements(), arguments: data);
      }
    } catch (e) {
      print(e);
    }
  }

  /// Membuat data pengukuran baru.
  ///
  /// Method ini digunakan untuk membuat data pengukuran baru. Data pengukuran baru
  /// diperoleh dengan mengirimkan request HTTP POST ke URL endpoint yang disediakan
  /// oleh API. Request akan mengirimkan data berupa ID pengguna (user_id) dan ID lahan
  /// (land_id). Jika request berhasil dan mendapatkan respon dengan kode status 201,
  /// notifikasi 'Pengukuran berhasil ditambahkan' akan ditampilkan menggunakan Get.snackbar(),
  /// input field untuk user_id akan dikosongkan, dan halaman DetailMeasurements akan
  /// ditampilkan dengan data pengukuran yang baru dibuat. Jika terjadi kesalahan dalam
  /// mengirim request atau mendapatkan respon, pesan kesalahan akan dicetak di konsol.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// await createMeasurement(context, landId);
  /// ```
  ///
  /// Parameters:
  /// - `context` (BuildContext): Konteks dari widget yang memanggil method ini.
  /// - `landId` (dynamic): ID lahan yang akan digunakan untuk membuat data pengukuran.
  ///
  /// Returns:
  /// - Future<void>: Tidak ada nilai yang dikembalikan.
  Future<void> createMeasurement(BuildContext context, landId) async {
    var land_id = landId;
    userId.text = await user.getUser('id');
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      // expected to post http://localhost:5000/measurement/
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.measurement}');
      Map body = {
        'user_id': userId.text,
        'land_id': land_id,
      };
      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        Get.snackbar(
          "Berhasil",
          'Pengukuran berhasil ditambahkan',
          colorText: Theme.of(context).primaryColor,
          margin: const EdgeInsets.all(20),
        );

        userId.clear();

        // Land result = Get.put(Land());
        getMeasurementById(json['id']);
      }
    } catch (e) {
      print(e);
    }
  }

  /// Menghubungkan perangkat dengan data pengukuran.
  ///
  /// Fungsi ini digunakan untuk menghubungkan perangkat dengan data pengukuran yang
  /// spesifik. Perangkat dan data pengukuran dihubungkan dengan mengirimkan permintaan HTTP
  /// PATCH ke URL endpoint yang ditentukan oleh API, dengan parameter ID data pengukuran.
  /// Permintaan ini akan mengirimkan data berupa ID perangkat (device_id) dan kondisi
  /// (condition). Jika permintaan berhasil dan menerima respons dengan kode status 200,
  /// notifikasi 'Berhasil Menautkan' dengan pesan 'Perangkat berhasil tertaut' akan
  /// ditampilkan menggunakan Get.snackbar(). Jika terjadi kesalahan dalam mengirim permintaan
  /// atau menerima respons dengan kode status selain 200, notifikasi 'Gagal Menautkan' dengan
  /// pesan 'Device telah tertaut dengan measurement lain' akan ditampilkan menggunakan
  /// Get.snackbar(). Selanjutnya, halaman DetailMeasurements akan ditampilkan dengan data
  /// pengukuran yang telah diperbarui. Jika terjadi kesalahan dalam mengirim permintaan atau
  /// menerima respons, pesan kesalahan akan dicetak di konsol.
  ///
  /// Parameter:
  /// - `measurementId` (var): ID data pengukuran yang akan dihubungkan dengan perangkat.
  ///
  /// Returns:
  /// - Future<void>: Tidak ada nilai yang dikembalikan.
  Future<void> connectToDevice(var measurementId) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      // expected to patch http://localhost:5000/measurement/:id
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.measurement}/$measurementId');
      Map body = {
        'device_id': deviceId.text,
        'condition': 'start',
      };
      http.Response response = await http.patch(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        Get.snackbar('Berhasil Menautkan', 'Perangkat berhasil tertaut');
      } else {
        Get.snackbar('Gagal Menautkan', 'Device telah tertaut dengan measurement lain');
      }
      getMeasurementById(measurementId);
    } catch (e) {
      print(e);
    }
  }

  /// Memutuskan hubungan perangkat dari data pengukuran.
  ///
  /// Fungsi ini digunakan untuk memutuskan hubungan antara perangkat dengan data pengukuran
  /// yang sedang berjalan. Perangkat dan data pengukuran dihubungkan dengan mengirimkan
  /// permintaan HTTP PATCH ke URL endpoint yang ditentukan oleh API, dengan parameter ID
  /// data pengukuran. Permintaan ini akan mengirimkan data berupa ID perangkat (device_id)
  /// dan kondisi (condition) yang disetel ke 'end'. Jika terjadi kesalahan dalam mengirim
  /// permintaan atau menerima respons, pesan kesalahan akan dicetak di konsol.
  ///
  /// Parameter:
  /// - `measurementId` (var): ID data pengukuran yang akan diputuskan hubungannya dengan perangkat.
  /// - `deviceId` (String): ID perangkat yang akan diputuskan hubungannya dengan data pengukuran.
  ///
  /// Returns:
  /// - Future<void>: Tidak ada nilai yang dikembalikan.

  Future<void> disconnectToDevice(var measurementId, deviceId) async {
    // deviceId.text = 'feacf04c-a4';
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      // expected to patch http://localhost:5000/measurement/:id
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.measurement}/$measurementId');
      Map body = {
        'device_id': deviceId,
        'condition': 'end',
      };
      http.Response response = await http.patch(url, body: jsonEncode(body), headers: headers);
    } catch (e) {
      print(e);
    }
  }
}
