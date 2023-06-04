class Image {
  int id;

  String path;

  int eventId;

  bool isMemory;

  Image(this.id, this.path, this.eventId, this.isMemory);
  factory Image.fromJson(json) {
    return Image(
      json['id'] ?? 0,
      json['path'] ?? '',
      json['event_id'] ?? 0,
      json['is_memory'] is bool ? json['is_memory'] : json['is_memory'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'path': path,
      'event_id': eventId.toString(),
      'is_memory': isMemory ? 0.toString() : 1.toString(),
    };
  }
}
