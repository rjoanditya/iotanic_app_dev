import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../service/jwt.dart';
import '../service/api.dart';
import '../model/address.dart';
import '../model/conn.dart';
import '../constant.dart';

class AddressController extends GetxController {
  /// Mengambil daftar provinsi dari API.
  ///
  /// Method ini digunakan untuk mengambil daftar provinsi dari API.
  /// Request dilakukan dengan menggunakan HTTP GET request ke URL
  /// endpoint yang disediakan. Setelah mendapatkan responsenya,
  /// data JSON akan diparsing menjadi list objek `Province` yang
  /// berisi informasi id dan nama provinsi.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// List<Province> provinces = await getProvinces();
  /// ```
  ///
  /// Returns:
  /// - `List<Province>`: Daftar provinsi yang berhasil diambil dari API.
  ///
  /// Throws:
  /// - `Exception`: Jika terjadi kesalahan saat mengambil data dari API.
  static Future<List<Province>> getProvinces() async {
    // URL API static
    String baseUrl = await getApi();
    var url = Uri.parse('$baseUrl${Conn.endPoints.address}?search=province');
    http.Response response = await api.get(url);
    List<Province> result = [];

    // Parsing data dari JSON ke list of Map
    List<dynamic> jsonData = json.decode(response.body);
    for (var data in jsonData) {
      result.add(Province(id: data['id'], name: data['name']));
    }
    return result;
  }

  /// Mengambil daftar kabupaten berdasarkan ID provinsi dari API.
  ///
  /// Method ini digunakan untuk mengambil daftar kabupaten berdasarkan ID provinsi
  /// dari API. Request dilakukan dengan menggunakan HTTP GET request ke URL
  /// endpoint yang disediakan. Setelah mendapatkan responsenya,
  /// data JSON akan diparsing menjadi list objek `Regency` yang
  /// berisi informasi id dan nama kabupaten.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// List<Regency> regencies = await getRegencies(idProvince);
  /// ```
  ///
  /// Parameters:
  /// - `idProvince` (String): ID provinsi yang akan digunakan untuk mengambil daftar kabupaten.
  ///
  /// Returns:
  /// - `List<Regency>`: Daftar kabupaten yang berhasil diambil dari API.
  ///
  /// Throws:
  /// - `Exception`: Jika terjadi kesalahan saat mengambil data dari API.
  static Future<List<Regency>> getRegencies(idProvince) async {
    // URL API static
    // var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    String baseUrl = await getApi();
    var url = Uri.parse('$baseUrl${Conn.endPoints.address}?search=regency&id=$idProvince');
    print('kabupaten : $url');
    http.Response response = await api.get(url);
    List<Regency> result = [];
    if (response.statusCode != 200) {
      return result;
    }
    List<dynamic> jsonData = json.decode(response.body);

    for (var data in jsonData) {
      result.add(Regency(id: data['id'], name: data['name']));
    }
    return result;
  }

  /// Mengambil daftar kecamatan berdasarkan ID kabupaten dari API.
  ///
  /// Method ini digunakan untuk mengambil daftar kecamatan berdasarkan ID kabupaten
  /// dari API. Request dilakukan dengan menggunakan HTTP GET request ke URL
  /// endpoint yang disediakan. Setelah mendapatkan responsenya,
  /// data JSON akan diparsing menjadi list objek `District` yang
  /// berisi informasi id dan nama kecamatan.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// List<District> districts = await getDistricts(idRegency);
  /// ```
  ///
  /// Parameters:
  /// - `idRegency` (String): ID kabupaten yang akan digunakan untuk mengambil daftar kecamatan.
  ///
  /// Returns:
  /// - `List<District>`: Daftar kecamatan yang berhasil diambil dari API.
  ///
  /// Throws:
  /// - `Exception`: Jika terjadi kesalahan saat mengambil data dari API.
  static Future<List<District>> getDistricts(idRegency) async {
    // URL API static
    String baseUrl = await getApi();
    var url = Uri.parse('$baseUrl${Conn.endPoints.address}?search=district&id=$idRegency');
    http.Response response = await api.get(url);
    List<District> result = [];
    if (response.statusCode != 200) {
      return result;
    }
    List<dynamic> jsonData = json.decode(response.body);

    for (var data in jsonData) {
      result.add(District(id: data['id'], name: data['name']));
    }

    return result;
  }

  /// Mengambil daftar desa berdasarkan ID kecamatan dari API.
  ///
  /// Method ini digunakan untuk mengambil daftar desa berdasarkan ID kecamatan
  /// dari API. Request dilakukan dengan menggunakan HTTP GET request ke URL
  /// endpoint yang disediakan. Setelah mendapatkan responsenya,
  /// data JSON akan diparsing menjadi list objek `Village` yang
  /// berisi informasi id dan nama desa.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// List<Village> villages = await getVillages(idDistrict);
  /// ```
  ///
  /// Parameters:
  /// - `idDistrict` (String): ID kecamatan yang akan digunakan untuk mengambil daftar desa.
  ///
  /// Returns:
  /// - `List<Village>`: Daftar desa yang berhasil diambil dari API.
  ///
  /// Throws:
  /// - `Exception`: Jika terjadi kesalahan saat mengambil data dari API.
  static Future<List<Village>> getVillages(idDistrict) async {
    // URL API static
    String baseUrl = await getApi();
    var url = Uri.parse('$baseUrl${Conn.endPoints.address}?search=village&id=$idDistrict');
    http.Response response = await api.get(url);
    List<Village> result = [];
    if (response.statusCode != 200) {
      return result;
    }
    List<dynamic> jsonData = json.decode(response.body);

    for (var data in jsonData) {
      result.add(Village(id: data['id'], name: data['name']));
    }

    return result;
  }
}
