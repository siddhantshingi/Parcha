import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:token_system/config/server_config.dart';

class MiscService {
  static String shopTypeUrl = "shopType";

  static getShopTypesApiCall() async {
    final response = await http.get(server + shopTypeUrl + "/get-shop-type");
    var responseJson = json.decode(response.body);
    return responseJson;
  }
}