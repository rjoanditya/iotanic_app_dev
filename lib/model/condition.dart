import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constant.dart';
import 'conn.dart';

class Conditions {
  final String nitrogen;
  final String phosphorus;
  final String potassium;
  final String ph;

  Conditions({required this.nitrogen, required this.phosphorus, required this.potassium, required this.ph});

  factory Conditions.fromJson(Map<String, dynamic> object) {
    return Conditions(
      nitrogen: object['nitrogen'] ?? '',
      phosphorus: object['phosphorus'] ?? '',
      potassium: object['potassium'] ?? '',
      ph: object['ph'] ?? '',
    );
  }

  /// Fetches a record from the API based on the provided `id` parameter.
  /// Returns a `Future` that resolves to a `Conditions` object.
  ///
  /// Parameters:
  /// - `id` (String): The identifier of the record to fetch.
  ///
  /// Return Type:
  /// - `Future<Conditions>`: A `Future` that resolves to a `Conditions` object.
  ///
  /// API URL:
  /// The API URL is constructed using the `baseUrl` and `endPoints` properties from the `Conn` class, along with the provided `id` parameter.
  ///
  /// Usage Example:
  /// ```dart
  /// // Fetching a record by id
  /// var recordId = "123";
  /// var conditions = await fetchRecord(recordId);
  ///
  /// // Accessing properties of the Conditions object
  /// print(conditions.property1);
  /// print(conditions.property2);
  /// // ...
  /// ```
  ///
  /// Note: The `Conditions` class must have a corresponding implementation with the necessary properties and methods to parse the JSON data received from the API response.
  ///
  static Future<Conditions> fetchRecord(String id) async {
    String baseUrl = await getApi();
    String apiURL = "$baseUrl${Conn.endPoints.record}/$id";

    var apiResult = await http.get(Uri.parse(apiURL));
    var jsonObject = json.decode(apiResult.body);
    var recordData = (jsonObject as Map<String, dynamic>);

    return Conditions.fromJson(recordData);
  }

  @override
  String toString() => 'Conditions($nitrogen,$phosphorus,$potassium,$ph)';
}

// class UninitializedRecord extends Record {}
