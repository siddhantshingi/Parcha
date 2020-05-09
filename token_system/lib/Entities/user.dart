
class User {

  int _id;
  String _name = "";
  String _email = "";
  String _contactNumber = "";
  String _password = "";
  String _aadharNumber = "";
  String _state = "";
  String _district = "";
  String _pincode = "";
  int _verificationStatus = 0;

  User();

  int get verificationStatus => _verificationStatus;

  set verificationStatus(int value) {
    _verificationStatus = value;
  }

  String get pincode => _pincode;

  set pincode(String value) {
    _pincode = value;
  }

  String get district => _district;

  set district(String value) {
    _district = value;
  }

  String get state => _state;

  set state(String value) {
    _state = value;
  }

  String get aadharNumber => _aadharNumber;

  set aadharNumber(String value) {
    _aadharNumber = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get contactNumber => _contactNumber;

  set contactNumber(String value) {
    _contactNumber = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toJson() =>
  {
    "id": _id.toString(),
    "name": _name,
    "email": _email,
    "contactNumber": _contactNumber,
    "password": _password,
    "aadharNumber": _aadharNumber,
    "state": _state,
    "district": _district,
    "pincode": _pincode,
    "verificationStatus": _verificationStatus.toString()
  };
}