import 'package:http/http.dart' as http;
import 'package:token_system/config/server_config.dart';
import 'package:token_system/Entities/token.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Entities/authority.dart';
import 'package:token_system/Entities/misc.dart';

class TokenService {
  static String tokenUrl = "token";

  static bookTokenApi(Token token) async {
    final response = await http.post(server + tokenUrl + "/book-token", body: token.bookToJson());
    return Misc.result(response, true);
  }

  static cancelTokenApi(int tokenId) async {
    final response = await http.put(server + tokenUrl + "/cancel-token", body: Token.cancelToJson(tokenId));
    return Misc.result(response, true);
  }

  static getTokenApi(User user) async {
    final response = await http.get(server + tokenUrl + "/get-token?" + "userId=" + user.id.toString());
    return Misc.result(response, false);
  }

  static verifyTokenApi({String email, String date, int slotNumber, Shop s, Authority a}) async {
    int _shopId = s?.id;
    final response = await http.put(server + tokenUrl + "/verify-token",
        body: Misc.verifyTokenToJson(email, date, slotNumber, shopId: _shopId));
    return Misc.result(response, true);
  }

  static getSignedTokenApiCall(int tokenId) async {
    final response = await http
        .get(server + tokenUrl + "/get-encrypted-token?tokenId=" + tokenId.toString());
    return Misc.result(response, false);
  }

}
