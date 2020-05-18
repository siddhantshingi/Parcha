class Token {
  int tokenId;
  int verified;
  int shopId;
  String date;
  String shopName;
  String pincode;
  String startTime;
  String duration;
  int status;

  // Ctor : For checking only
  Token.basic({
    this.tokenId,
    this.date,
    this.startTime,
    this.status,
    this.shopName,
  });

  Token({
    this.tokenId,
    this.shopId,
    this.verified,
    this.date,
    this.shopName,
    this.pincode,
    this.startTime,
    this.duration,
    this.status,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      tokenId: json['id'] as int,
      shopId: json['shopId'] as int,
      verified: json['verified'] as int,
      date: json['date'] as String,
      shopName: json['shopName'] as String,
      pincode: json['pincode'] as String,
      startTime: json['startTime'] as String,
      duration: json['duration'] as String,
      status: json['status'] as int,
    );
  }
}
