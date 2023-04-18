import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:iotanic_app_dev/constant.dart';

Future<Map<String, dynamic>> fetchWeather(lon, lat) async {
  const apiKey = API_KEY_WEATHER;
  final url = 'https://api.openweathermap.org/data/2.5/weather?lon=$lon&lat=$lat&units=metric&appid=$apiKey';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response, throw an error.
    throw Exception('Failed to load weather data');
  }
}

Future<Map<String, dynamic>> fetchForecast(lon, lat) async {
  const apiKey = API_KEY_WEATHER;
  final url = 'https://api.openweathermap.org/data/2.5/forecast?lon=$lon&lat=$lat&cnt=7&units=metric&appid=$apiKey';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response, throw an error.
    throw Exception('Failed to load weather data');
  }
}

// Map mapResponse = {};
Future<Map<String, dynamic>> getLand() async {
  // const apiKey = API_KEY_WEATHER;
  final url = 'http://localhost:5000/land';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, parse the JSON.
    // print(response.body);
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response, throw an error.
    throw Exception('Failed to load weather data');
  }
}
