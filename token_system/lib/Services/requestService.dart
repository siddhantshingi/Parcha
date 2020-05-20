import 'package:http/http.dart' as http;
import 'package:token_system/config/server_config.dart';
import 'package:token_system/Entities/request.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Entities/authority.dart';
import 'package:token_system/Entities/misc.dart';

class RequestService {
  static String requestUrl = "request";

  static createRequestApi(Request request) async {
    final response = await http.post(server + requestUrl + "/book-token", body: request.createToJson());
    return Misc.result(response, true);
  }

  static resolveRequestApi(Request request, Authority auth, int accepted) async {
    final response = await http.put(server + requestUrl + "/resolve-request", body: request.resolveToJson(auth, accepted));
    return Misc.result(response, true);
  }

  static getPendingRequestApi(Authority auth) async {
    final response = await http.get(server + requestUrl + "/get-pending-requests?pincode=" + auth.pincode);
    return Misc.result(response, false);
  }

  static getShopRequestApi(Shop shop) async {
    final response = await http.get(server + requestUrl + "/get-requests-by-authId?shopId=" + shop.id.toString());
    return Misc.result(response, false);
  }

  static getAuthRequestApi(Authority auth) async {
    final response = await http.get(server + requestUrl + "/get-requests-by-authId?authId=" + auth.id.toString());
    return Misc.result(response, false);
  }


}