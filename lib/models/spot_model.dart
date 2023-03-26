class Spot {
  int id;
  bool checked;
  int eventId;
  int userId;
  Spot(
    this.id,
    this.checked,
    this.eventId,
    this.userId,
  );
  factory Spot.fromJson(Map<String, dynamic> json) {
    return Spot(
      json['id'] ?? 0,
      json['checked'] ?? 0,
      json['eventId'] ?? 0,
      json['userId'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "checked": checked,
      "eventId": eventId,
      "userId": userId,
      "id": id.toString(),
    };
  }
}
