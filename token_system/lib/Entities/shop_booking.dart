class ShopBooking{
  int shopId;
  String date;
  int slotNumber;
  int capacityLeft;
  int tokensVerified;
  int maxCapacity;

  ShopBooking({
    this.shopId,
    this.date,
    this.slotNumber,
    this.capacityLeft,
    this.tokensVerified,
    this.maxCapacity
  });

  factory ShopBooking.fromJson(Map<String, dynamic> json, int shopId) {
    return ShopBooking(
      shopId: shopId,
      date: json['date'] as String,
      slotNumber: json['slotNumber'] as int,
      capacityLeft: json['capacityLeft'] as int,
      tokensVerified: json['tokensVerified'] as int,
      maxCapacity: json['maxCapacity'] as int
    );
  }
}