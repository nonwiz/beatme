import 'dart:convert';

import 'package:beatme/data/weather.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String authority = 'api.openweathermap.org';
  final String path = "data/2.5/weather";
  final String apiKey = "YOUR API Key here";

  Future<Weather> getWeather(String location) async {
    Map<String, dynamic> parameters = {'q': location, 'appId': apiKey};
    Uri uri = Uri.https(authority, path, parameters);
    http.Response result = await http.get(uri);
    Map<String, dynamic> data = json.decode(result.body);
    Weather weather = Weather.fromJson(data);
    return weather;
  }

}