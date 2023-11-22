// import 'dart:convert';
//
// import 'package:distance_calculator/models/coordinates.dart';
// import 'package:distance_calculator/models/result_model.dart';
// import 'package:http/http.dart';
//
// class ApiServices {
//   static const String url = "distance-calculator8.p.rapidapi.com";
//   static const String path = "/calc";
//
//   static const Map<String, String> headers = {
//     'X-RapidAPI-Key': 'c048093366msheb19647b0f2036ap10069cjsn0a5f6052cbac',
//     'X-RapidAPI-Host': 'distance-calculator8.p.rapidapi.com'
//   };
//
//   static Future<Distance?> calculate(Coordinates coordinates) async {
//     Distance? distance;
//
//     Uri uri = Uri.https(url, path, coordinates.toMap());
//
//     final response = await get(uri, headers: headers);
//
//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body);
//       distance = Distance.fromMap(json);
//     }
//
//     return distance;
//   }
// }

import 'dart:convert';
import 'dart:developer';

import 'package:distance_calculator/models/message_model.dart';
import 'package:http/http.dart';

class ApiServices {
  static const String base = "jsonplaceholder.typicode.com";
  static const String posts = "/posts";

  static String deletePost(int id) => "/posts/$id";

  static Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8',
  };

  static Future<MessageModel?> postMessage(MessageModel model) async {
    Uri uri = Uri.https(base, posts);
    final body = jsonEncode(model.toMap());
    final response = await post(uri, headers: headers, body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return MessageModel.fromMap(jsonDecode(response.body));
    }
    return null;
  }

  static Future<MessageModel?> putMessage(MessageModel model) async {
    Uri uri = Uri.https(base, posts);
    final body = jsonEncode(model.toMap());
    final response = await put(uri, headers: headers, body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return MessageModel.fromMap(jsonDecode(response.body));
    }
    return null;
  }



  static Future<List<MessageModel>> getAllMessages() async {
    List<MessageModel> messagesList = [];
    Uri uri = Uri.https(base, posts);
    final response = await get(uri);
    if (response.statusCode == 200) {
      final dataList = jsonDecode(response.body);

      for (final item in dataList) {
        try {
          messagesList.add(MessageModel.fromMap(item));
        } catch (error, st) {
          log("Error:", error: error, stackTrace: st);
        }
      }
    }

    return messagesList;
  }

  static Future<bool> deleteMessage(int id) async {
    Uri uri = Uri.https(base, deletePost(id));
    final response = await delete(uri);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
