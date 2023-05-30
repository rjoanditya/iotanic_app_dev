import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constant.dart';
import 'conn.dart';

class Condition {
  final String nitrogen;
  final String phosphorus;
  final String potassium;
  final String ph;

  Condition({required this.nitrogen, required this.phosphorus, required this.potassium, required this.ph});

  factory Condition.fromJson(Map<String, dynamic> object) {
    return Condition(
      nitrogen: object['nitrogen'] ?? '',
      phosphorus: object['phosphorus'] ?? '',
      potassium: object['potassium'] ?? '',
      ph: object['ph'] ?? '',
    );
  }
  static Future<Condition> fetchRecord(String id) async {
    String apiURL = "http://34.101.57.46:8080/record/$id";

    var apiResult = await http.get(Uri.parse(apiURL));
    var jsonObject = json.decode(apiResult.body);
    var recordData = (jsonObject as Map<String, dynamic>);

    return Condition.fromJson(recordData);
  }

  @override
  String toString() => 'Condition($nitrogen,$phosphorus,$potassium,$ph)';
}

// class UninitializedRecord extends Record {}
