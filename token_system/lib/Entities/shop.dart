class Shop {
  int id;
  String email;
  String contact;
  String name;
  int shopType;
  String address;
  String landmark;
  String password;
  String state;
  String district;
  String pincode;
  int status;
  int shopSize;
  String closeTime;
  String openTime;

  // Ctor : For checking only
  Shop.forUser({
    this.id,
    this.name,
    this.openTime,
    this.closeTime,
    this.address,
    this.landmark,
    this.contact,
    this.pincode,
  });

  Shop({
    this.id,
    this.email,
    this.contact,
    this.name,
    this.shopType,
    this.address,
    this.landmark,
    this.password,
    this.state,
    this.district,
    this.pincode,
    this.status,
    this.shopSize,
    this.closeTime,
    this.openTime,
  });
}
