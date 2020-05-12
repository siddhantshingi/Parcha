class Token {
  int tokenId;
  bool verified;
  String date;
  int shopId;
  String startTime;
  int duration;
  int status;

  // Ctor : For checking only
  Token.basic({
    this.tokenId,
    this.date,
    this.startTime,
    this.status,
    this.shopId: 0,
  });

  Token({
    this.tokenId,
    this.verified,
    this.date,
    this.shopId,
    this.startTime,
    this.duration,
    this.status,
  });

  Token fromJson(Map<String, dynamic> json) {
    return Token(
      tokenId: json['tokenId'] as int,
      verified: json['verified'] as bool,
      date: json['date'] as String,
      shopId: json['shopId'] as int,
      startTime: json['startTime'] as String,
      duration: json['duration'] as int,
      status: json['status'] as int,
    );
  }
}
