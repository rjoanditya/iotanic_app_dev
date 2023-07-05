import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String TOKEN_KEY = 'token';

Future<String?> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(TOKEN_KEY);
}

Future<void> setToken(String token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(TOKEN_KEY, token);
}

Future<void> destroyToken() async {
  print('Token di hapus');
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(TOKEN_KEY);
}

bool isTokenExpired(String? token) {
  if (token == null) {
    return true;
  }
  try {
    final decodedToken = JwtDecoder.decode(token);
    final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    return decodedToken['exp'] < currentTime;
  } catch (error) {
    return true;
  }
}

Map<String, dynamic> decodeToken(String token) {
  return JwtDecoder.decode(token);
}
