import 'package:http/http.dart' as http;
import 'package:token_system/config/server_config.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/Entities/misc.dart';

class UserService {
  static String userUrl = "user";

  static registerApi(User user, String password) async {
    final response =
        await http.post(server + userUrl + "/create-user", body: user.registerToJson(password));
    return Misc.result(response, true);
  }

  static verifyApi(String email, String password) async {
    final response =
        await http.get(server + userUrl + "/verify-user?email=" + email + '&password=' + password);
    return Misc.result(response, false);
  }

  static updateProfileApi(User user,
      {String name, String mobileNumber, String aadhaarNumber, String pincode}) async {
    final response = await http.put(server + userUrl + "/update-user",
        body: user.updateToJson(
            name: name,
            mobileNumber: mobileNumber,
            aadhaarNumber: aadhaarNumber,
            pincode: pincode));
    return Misc.result(response, true);
  }

  static updatePasswordApi(int id, String oldPassword, String newPassword) async {
    final response = await http.put(server + userUrl + "/update-user-password",
        body: Misc.passwordToJson(id, oldPassword, newPassword));
    return Misc.result(response, true);
  }
}
