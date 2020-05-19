import 'package:http/http.dart' as http;
import 'package:token_system/config/server_config.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/Entities/authority.dart';
import 'package:token_system/Entities/misc.dart';

class ShopService {
  static String shopUrl = "shop";

  static registerApi(Shop shop, String password, int shopTypeId) async {
    final response = await http.post(
        server + shopUrl + "/create-shop", body: shop.registerToJson(password, shopTypeId));
    Misc.result(response, true);
  }

  static verifyApi(String email, String password) async {
    final response = await http.get(
        server + shopUrl + "/get-shop?email=" + email + '&' + 'password=' + password);
    Misc.result(response, false);
  }

  static getShopUserApi(User user, {int id, String name, String shopType, int capacity}) async {
    String _id = (id != null ? "&id=" + id.toString() : "");
    String _name = (name != null ? "&name=" + name : "");
    String _shopType = (shopType != null ? "&shopType=" + shopType : "");
    String _capacity = (capacity != null ? "&capacity=" + capacity.toString() : "");
    final response = await http.get(
        server + shopUrl + "/get-shop-for-user?pincode=" + user.pincode + _id + _name + _shopType +
            _capacity);
    Misc.result(response, false);
  }

  static getShopAuthApi(Authority auth, {int id, String name, String shopType, int capacity}) async {
    String _id = (id != null ? "&id=" + id.toString() : "");
    String _name = (name != null ? "&name=" + name : "");
    String _shopType = (shopType != null ? "&shopType=" + shopType : "");
    String _capacity = (capacity != null ? "&capacity=" + capacity.toString() : "");
    final response = await http.get(
        server + shopUrl + "/get-shop-for-auth?pincode=" + auth.pincode + _id + _name + _shopType +
            _capacity);
    Misc.result(response, false);
  }

  static updateProfileApi(Shop shop,
      { String shopName,
        String ownerName,
        String mobileNumber,
        String aadhaarNumber,
        String address,
        String landmark,
        int shopTypeId,
        String shopType,
        String currOpeningTime,
        String currClosingTime,
        String pincode}) async {
    final response = await http.put(server + shopUrl + "/update-shop", body: shop.updateToJson(
        shopName: shopName,
        ownerName: ownerName,
        mobileNumber: mobileNumber,
        aadhaarNumber: aadhaarNumber,
        address: address,
        landmark: landmark,
        shopTypeId: shopTypeId,
        shopType: shopType,
        currOpeningTime: currOpeningTime,
        currClosingTime: currClosingTime,
        pincode: pincode));
    Misc.result(response, true);
  }

  static updatePasswordApi(int id, String oldPassword, String newPassword) async {
    final response = await http.put(server + shopUrl + "/update-shop-password",
        body: Misc.passwordToJson(id, oldPassword, newPassword));
    Misc.result(response, true);
  }

  static getPublicKey() async {
    final response = await http.get(server + shopUrl + "/get-public-key");
    Misc.result(response, false);
  }
}