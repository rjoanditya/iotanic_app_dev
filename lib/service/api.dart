import 'package:http/http.dart' as http;
import 'package:iotanic_app_dev/service/jwt.dart';

class ApiInterceptor extends http.BaseClient {
  final http.Client _inner;

  ApiInterceptor(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final token = await getToken();
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    return _inner.send(request);
  }
}

final api = ApiInterceptor(http.Client());
