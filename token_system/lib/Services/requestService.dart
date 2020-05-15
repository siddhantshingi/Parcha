import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:token_system/config/server_config.dart';
import 'package:token_system/Entities/request.dart';

import '../Entities/request.dart';

class RequestService {
  static String requestUrl = "request";

  static registerRequestApiCall(Request request) async {
    print (requestUrl + "/create-request");
    print (request.toJson());
    final response = await http.post(server + requestUrl + "/create-request", body: request.toJson());
    print (response.body);
    var responseJson = json.decode(response.body);
    return responseJson['statusCode'];
  }
}