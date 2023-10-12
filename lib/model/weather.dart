// import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:iotanic_app_dev/constant.dart';
// import 'package:iotanic_app_dev/view/screen_monitoring/forecast.dart';

/// Fetches weather data from the OpenWeatherMap API based on the provided latitude and longitude coordinates.
/// Returns a `Future` that resolves to a `Map` containing the weather data.
///
/// Parameters:
/// - `lat` (double): The latitude coordinate.
/// - `lon` (double): The longitude coordinate.
///
/// Return Type:
/// - `Future<Map<String, dynamic>>`: A `Future` that resolves to a `Map` containing the weather data.
///
/// Usage Example:
/// ```dart
/// // Fetching weather data
/// double latitude = 40.7128; // Example latitude value
/// double longitude = -74.0060; // Example longitude value
/// var weatherData = await fetchWeather(latitude, longitude);
Future<Map<String, dynamic>> fetchWeather(lat, lon) async {
  const apiKey = API_KEY_WEATHER;
  final url = 'https://api.openweathermap.org/data/2.5/weather?lon=$lon&lat=$lat&units=metric&appid=$apiKey&lang=id';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response, throw an error.
    throw Exception('Failed to load weather data');
  }
}

/// Fetches forecast weather data from the OpenWeatherMap API based on the provided latitude and longitude coordinates.
/// Returns a `Future` that resolves to a `Map` containing the forecast weather data.
///
/// Parameters:
/// - `lon` (double): The longitude coordinate.
/// - `lat` (double): The latitude coordinate.
///
/// Return Type:
/// - `Future<Map<String, dynamic>>`: A `Future` that resolves to a `Map` containing the forecast weather data.
///
/// Usage Example:
/// ```dart
/// // Fetching forecast weather data
/// double longitude = -74.0060; // Example longitude value
/// double latitude = 40.7128; // Example latitude value
/// var forecastData = await fetchForecast(longitude, latitude);
Future<Map<String, dynamic>> fetchForecast(lon, lat) async {
  const apiKey = API_KEY_WEATHER;
  final url = 'https://api.openweathermap.org/data/2.5/forecast?lon=$lon&lat=$lat&cnt=40&units=metric&appid=$apiKey&lang=id';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response, throw an error.
    throw Exception('Failed to load weather data');
  }
}
