import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Entities/user.dart';

String server = 'http://8b1ef23b.ngrok.io/';

class UserService {
  static String userUrl = "user";

  static registerApiCall(User user) async {
    final response = await http.post(server + userUrl + "/create-user", body: user.toJson());
    print(response.body);
  }

  static verifyApiCall(String email) async {
    final response = await http.get(server + userUrl + "/get-user-by-email?email=" + email);
    return response;
  }
}