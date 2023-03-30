class Spot {
  int id;
  int eventId;
  int userId;
  bool checked;
  
  Spot(
    this.id,
    this.eventId,
    this.userId,
    this.checked,
  );
factory Spot.fromJson(Map<String, dynamic> json) {
  return Spot(
    json['id'] ?? 0,
    json['eventId'] ?? 0,
    json['userId'] ?? 0,
    json['checked'] is bool ? json['checked'] : json['checked'] == 1,
  );


  }
  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "event_id": eventId.toString(),
      "user_id": userId.toString(),
      "checked": checked ? 0.toString() : 1.toString(),
    };
  }
}
