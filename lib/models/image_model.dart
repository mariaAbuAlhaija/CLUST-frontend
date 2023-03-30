class BelongImage {
  int id;

  String path;

  int eventId;

  bool isMemory;

  BelongImage(this.id, this.path, this.eventId, this.isMemory);
  factory BelongImage.fromJson(Map<String, dynamic> json) {
    return BelongImage(
      json['id'] ?? 0,
      json['path'] ?? '',
      json['eventId'] ?? 0,
      json['isMemory'] is bool ? json['isMemory'] : json['isMemory'] == 1,


    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'path': path,
      'event_id': eventId.toString(),
      'is_memory': isMemory  ? 0.toString() : 1.toString(),
    };
  }
}
