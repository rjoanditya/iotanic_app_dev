import 'dart:convert';
import 'package:get/get.dart';

import '../constant.dart';
import '../model/conn.dart';
import '../model/variety.dart';
import 'package:http/http.dart' as http;
import '../service/jwt.dart';
import '../service/api.dart';

class VarietyController extends GetxController {
  /// Mengambil daftar varietas tanaman dari API.
  ///
  /// Fungsi ini digunakan untuk mengambil daftar varietas tanaman dari API.
  /// Permintaan dilakukan dengan mengirimkan permintaan HTTP GET ke URL endpoint
  /// yang ditentukan oleh API. Jika permintaan berhasil dan menerima respons dengan
  /// kode status 200, daftar varietas tanaman akan dikembalikan dalam bentuk daftar
  /// objek Variety. Jika terjadi kesalahan dalam mengirim permintaan atau menerima
  /// respons, daftar kosong akan dikembalikan. Fungsi ini bersifat statis sehingga
  /// dapat dipanggil langsung melalui nama kelas.
  ///
  /// Returns:
  /// - Future<List<Variety>>: Daftar varietas tanaman dalam bentuk daftar objek Variety.
  static Future<List<Map<String, dynamic>>> getVariety() async {
    // URL API static
    String baseUrl = await getApi();
    var url = Uri.parse('$baseUrl${Conn.endPoints.variety}');
    http.Response response = await api.get(url);

    List<Map<String, dynamic>> result = [];
    if (response.statusCode != 200) {
      return result;
    }

    // Map<String, dynamic> jsonData = json.decode(response.body)['data'];
    Map<String, dynamic> jsonData = (jsonDecode(response.body));

    for (var data in jsonData['data']) {
      result.add(data);
    }

    return result;
  }
}
