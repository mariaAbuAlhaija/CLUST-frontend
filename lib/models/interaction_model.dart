class Interaction {
  int id;
  String type;
  int event_id;
  Interaction(
    this.id,
    this.type,
    this.event_id,
  );
  factory Interaction.fromJson(Map<String, dynamic> json) {
    return Interaction(
      json['id'] ?? 0,
      json['type'] ?? "",
      json['event_id'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "event_id": event_id,
      "id": id.toString(),
    };
  }
}
