import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';
import '../model/conn.dart';

class Record extends GetxController {
  Future<Map<String, dynamic>> fetchRecordsByMeasurementId(id) async {
    var headers = {'Content-Type': 'application/json', 'x-api-key': API_KEY};
    try {
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.record}?measurementId=$id');
      print(url);
      http.Response response = await http.get(url, headers: headers);
      final jsonData = json.decode(response.body);

      // Mapping json menjadi Map
      Map<String, dynamic> result = (jsonData as Map<String, dynamic>);

      return result;
    } catch (e) {
      return {'error': e};
    }
  }
}
