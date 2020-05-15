import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:token_system/config/server_config.dart';
import 'package:token_system/Entities/authority.dart';

class AuthorityService {
  static String authUrl = "localAuth";

  static registerApiCall(Authority auth) async {
    final response = await http.post(server + authUrl + "/create-localAuth", body: auth.toJson());
    var responseJson = json.decode(response.body);
    return responseJson['statusCode'];
  }

  static verifyApiCall(String email) async {
    final response = await http.get(server + authUrl + "/get-localAuth?email=" + email);
    final responseJson = json.decode(response.body);
    return responseJson;
  }
}