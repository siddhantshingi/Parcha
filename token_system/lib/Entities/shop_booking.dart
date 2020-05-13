class ShopBooking{
  int shopId;
  String date;
  String startTime;
  String duration;
  int capacityLeft;
  int tokensVerified;

  ShopBooking({
    this.shopId,
    this.date,
    this.startTime,
    this.duration,
    this.capacityLeft,
    this.tokensVerified,
  });

  ShopBooking fromJson(Map<String, dynamic> json) {
    return ShopBooking(
      shopId: json['shopId'] as int,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      duration: json['duration'] as String,
      capacityLeft: json['capacityLeft'] as int,
      tokensVerified: json['tokensVerified'] as int,
    );
  }
}