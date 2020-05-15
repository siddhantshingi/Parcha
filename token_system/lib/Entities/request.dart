class Request {
  int shopId;
  String openTime;
  String closeTime;
  int maxCapacity;
  String duration;
  String bufferTime;
  int status;
  String timestamp;

  Request({
    this.shopId,
    this.openTime,
    this.closeTime,
    this.maxCapacity,
    this.duration,
    this.bufferTime,
    this.status,
    this.timestamp
  });
}