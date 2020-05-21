class Token {
  int id;
  int shopId;
  String shopName;
  int userId;
  String userName;
  String userEmail;
  String date;
  int slotNumber;
  String createdAt;
  int status;
  int verified;

  Token(
      {this.id,
      this.shopId,
      this.shopName,
      this.userId,
      this.userName,
      this.userEmail,
      this.date,
      this.slotNumber,
      this.createdAt,
      this.status,
      this.verified});

  Map<String, dynamic> bookToJson() => {
        "shopId": this.shopId.toString(),
        "shopName": this.shopName,
        "userId": this.userId.toString(),
        "userName": this.userName,
        "userEmail": this.userEmail,
        "date": this.date,
        "slotNumber": this.slotNumber.toString(),
      };

  static Map<String, dynamic> cancelToJson(id) => {"id": id.toString()};

  factory Token.getFromJson(Map<String, dynamic> json) {
    return Token(
        id: json['id'] as int,
        shopId: json['shopId'] as int,
        shopName: json['shopName'] as String,
        date: json['date'] as String,
        slotNumber: json['slotNumber'] as int,
        createdAt: json['createdAt'] as String,
        verified: json['verified'] as int,
        status: json['status'] as int);
  }

  Map<String, dynamic> verifyToJson() => {
        "shopId": this.shopId.toString(),
        "shopName": this.shopName,
        "userId": this.userId.toString(),
        "userName": this.userName,
        "userEmail": this.userEmail,
        "date": this.date,
        "slotNumber": this.slotNumber.toString(),
      };
}
