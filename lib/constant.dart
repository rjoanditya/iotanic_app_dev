import 'package:http/http.dart' as http;

Future<String> getApi() async {
  Uri url = Uri.parse("https://api.iotanic.id/api.json");
  var response = await http.get(url);
  String data = response.body;
  String api = 'https://$data/';
  return api;
}

const API_KEY_WEATHER = '97b79a012a0c96b063f425bc40e3fa87';
// const API_KEY =
//     'zuOoKBIoHzAEpQuH0uN3waw6yRXdpKTJl7Z24mqybtfUEyhw6O5ns5F7fS47ttQgHsSzrjkcrQxEopelU5UmuEH61wZvzllvBHUZpC7YHlq5v6z7BajG3kB47Qj5CHKu8xu6MH7uWMYR7D3zYNSJVDG4pdwN7OruVAAbNbU7Q4aT9KK3qLYAX7e8LtqIjXRj1lLLDqIfmhOQUGcwEQLb87hYXKKfqIYsGblnqQk2ISIcerTQYtjesbL7R9mnrSrF';
var TOKEN = '';
var API_KEY = 'Bearer $TOKEN';

//// token menggunakan akun rjoanditya
const TOKEN_MAPBOX = 'sk.eyJ1IjoicmpvYW5kaXR5YSIsImEiOiJjbGY4aHkwYWcxcHdvM3NvMWpvN2p1YTBwIn0._8_wr7_oKzSFPTFFk5vRVg';
const PUBLIC_TOKEN_MAPBOX = 'pk.eyJ1IjoicmpvYW5kaXR5YSIsImEiOiJjbGY4aHE4d2gxdnBiM3lwcTE3dmkzMmlrIn0.Jfp9n4kDcdWciwJojS-3zg';

//// token menggunakan akun iotanic
const TOKEN_IOTANIC_MAPBOX = 'sk.eyJ1IjoiaW90YW5pYyIsImEiOiJjbGlvNXZrMnUwNjIzM2Vxb3VuYjF4dWJ4In0.GJv49HAWP-FnvC_u52iVKw';
const PT_IOTANIC_MAPBOX = 'pk.eyJ1IjoiaW90YW5pYyIsImEiOiJjbGlvNXJ5anIwcXc1M2Z0aGEzazV6NGRrIn0._X0OIjCQVpBwpG3BKlX2ww';

// const API_URL = "https://6d54-36-68-9-5.ngrok-free.app/";

const ENDPOINT_MAPBOX = 'https://api.mapbox.com/styles/v1/rjoanditya/clf8jpb5a000u01rjbqkjww9z/tiles/256/{z}/{x}/{y}@2x?access_token=$TOKEN_MAPBOX';

const GEOCODING_EP = "https://api.mapbox.com/geocoding/v5/mapbox.places/Los%20Angeles.json?access_token=$TOKEN_MAPBOX";
