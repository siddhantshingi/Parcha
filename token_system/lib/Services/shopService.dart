import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:token_system/config/server_config.dart';
import 'package:token_system/Entities/shop.dart';

class ShopService {
  static String shopUrl = "shop";

  static registerApiCall(Shop shop) async {
    final response = await http.post(server + shopUrl + "/create-shop", body: shop.toJson());
    var responseJson = json.decode(response.body);
    return responseJson['statusCode'];
  }

  static verifyApiCall(String email) async {
    final response = await http.get(server + shopUrl + "/get-shop?email=" + email);
    final responseJson = json.decode(response.body);
    return responseJson;
  }
}