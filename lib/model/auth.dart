import '../constant.dart';

class Auth {
  // static final String baseUrl = API_URL;
  static final String baseUrl = 'http://localhost:5000/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String signup = 'auth/signup';
  final String signin = 'auth/signin';
}
