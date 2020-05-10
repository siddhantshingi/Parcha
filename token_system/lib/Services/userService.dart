import 'package:http/http.dart' as http;
import '../Entities/user.dart';

class UserService {
  String userUrl = "";

  registerApiCall(User user) async {
    print("in api call function");
    final response = await http
        .post("http://e884fb15.ngrok.io/user/create-user", body: user.toJson());
    print(response.body);
  }

}