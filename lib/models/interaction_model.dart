class Interaction {
  int? id;
  String type;
  int? event_id;
  Interaction(
    this.id,
    this.type,
    this.event_id,
  );
  factory Interaction.fromJson(Map<String, dynamic> json) {
    return Interaction(
      json['id'] ?? 0,
      json['type'] ?? "",
      json['eventId'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id":id.toString(),
      "type": type,
      "eventId": event_id.toString(),
     };
  }
}
