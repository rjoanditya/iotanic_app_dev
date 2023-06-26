import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iotanic_app_dev/view/screen_monitoring/detail-lahan.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../constant.dart';
import '../../model/chartData.dart';
import '../model/conn.dart';
import '../model/user.dart';

class Land extends GetxController {
  // Inisiasi text editing controller untuk form menambahkan lahan
  TextEditingController name = TextEditingController();
  TextEditingController userId = TextEditingController();
  TextEditingController varietyId = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController province = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController regency = TextEditingController();
  TextEditingController village = TextEditingController();
  TextEditingController lat = TextEditingController();
  TextEditingController lon = TextEditingController();

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
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};

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

  /// Mengambil data lahan berdasarkan ID dari API.
  ///
  /// Method ini digunakan untuk mengambil data lahan berdasarkan ID yang diberikan
  /// dari API. Request dilakukan dengan menggunakan HTTP GET request ke URL
  /// endpoint yang disediakan. Setelah mendapatkan responsenya,
  /// data JSON akan diparsing dan kemudian ditampilkan pada halaman `DetailLahan`.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// await getLandById(id);
  /// ```
  ///
  /// Parameters:
  /// - `id` (String): ID lahan yang akan digunakan untuk mengambil data lahan.
  ///
  /// Throws:
  /// - `Exception`: Jika terjadi kesalahan saat mengambil data dari API.
  Future<void> getLandById(id) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
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

  /// Membuat data lahan baru dengan mengirimkan request ke API.
  ///
  /// Method ini digunakan untuk membuat data lahan baru dengan mengirimkan request
  /// HTTP POST ke URL endpoint yang disediakan oleh API. Data lahan yang akan dibuat
  /// seperti nama, ID pengguna, ID jenis tanaman, luas lahan, ID alamat, dan lokasi
  /// (latitude dan longitude) diambil dari input pengguna. Setelah berhasil membuat
  /// data lahan, halaman `DetailLahan` akan ditampilkan dengan menampilkan data lahan
  /// yang telah dibuat.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// await createLand(context);
  /// ```
  ///
  /// Parameters:
  /// - `context` (BuildContext): Konteks dari halaman saat ini.
  ///
  /// Throws:
  /// - `Exception`: Jika terjadi kesalahan saat membuat data lahan.
  Future<void> createLand(BuildContext context) async {
    userId.text = await user.getUser('id');
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      // expected to get http://localhost:5000/land/
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.land}');
      Map body = {
        "name": name.text,
        "user_id": userId.text,
        "variety_id": varietyId.text,
        "area": area.text,
        "address_id": village.text,
        "location": {"lat": lat.text, "lon": lon.text}
      };

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
        province.clear();
        regency.clear();
        district.clear();
        village.clear();
        lat.clear();
        lon.clear();

        // Land result = Get.put(Land());
        getLandById(json['id']);
      }
    } catch (e) {
      print(e);
    }
  }
// ========================================================================

  /// Menghitung rata-rata kondisi tanah berdasarkan ID pengukuran.
  ///
  /// Method ini digunakan untuk menghitung rata-rata kondisi tanah berdasarkan
  /// ID pengukuran yang diberikan. Kondisi tanah yang dihitung adalah kandungan
  /// nitrogen (N), fosfor (P), kalium (K), dan pH. Data pengukuran diperoleh
  /// dengan mengirimkan request HTTP GET ke URL endpoint yang disediakan oleh API
  /// dengan parameter ID pengukuran. Setelah mendapatkan data pengukuran, rata-rata
  /// kondisi tanah dihitung dengan menjumlahkan nilai kondisi dari setiap rekaman
  /// dan membaginya dengan jumlah total rekaman. Hasil rata-rata kondisi tanah
  /// kemudian dikembalikan dalam bentuk List.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// List<dynamic> averages = await calculateAverages(id);
  /// ```
  ///
  /// Parameters:
  /// - `id` (dynamic): ID pengukuran yang akan digunakan untuk menghitung rata-rata kondisi tanah.
  ///
  /// Returns:
  /// - List<dynamic>: List yang berisi rata-rata kondisi tanah dalam urutan nitrogen (N),
  ///   fosfor (P), kalium (K), dan pH. Jika terjadi kesalahan, List yang dikembalikan
  ///   akan kosong.
  Future<List<dynamic>> calculateAverages(id) async {
    List averages = [];
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    // Calculate averages
    double avgN = 0;
    double avgP = 0;
    double avgK = 0;
    double avgPH = 0;
    try {
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.record}?measurementId=$id');
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode != 200) {
        return averages;
      }

      // responsebody Map
      Map<String, dynamic> jsonRecords = (jsonDecode(response.body) as Map<String, dynamic>);

      // sumCondition
      double sumN = 0;
      double sumP = 0;
      double sumK = 0;
      double sumPH = 0;
      for (var record in jsonRecords['records']) {
        var condition = record['condition'];
        sumN += double.parse(condition['nitrogen'].toStringAsFixed(2));
        sumP += double.parse(condition['phosphorus'].toStringAsFixed(2));
        sumK += double.parse(condition['potassium'].toStringAsFixed(2));
        sumPH += double.parse(condition['ph'].toStringAsFixed(2));
      }

      int count = jsonRecords['count'];
      if (count != 0) {
        avgN = sumN / count;
        avgP = sumP / count;
        avgK = sumK / count;
        avgPH = sumPH / count;
      }

      // tampung dalam List averages;
      averages = [avgN, avgP, avgK, avgPH];
    } catch (e) {
      print(e);
    }
    return averages;
  }

  Future<double> nitrogenAverages(id) async {
    double result = 0;
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.record}?measurementId=$id');
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode != 200) {
        return result;
      }

      // responsebody Map
      Map<String, dynamic> jsonRecords = (jsonDecode(response.body) as Map<String, dynamic>);

      // sumCondition
      double sumN = 0;

      for (var record in jsonRecords['records']) {
        var condition = record['condition'];
        sumN += double.parse(condition['nitrogen'].toStringAsFixed(2));
      }

      int count = jsonRecords['count'];
      if (count != 0) {
        result = sumN / count;
      }
    } catch (e) {
      print(e);
    }

    return result;
  }

  Future<double> phosporusAverages(id) async {
    double result = 0;
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.record}?measurementId=$id');
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode != 200) {
        return result;
      }

      // responsebody Map
      Map<String, dynamic> jsonRecords = (jsonDecode(response.body) as Map<String, dynamic>);

      // sumCondition
      double sumP = 0;

      for (var record in jsonRecords['records']) {
        var condition = record['condition'];
        sumP += double.parse(condition['phosphorus'].toStringAsFixed(2));
      }

      int count = jsonRecords['count'];
      if (count != 0) {
        result = sumP / count;
      }
    } catch (e) {
      print(e);
    }

    return result;
  }

  Future<double> potassiumAverages(id) async {
    double result = 0;
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.record}?measurementId=$id');
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode != 200) {
        return result;
      }

      // responsebody Map
      Map<String, dynamic> jsonRecords = (jsonDecode(response.body) as Map<String, dynamic>);

      // sumCondition
      double sumK = 0;

      for (var record in jsonRecords['records']) {
        var condition = record['condition'];
        sumK += double.parse(condition['potassium'].toStringAsFixed(2));
      }

      int count = jsonRecords['count'];
      if (count != 0) {
        result = sumK / count;
      }
    } catch (e) {
      print(e);
    }

    return result;
  }

  Future<double> phAverages(id) async {
    double result = 0;
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.record}?measurementId=$id');
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode != 200) {
        return result;
      }

      // responsebody Map
      Map<String, dynamic> jsonRecords = (jsonDecode(response.body) as Map<String, dynamic>);

      // sumCondition
      double sumPH = 0;

      for (var record in jsonRecords['records']) {
        var condition = record['condition'];
        sumPH += double.parse(condition['ph'].toStringAsFixed(2));
      }

      int count = jsonRecords['count'];
      if (count != 0) {
        result = sumPH / count;
      }
    } catch (e) {
      print(e);
    }

    return result;
  }

// ========================================================================
  /// Mendapatkan data pengukuran berdasarkan ID lahan.
  ///
  /// Method ini digunakan untuk mendapatkan data pengukuran berdasarkan ID lahan
  /// yang diberikan. Data pengukuran diperoleh dengan mengirimkan request HTTP GET
  /// ke URL endpoint yang disediakan oleh API dengan parameter ID lahan. Setelah
  /// mendapatkan data pengukuran, rata-rata kondisi tanah dihitung menggunakan
  /// method `calculateAverages()` untuk setiap pengukuran yang ditemukan. Hasil
  /// data pengukuran yang telah dihitung rata-rata kondisi tanahnya kemudian
  /// dikembalikan dalam bentuk List.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// List<ChartData> records = await getRecordsByLandId(id);
  /// ```
  ///
  /// Parameters:
  /// - `id` (dynamic): ID lahan yang akan digunakan untuk mendapatkan data pengukuran.
  ///
  /// Returns:
  /// - List<ChartData>: List yang berisi data pengukuran beserta rata-rata kondisi
  ///   tanahnya dalam bentuk objek ChartData. Jika terjadi kesalahan, List yang dikembalikan
  ///   akan berisi satu objek ChartData dengan nilai default yaitu ID 1 dan rata-rata
  ///   kondisi tanah [0, 0, 0, 0].
  Future<List<ChartData>> getRecordsByLandId(id) async {
    // hasil yang diharapkan
    List<ChartData> result = [
      ChartData(1, [0, 0, 0, 0]),
    ];
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.measurement}?land_id=$id');
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode != 200) {
        return result;
      }

      Map<String, dynamic> jsonMeasurements = (jsonDecode(response.body) as Map<String, dynamic>);

      int i = 1;
      for (var data in jsonMeasurements['data']) {
        result.add(ChartData(i, await calculateAverages(data['id'])));
        i++;
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  /// Mendapatkan data kondisi nitrogen berdasarkan ID lahan dan ID jenis tanaman.
  ///
  /// Method ini digunakan untuk mendapatkan data kondisi nitrogen berdasarkan ID lahan
  /// dan ID jenis tanaman yang diberikan. Data kondisi nitrogen diperoleh dengan
  /// mengirimkan request HTTP GET ke URL endpoint yang disediakan oleh API dengan
  /// parameter ID lahan. Setelah mendapatkan data pengukuran, nilai kondisi nitrogen
  /// optimal dan rata-rata kondisi nitrogen untuk setiap pengukuran dihitung menggunakan
  /// method `optimalNitrogen()` dan `nitrogenAverages()`. Hasil data kondisi nitrogen
  /// yang telah dihitung kemudian dikembalikan dalam bentuk List.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// List<ChartData> nitrogenData = await getNitrogen(landId, varietyId);
  /// ```
  ///
  /// Parameters:
  /// - `landId` (dynamic): ID lahan yang akan digunakan untuk mendapatkan data kondisi nitrogen.
  /// - `varietyId` (dynamic): ID jenis tanaman yang akan digunakan untuk mendapatkan data kondisi nitrogen.
  ///
  /// Returns:
  /// - List<ChartData>: List yang berisi data kondisi nitrogen beserta rata-rata kondisi nitrogen
  ///   optimal dalam bentuk objek ChartData. Jika terjadi kesalahan, List yang dikembalikan
  ///   akan berisi satu objek ChartData dengan nilai default yaitu ID 1 dan nilai kondisi
  ///   nitrogen [0, 0].
  Future<List<ChartData>> getNitrogen(landId, varietyId) async {
    List<ChartData> result = [
      ChartData(1, [0, 0]),
    ];
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.measurement}?land_id=$landId');
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode != 200) {
        return result;
      }
      Map<String, dynamic> jsonMeasurements = (jsonDecode(response.body) as Map<String, dynamic>);

      int i = 1;
      for (var data in jsonMeasurements['data']) {
        result.add(ChartData(i, [await optimalNitrogen(varietyId), await nitrogenAverages(data['id'])]));
        i++;
        // result.add(ChartData(i++, averages(data['id'])));
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  /// Mendapatkan data kondisi fosforus berdasarkan ID lahan dan ID jenis tanaman.
  ///
  /// Method ini digunakan untuk mendapatkan data kondisi fosforus berdasarkan ID lahan
  /// dan ID jenis tanaman yang diberikan. Data kondisi fosforus diperoleh dengan
  /// mengirimkan request HTTP GET ke URL endpoint yang disediakan oleh API dengan
  /// parameter ID lahan. Setelah mendapatkan data pengukuran, nilai kondisi fosforus
  /// optimal dan rata-rata kondisi fosforus untuk setiap pengukuran dihitung menggunakan
  /// method `optimalPhosporus()` dan `phosporusAverages()`. Hasil data kondisi fosforus
  /// yang telah dihitung kemudian dikembalikan dalam bentuk List.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// List<ChartData> phosporusData = await getPhosporus(landId, varietyId);
  /// ```
  ///
  /// Parameters:
  /// - `landId` (dynamic): ID lahan yang akan digunakan untuk mendapatkan data kondisi fosforus.
  /// - `varietyId` (dynamic): ID jenis tanaman yang akan digunakan untuk mendapatkan data kondisi fosforus.
  ///
  /// Returns:
  /// - List<ChartData>: List yang berisi data kondisi fosforus beserta rata-rata kondisi fosforus
  ///   optimal dalam bentuk objek ChartData. Jika terjadi kesalahan, List yang dikembalikan
  ///   akan berisi satu objek ChartData dengan nilai default yaitu ID 1 dan nilai kondisi
  ///   fosforus [0, 0].
  ///
  Future<List<ChartData>> getPhosporus(landId, varietyId) async {
    List<ChartData> result = [
      ChartData(1, [0, 0]),
    ];
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.measurement}?land_id=$landId');
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode != 200) {
        return result;
      }
      Map<String, dynamic> jsonMeasurements = (jsonDecode(response.body) as Map<String, dynamic>);

      int i = 1;
      for (var data in jsonMeasurements['data']) {
        result.add(ChartData(i, [await optimalPhosporus(varietyId), await phosporusAverages(data['id'])]));
        i++;
        // result.add(ChartData(i++, averages(data['id'])));
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  /// Mendapatkan data kondisi kalium berdasarkan ID lahan dan ID jenis tanaman.
  ///
  /// Method ini digunakan untuk mendapatkan data kondisi kalium berdasarkan ID lahan
  /// dan ID jenis tanaman yang diberikan. Data kondisi kalium diperoleh dengan
  /// mengirimkan request HTTP GET ke URL endpoint yang disediakan oleh API dengan
  /// parameter ID lahan. Setelah mendapatkan data pengukuran, nilai kondisi kalium
  /// optimal dan rata-rata kondisi kalium untuk setiap pengukuran dihitung menggunakan
  /// method `optimalPotassium()` dan `potassiumAverages()`. Hasil data kondisi kalium
  /// yang telah dihitung kemudian dikembalikan dalam bentuk List.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// List<ChartData> potassiumData = await getPotassium(landId, varietyId);
  /// ```
  ///
  /// Parameters:
  /// - `landId` (dynamic): ID lahan yang akan digunakan untuk mendapatkan data kondisi kalium.
  /// - `varietyId` (dynamic): ID jenis tanaman yang akan digunakan untuk mendapatkan data kondisi kalium.
  ///
  /// Returns:
  /// - List<ChartData>: List yang berisi data kondisi kalium beserta rata-rata kondisi kalium
  ///   optimal dalam bentuk objek ChartData. Jika terjadi kesalahan, List yang dikembalikan
  ///   akan berisi satu objek ChartData dengan nilai default yaitu ID 1 dan nilai kondisi
  ///   kalium [0, 0].
  Future<List<ChartData>> getPotassium(landId, varietyId) async {
    List<ChartData> result = [
      ChartData(1, [0, 0]),
    ];
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.measurement}?land_id=$landId');
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode != 200) {
        return result;
      }
      Map<String, dynamic> jsonMeasurements = (jsonDecode(response.body) as Map<String, dynamic>);

      int i = 1;
      for (var data in jsonMeasurements['data']) {
        result.add(ChartData(i, [await optimalPotassium(varietyId), await potassiumAverages(data['id'])]));
        i++;
        // result.add(ChartData(i++, averages(data['id'])));
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  /// Mendapatkan data kondisi pH tanah berdasarkan ID lahan dan ID jenis tanaman.
  ///
  /// Method ini digunakan untuk mendapatkan data kondisi pH tanah berdasarkan ID lahan
  /// dan ID jenis tanaman yang diberikan. Data kondisi pH tanah diperoleh dengan
  /// mengirimkan request HTTP GET ke URL endpoint yang disediakan oleh API dengan
  /// parameter ID lahan. Setelah mendapatkan data pengukuran, nilai kondisi pH tanah
  /// optimal dan rata-rata kondisi pH tanah untuk setiap pengukuran dihitung menggunakan
  /// method `optimalPH()` dan `phAverages()`. Hasil data kondisi pH tanah yang telah
  /// dihitung kemudian dikembalikan dalam bentuk List.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// List<ChartData> phData = await getPH(landId, varietyId);
  /// ```
  ///
  /// Parameters:
  /// - `landId` (dynamic): ID lahan yang akan digunakan untuk mendapatkan data kondisi pH tanah.
  /// - `varietyId` (dynamic): ID jenis tanaman yang akan digunakan untuk mendapatkan data kondisi pH tanah.
  ///
  /// Returns:
  /// - List<ChartData>: List yang berisi data kondisi pH tanah beserta rata-rata kondisi pH tanah
  ///   optimal dalam bentuk objek ChartData. Jika terjadi kesalahan, List yang dikembalikan
  ///   akan berisi satu objek ChartData dengan nilai default yaitu ID 1 dan nilai kondisi
  ///   pH tanah [0, 0].
  Future<List<ChartData>> getPH(landId, varietyId) async {
    List<ChartData> result = [
      ChartData(1, [0, 0]),
    ];
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.measurement}?land_id=$landId');
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode != 200) {
        return result;
      }
      Map<String, dynamic> jsonMeasurements = (jsonDecode(response.body) as Map<String, dynamic>);

      int i = 1;
      for (var data in jsonMeasurements['data']) {
        result.add(ChartData(i, [await optimalPH(varietyId), await phAverages(data['id'])]));
        i++;
        // result.add(ChartData(i++, averages(data['id'])));
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  // ========================================================================
  /// Mendapatkan kondisi optimal nitrogen berdasarkan ID jenis tanaman.
  ///
  /// Method ini digunakan untuk mendapatkan kondisi optimal nitrogen berdasarkan
  /// ID jenis tanaman yang diberikan. Kondisi optimal nitrogen diperoleh dengan
  /// mengirimkan request HTTP GET ke URL endpoint yang disediakan oleh API dengan
  /// parameter ID jenis tanaman. Setelah mendapatkan kondisi optimal nitrogen,
  /// nilai tersebut dikembalikan.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// int optimalNitrogen = await optimalNitrogen(id);
  /// ```
  ///
  /// Parameters:
  /// - `id` (dynamic): ID jenis tanaman yang akan digunakan untuk mendapatkan kondisi optimal nitrogen.
  ///
  /// Returns:
  /// - int: Kondisi optimal nitrogen untuk jenis tanaman yang sesuai dengan ID yang diberikan.
  ///   Jika terjadi kesalahan, nilai yang dikembalikan akan berupa 0.
  Future<int> optimalNitrogen(id) async {
    int result = 0;
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.variety}/$id');
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode != 200) {
        return result;
      }

      // responsebody Map
      Map<String, dynamic> jsonVariety = (jsonDecode(response.body) as Map<String, dynamic>);

      result = jsonVariety['optimal_condition']['nitrogen'];
    } catch (e) {
      print(e);
    }

    return result;
  }

  /// Mendapatkan nilai kondisi optimal fosfor (phosphorus) berdasarkan ID jenis tanaman.
  ///
  /// Method ini digunakan untuk mendapatkan nilai kondisi optimal fosfor (phosphorus)
  /// berdasarkan ID jenis tanaman yang diberikan. Nilai kondisi optimal fosfor
  /// diperoleh dengan mengirimkan request HTTP GET ke URL endpoint yang disediakan
  /// oleh API dengan parameter ID jenis tanaman. Jika request berhasil dan
  /// mendapatkan respon dengan kode status 200, nilai kondisi optimal fosfor
  /// akan diambil dari respon tersebut. Jika terjadi kesalahan dalam mengirim
  /// request atau mendapatkan respon, nilai default 0 akan dikembalikan.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// int optimalPhosporus = await optimalPhosporus(id);
  /// ```
  ///
  /// Parameters:
  /// - `id` (dynamic): ID jenis tanaman yang akan digunakan untuk mendapatkan nilai kondisi optimal fosfor.
  ///
  /// Returns:
  /// - int: Nilai kondisi optimal fosfor (phosphorus) jika berhasil, atau nilai default 0 jika terjadi kesalahan.

  Future<int> optimalPhosporus(id) async {
    int result = 0;
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.variety}/$id');
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode != 200) {
        return result;
      }

      // responsebody Map
      Map<String, dynamic> jsonVariety = (jsonDecode(response.body) as Map<String, dynamic>);

      result = jsonVariety['optimal_condition']['phosphorus'];
    } catch (e) {
      print(e);
    }

    return result;
  }

  /// Mendapatkan nilai kondisi optimal kalium (potassium) berdasarkan ID jenis tanaman.
  ///
  /// Method ini digunakan untuk mendapatkan nilai kondisi optimal kalium (potassium)
  /// berdasarkan ID jenis tanaman yang diberikan. Nilai kondisi optimal kalium
  /// diperoleh dengan mengirimkan request HTTP GET ke URL endpoint yang disediakan
  /// oleh API dengan parameter ID jenis tanaman. Jika request berhasil dan
  /// mendapatkan respon dengan kode status 200, nilai kondisi optimal kalium
  /// akan diambil dari respon tersebut. Jika terjadi kesalahan dalam mengirim
  /// request atau mendapatkan respon, nilai default 0 akan dikembalikan.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// int optimalPotassium = await optimalPotassium(id);
  /// ```
  ///
  /// Parameters:
  /// - `id` (dynamic): ID jenis tanaman yang akan digunakan untuk mendapatkan nilai kondisi optimal kalium.
  ///
  /// Returns:
  /// - int: Nilai kondisi optimal kalium (potassium) jika berhasil, atau nilai default 0 jika terjadi kesalahan.

  Future<int> optimalPotassium(id) async {
    int result = 0;
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.variety}/$id');
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode != 200) {
        return result;
      }

      // responsebody Map
      Map<String, dynamic> jsonVariety = (jsonDecode(response.body) as Map<String, dynamic>);

      result = jsonVariety['optimal_condition']['potassium'];
    } catch (e) {
      print(e);
    }

    return result;
  }

  /// Mendapatkan nilai kondisi optimal pH berdasarkan ID jenis tanaman.
  ///
  /// Method ini digunakan untuk mendapatkan nilai kondisi optimal pH
  /// berdasarkan ID jenis tanaman yang diberikan. Nilai kondisi optimal pH
  /// diperoleh dengan mengirimkan request HTTP GET ke URL endpoint yang disediakan
  /// oleh API dengan parameter ID jenis tanaman. Jika request berhasil dan
  /// mendapatkan respon dengan kode status 200, nilai kondisi optimal pH
  /// akan diambil dari respon tersebut. Jika terjadi kesalahan dalam mengirim
  /// request atau mendapatkan respon, nilai default 0 akan dikembalikan.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// int optimalPH = await optimalPH(id);
  /// ```
  ///
  /// Parameters:
  /// - `id` (dynamic): ID jenis tanaman yang akan digunakan untuk mendapatkan nilai kondisi optimal pH.
  ///
  /// Returns:
  /// - int: Nilai kondisi optimal pH jika berhasil, atau nilai default 0 jika terjadi kesalahan.

  Future<int> optimalPH(id) async {
    int result = 0;
    var headers = {'Content-Type': 'application/json', 'Authorization': API_KEY};
    try {
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.variety}/$id');
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode != 200) {
        return result;
      }

      // responsebody Map
      Map<String, dynamic> jsonVariety = (jsonDecode(response.body) as Map<String, dynamic>);

      result = jsonVariety['optimal_condition']['ph'];
    } catch (e) {
      print(e);
    }

    return result;
  }
}
