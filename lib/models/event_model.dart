import 'dart:ui';
import 'package:clust/models/spot_model.dart';
import 'package:clust/models/user_model.dart';

import 'image_model.dart';

class Event {
  int? id;
  String name;
  String description;
  int category_id;
  int organizer_id;
  DateTime start_date;
  DateTime end_date;
  Status status;
  int? views;
  int? capacity;
  String? thanking_message;
  var dynamicImages;
  List<String> images = [];
  var dynamicSpots;
  List<Spot> spots = [];
  var spotsCount;
  User? organizer;

  Event(
    this.name,
    this.description,
    this.category_id,
    this.organizer_id,
    this.start_date,
    this.end_date,
    this.dynamicImages,
    this.dynamicSpots, {
    this.organizer,
    this.status = Status.available,
    this.id,
    this.views,
    this.capacity,
    this.thanking_message,
  }) {
    if (dynamicImages != null)
      dynamicImages.forEach((json) {
        images.add(Image.fromJson(json).path);
      });
    if (dynamicSpots != null)
      dynamicSpots.forEach((json) {
        spots.add(Spot.fromJson(json));
      });
    spotsCount = spots.length;
  }
  factory Event.fromJson(json) {
    DateTime st = DateTime.parse(json['start_date'] ?? '');
    DateTime en = DateTime.parse(json['end_date'] ?? '');

    Event _event = Event(
      json['name'] ?? '',
      json['description'] ?? '',
      json['category_id'] ?? 0,
      json['organizer_id'] ?? 0,
      st,
      en,
      json["images"],
      json["spot"],
      organizer: User.fromJson(json["organizer"]) ?? null,
      status: json['status'] == Status.available.toString()
          ? Status.available
          : Status.unavailable,
      id: json['id'] ?? 0,
      views: json['views'] ?? 0,
      capacity: json['capacity'] ?? 0,
      thanking_message: json['thanking_message'] ?? '',
    );

    return _event;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "name": name,
      "description": description,
      "category_id": category_id.toString(),
      "organizer_id": organizer_id.toString(),
      "start_date": start_date.toIso8601String(),
      "end_date": end_date.toIso8601String(),
      "status": status,
      "views": views.toString(),
      "capacity": capacity.toString(),
      "thanking_message": thanking_message,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Event &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id;
}

enum Status { available, unavailable }
