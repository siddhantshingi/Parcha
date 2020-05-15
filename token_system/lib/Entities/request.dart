class Request {
  int shopId;
  String pincode;
  String openTime;
  String closeTime;
  int shopSize;
  int capacity;
  String slotDuration;
  String bufferDuration;
  int status;
  String time;

  Request({
    this.shopId,
    this.pincode,
    this.openTime,
    this.closeTime,
    this.shopSize,
    this.capacity,
    this.slotDuration,
    this.bufferDuration,
    this.status,
    this.time
  });

  Map<String, dynamic> toJson() =>
      {
        "shopId": this.shopId.toString(),
        "pincode": this.pincode,
        "openTime": this.openTime,
        "closeTime": this.closeTime,
        "shopSize": this.shopSize.toString(),
        "status": this.status.toString(),
        "time": this.time
      };
  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
        shopId: json['shopId'] as int,
        pincode: json['pincode'] as String,
        openTime: json['openTime'] as String,
        closeTime: json['closeTime'] as String,
        shopSize: json['shopSize'] as int,
        capacity: json['capacity'] as int,
        slotDuration: json['slotDuration'] as String,
        bufferDuration: json['bufferDuration'] as String,
        status: json['status'] as int,
        time: json['time'] as String
    );
  }
}