import 'package:clust/models/event_model.dart';

class Spot {
  int id;
  int eventId;
  int userId;
  bool checked;
  // Event? event;

  Spot(
    this.id,
    this.eventId,
    this.userId,
    this.checked,
    // {
    // this.event,
    // }
  );
  factory Spot.fromJson(Map<String, dynamic> json) {
    return Spot(
      json['id'] ?? 0, json['event_id'] ?? 0, json['user_id'] ?? 0,
      json['checked'] is bool ? json['checked'] : json['checked'] == 1,
      // event: Event.fromJson(json['event'])
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "event_id": eventId.toString(),
      "user_id": userId.toString(),
      "checked": checked ? 1.toString() : 0.toString(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Spot &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          eventId == other.eventId;
}
