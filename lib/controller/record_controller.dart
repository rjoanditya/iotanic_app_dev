import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';
import '../model/conn.dart';
import '../view/screen_monitoring/detail-records.dart';

class Record extends GetxController {
  /// Mengambil catatan (records) berdasarkan ID data pengukuran.
  ///
  /// Fungsi ini digunakan untuk mengambil catatan (records) yang terkait dengan suatu
  /// data pengukuran berdasarkan ID data pengukuran yang diberikan. Permintaan dilakukan
  /// dengan mengirimkan permintaan HTTP GET ke URL endpoint yang ditentukan oleh API,
  /// dengan parameter ID data pengukuran (measurementId). Jika permintaan berhasil dan
  /// menerima respons dengan kode status 200, data catatan akan dikembalikan dalam bentuk
  /// Map<String, dynamic>. Jika terjadi kesalahan dalam mengirim permintaan atau menerima
  /// respons, pesan kesalahan akan dicetak di konsol, dan Map dengan kunci 'error' dan nilai
  /// e akan dikembalikan.
  ///
  /// Parameter:
  /// - `id` (var): ID data pengukuran yang akan digunakan untuk mengambil catatan terkait.
  ///
  /// Returns:
  /// - Future<Map<String, dynamic>>: Map yang berisi data catatan (records) jika permintaan berhasil,
  ///   atau Map dengan kunci 'error' dan pesan kesalahan jika terjadi kesalahan.

  Future<Map<String, dynamic>> fetchRecordsByMeasurementId(id) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.record}?measurementId=$id');
      http.Response response = await http.get(url, headers: headers);
      final jsonData = json.decode(response.body);

      // Mapping json menjadi Map
      Map<String, dynamic> result = (jsonData as Map<String, dynamic>);

      return result;
    } catch (e) {
      return {'error': e};
    }
  }

  /// Mengambil kondisi (condition) berdasarkan ID catatan (record).
  ///
  /// Fungsi ini digunakan untuk mengambil kondisi (condition) yang terkait dengan suatu
  /// catatan (record) berdasarkan ID catatan yang diberikan. Permintaan dilakukan dengan
  /// mengirimkan permintaan HTTP GET ke URL endpoint yang ditentukan oleh API, dengan
  /// parameter ID catatan (recordId). Jika permintaan berhasil dan menerima respons dengan
  /// kode status 200, data kondisi akan ditampilkan dalam halaman DetailRecords. Jika terjadi
  /// kesalahan dalam mengirim permintaan atau menerima respons, pesan kesalahan akan dicetak
  /// di konsol.
  ///
  /// Parameter:
  /// - `id` (var): ID catatan (record) yang akan digunakan untuk mengambil kondisi terkait.
  /// - `data` (dynamic): Data terkait yang akan dikirim sebagai argumen ke halaman DetailRecords.
  ///
  /// Returns:
  /// - Future: Tidak mengembalikan nilai (void).
  Future getConditionId(id, data) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      // expected to get http://localhost:5000/land/:id
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.record}/$id');
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        Map<String, dynamic> jsonRecords = (json as Map<String, dynamic>);

        Get.to(DetailRecords(), arguments: {'data': data, 'condition': jsonRecords});
      }
    } catch (e) {
      print(e);
    }
  }
}
