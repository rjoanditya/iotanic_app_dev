import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/conn.dart';
import '../constant.dart';

class AddressController extends GetxController {
  // Method untuk mengambil provinsi dari API
  static Future<List<String>> getProvinces() async {
    // URL API static
    var headers = {'Content-Type': 'application/json', 'x-api-key': API_KEY};
    var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.address}?search=province');
    http.Response response = await http.get(url, headers: headers);
    List<String> result = [];

    // Parsing data dari JSON ke list of Map
    List<dynamic> jsonData = json.decode(response.body);
    for (var data in jsonData) {
      result.add(data['name']);
    }

    return result;
  }

  static Future<List> getDistricts(idProvinces) async {
    // URL API static
    var headers = {'Content-Type': 'application/json', 'x-api-key': API_KEY};
    List result = [];
    try {
      var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.address}?search=district?id=$idProvinces');
      http.Response response = await http.get(url, headers: headers);
      // Parsing data dari JSON ke list of Map
      // List result = [];
      List<dynamic> jsonData = json.decode(response.body);
      for (var data in jsonData) {
        result.add(data['name']);
        return result;
      }
    } catch (e) {
      print(e);
    }
    return result = ['error'];
  }

  static Future<String> getIdProvincesByName(name) async {
    // URL API static
    var headers = {'Content-Type': 'application/json', 'x-api-key': API_KEY};
    var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.address}?search=province');
    http.Response response = await http.get(url, headers: headers);
    List<String> result = [];
    List<Map<String, dynamic>> json = jsonDecode(response.body).cast<Map<String, dynamic>>();

    // Mapping data menjadi list of Map dengan hanya mengambil title dan id dari setiap data
    List<Map<String, dynamic>> data = json
        .map((data) => {
              'id': data['id'],
              'name': data['name'],
            })
        .toList();
    var id = '';

    for (int i = 0; i < data.length; i++) {
      if (data[i]['name'] == name) {
        id = data[i]['id'];
        break;
      }
    }

    return id;
  }
}
