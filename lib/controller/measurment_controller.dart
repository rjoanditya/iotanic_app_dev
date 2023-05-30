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

  Future<Map> getMeasurements(dynamic landId) async {
    var land_id = landId;
    var headers = {'Content-Type': 'application/json', 'x-api-key': API_KEY};
    try {
      // expected to get http://localhost:5000/land/?user_id={user_id}
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.measurement}?land_id=$land_id');
      http.Response response = await http.get(url, headers: headers);
      final jsonData = json.decode(response.body);

      // Mapping json menjadi Map
      Map<String, dynamic> result = (jsonData as Map<String, dynamic>);
      // print(result);
      return result;
    } catch (e) {
      return {'error': e};
    }
  }

  Future<void> getMeasurementById(id) async {
    var headers = {'Content-Type': 'application/json', 'x-api-key': API_KEY};
    try {
      // expected to get http://localhost:5000/land/:id
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.measurement}/$id');
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        Map<String, dynamic> data = (json as Map<String, dynamic>);

        print(data);
        Get.to(DetailMeasurements(), arguments: data);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> createMeasurement(BuildContext context, landId) async {
    var land_id = landId;
    userId.text = await user.getUser('id');
    var headers = {'Content-Type': 'application/json', 'x-api-key': API_KEY};
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

  Future<void> connectToDevice(var measurementId) async {
    deviceId.text = 'feacf04c-a4';
    var headers = {'Content-Type': 'application/json', 'x-api-key': API_KEY};
    try {
      // expected to patch http://localhost:5000/measurement/:id
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.measurement}/$measurementId');
      Map body = {
        'device_id': deviceId.text,
        'condition': 'scan',
      };
      http.Response response = await http.patch(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.measurement}/$measurementId');
        Map body = {
          'device_id': deviceId.text,
          'condition': 'start',
        };
        http.Response response = await http.patch(url, body: jsonEncode(body), headers: headers);

        getMeasurementById(measurementId);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> disconnectToDevice(var measurementId) async {
    // deviceId.text = 'feacf04c-a4';
    var headers = {'Content-Type': 'application/json', 'x-api-key': API_KEY};
    try {
      // expected to patch http://localhost:5000/measurement/:id
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.measurement}/$measurementId');
      Map body = {
        'device_id': deviceId.text,
        'condition': 'end',
      };
      http.Response response = await http.patch(url, body: jsonEncode(body), headers: headers);
    } catch (e) {
      print(e);
    }
  }
}
