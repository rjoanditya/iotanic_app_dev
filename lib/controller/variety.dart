import 'dart:convert';
import 'package:get/get.dart';

import '../constant.dart';
import '../model/conn.dart';
import '../model/variety.dart';
import 'package:http/http.dart' as http;

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
  static Future<List<Variety>> getVariety() async {
    // URL API static
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.variety}');
    http.Response response = await http.get(url, headers: headers);

    List<Variety> result = [];
    if (response.statusCode != 200) {
      return result;
    }

    List<dynamic> jsonData = json.decode(response.body)['data'];

    for (var data in jsonData) {
      result.add(Variety(id: data['id'], name: data['name']));
    }

    return result;
  }
}
