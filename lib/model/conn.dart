import '../constant.dart';

class Conn {
  // static final String baseUrl = API_URL;
  static final String baseUrl = 'http://localhost:5000/';
  static Routes endPoints = Routes();
}

class Routes {
  final String signup = 'auth/signup';
  final String signin = 'auth/signin';
  final String address = 'address';
  final String land = 'land';
}
