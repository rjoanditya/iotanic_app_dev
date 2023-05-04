import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/conn.dart';
import '../constant.dart';

class AddressController extends GetxController {
  // static List<Map> provinces = [
  //   {
  //     'id': '11',
  //     'name': 'ACEH',
  //   },
  //   {
  //     'id': '12',
  //     'name': 'SUMATERA UTARA',
  //   },
  // ];

// Method untuk mengambil provinsi dari API
  static Future<List<String>> getProvinces() async {
    // URL API static
    var headers = {'Content-Type': 'application/json', 'x-api-key': API_KEY};
    var url = Uri.parse('${Conn.baseUrl}${Conn.endPoints.address}?search=province');
    http.Response response = await http.get(url, headers: headers);
    List<String> result = [];

    // Parsing data dari JSON ke list of Map
    List<dynamic> jsonData = json.decode(response.body);
    jsonData.forEach((data) => result.add(data['name']));
    // List<Map<String, dynamic>> json = jsonDecode(response.body).cast<Map<String, dynamic>>();

    // Mapping data menjadi list of Map dengan hanya mengambil title dan id dari setiap data
    // List<Map<String, dynamic>> resultList = json
    //     .map((data) => {
    //           // 'id': data['id'],
    //           'name': data['name'],
    //         })
    //     .toList();

    return result;
  }

  // static Future getNameProvincesById(id) async {
  //   List<Map<String, dynamic>> data = await getProvinces();
  //   String name = '';
  //   for (int i = 0; i < data.length; i++) {
  //     if (data[i]['id'] == id) {
  //       name = data[i]['name'].toString();
  //       print(name);
  //       break;
  //     }
  //   }
  //   return name;
  // }

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
