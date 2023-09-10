import 'package:http/http.dart' as http;

Future<String> getApi() async {
  // Uri url = Uri.parse("https://api.iotanic.id/api.json");
  // var response = await http.get(url);
  // String data = response.body;
  // String api = 'https://$data/';
  // String api = 'https://land-monitoring-api.vercel.app/';
  String api = 'https://synapsetech.store/';
  return api;
}

const API_KEY_WEATHER = '97b79a012a0c96b063f425bc40e3fa87';

var TOKEN = '';
var API_KEY = 'Bearer $TOKEN';

// token menggunakan akun iotanic
const TOKEN_IOTANIC_MAPBOX = 'sk.eyJ1IjoiaW90YW5pYyIsImEiOiJjbGtoeGtic3UwMHFiM3FuOXp3MXk2dzB1In0.ICTpvCdevnyJYOUokGvliA';
const PT_IOTANIC_MAPBOX = 'pk.eyJ1IjoiaW90YW5pYyIsImEiOiJjbGtoeGVkcmMwN2hjM3FvNjgybDNqeWtsIn0.PmIA8fJfvorth1g5uiiJMg';

const ENDPOINT_MAPBOX = 'https://api.mapbox.com/styles/v1/iotanic/clkhxntj3008y01phghj195t2/tiles/256/{z}/{x}/{y}@2x?access_token=$PT_IOTANIC_MAPBOX';

const GEOCODING_EP = "https://api.mapbox.com/geocoding/v5/mapbox.places/Los%20Angeles.json?access_token=$PT_IOTANIC_MAPBOX";
