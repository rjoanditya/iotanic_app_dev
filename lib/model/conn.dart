import '../constant.dart';

class Conn {
  // static final String baseUrl = API_URL;

  // static String baseUrl = await getApi();
  static Routes endPoints = Routes();
}

class Routes {
  final String signup = 'auth/signup';
  final String signin = 'auth/signin';
  final String address = 'address';
  final String land = 'land';
  final String measurement = 'measurement';
  final String record = 'record';
  final String variety = 'variety';
}
