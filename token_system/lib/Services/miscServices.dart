import 'package:http/http.dart' as http;
import 'package:token_system/config/server_config.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Entities/misc.dart';

class MiscService {
  static String shopBookingUrl="shopBooking";
  static String shopTypeUrl = "shopType";
  static String capacitiesUrl="capacities";

  static getShopBookingsApi(Shop shop, {String date}) async {
    String _date = (date != null ? "&date=" + date : "");
    final response = await http.get(server + shopBookingUrl + "/get-pending-requests?shopId=" + shop.id.toString() + _date);
    Misc.result(response, false);
  }

  static getShopTypesApi({int id}) async {
    String _id = (id != null ? "?id=" + id.toString() : "");
    final response = await http.get(server + shopTypeUrl + "/get-pending-requests" + _id);
    Misc.result(response, false);
  }

  static getCapacitiesApi({int id}) async {
    String _id = (id != null ? "?id=" + id.toString() : "");
    final response = await http.get(server + capacitiesUrl + "/get-pending-requests" + _id);
    Misc.result(response, false);
  }

}