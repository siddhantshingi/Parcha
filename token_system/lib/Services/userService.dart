import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:token_system/config/server_config.dart';
import 'package:token_system/Entities/user.dart';

class UserService {
  static String userUrl = "user";
  static String tokenUrl = "token";

  static registerApiCall(User user) async {
    final response =
        await http.post(server + userUrl + "/create-user", body: user.toJson());
    var responseJson = json.decode(response.body);
    return responseJson['statusCode'];
  }

  static verifyApiCall(String email) async {
    final response =
        await http.get(server + userUrl + "/get-user-by-email?email=" + email);
    final responseJson = json.decode(response.body);
    return responseJson;
  }

  static getTokensApiCall(User user) async {
    final response = await http
        .get(server + tokenUrl + "/get-token?userId=" + user.id.toString());
    final responseJson = json.decode(response.body);
    return responseJson;
  }
}
