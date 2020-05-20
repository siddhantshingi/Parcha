import 'package:http/http.dart' as http;
import 'package:token_system/config/server_config.dart';
import 'package:token_system/Entities/authority.dart';
import 'package:token_system/Entities/misc.dart';

class AuthorityService {
  static String authUrl = "localAuth";

  static registerApi(Authority auth, String password) async {
    final response =
    await http.post(server + authUrl + "/create-localAuth", body: auth.registerToJson(password));
    return Misc.result(response, true);
  }

  static verifyApi(String email, String password) async {
    final response =
    await http.get(server + authUrl + "/verify-localAuth?email=" + email + '&password=' + password);
    return Misc.result(response, false);
  }

  static updateProfileApi(Authority auth,
      {String name, String mobileNumber, String aadhaarNumber, String pincode}) async {
    final response = await http.put(server + authUrl + "/update-localAuth",
        body: auth.updateToJson(
            name: name,
            mobileNumber: mobileNumber,
            aadhaarNumber: aadhaarNumber,
            pincode: pincode));
    return Misc.result(response, true);
  }

  static updatePasswordApi(int id, String oldPassword, String newPassword) async {
    final response = await http.put(server + authUrl + "/update-localAuth-password",
        body: Misc.passwordToJson(id, oldPassword, newPassword));
    return Misc.result(response, true);
  }
}