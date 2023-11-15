import 'dart:convert';

import 'package:distance_calculator/models/coordinates.dart';
import 'package:distance_calculator/models/result_model.dart';
import 'package:http/http.dart';

class ApiServices {
  static const String url = "distance-calculator8.p.rapidapi.com";
  static const String path = "/calc";

  static const Map<String, String> headers = {
    'X-RapidAPI-Key': 'c048093366msheb19647b0f2036ap10069cjsn0a5f6052cbac',
    'X-RapidAPI-Host': 'distance-calculator8.p.rapidapi.com'
  };

  static Future<Distance?> calculate(Coordinates coordinates) async {
    Distance? distance;

    Uri uri = Uri.https(url, path, coordinates.toMap());

    final response = await get(uri, headers: headers);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      distance = Distance.fromMap(json);
    }

    return distance;
  }
}
