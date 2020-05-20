import 'dart:convert';

class Misc {

  static Map<String, dynamic> passwordToJson(int id, String oldPassword, String newPassword) =>
      {
        "id": id.toString(),
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      };

  static result(var response, bool status) {
    var responseJson = json.decode(response.body);
    if (status)
      return responseJson['statusCode'];
    else
      return responseJson;
  }

  static Map<String, dynamic> verifyTokenToJson(String email, String date, int slotNumber, {int shopId}) {
    if (shopId != null)
      return {
        "userEmail": email,
        "date": date,
        "slotNumber": slotNumber.toString(),
        "shopId": shopId,
      };
    else
      return {
        "userEmail": email,
        "date": date,
        "slotNumber": slotNumber.toString(),
      };
  }

//  Map<int, String> shopTypesFromJson(Map<String, dynamic> json, int shopId) {
//    var map = {}
//  }

//  Map<int, int> capacitiesFromJson(Map<String, dynamic> json, int shopId) {
//    var map = {}
//  }

}