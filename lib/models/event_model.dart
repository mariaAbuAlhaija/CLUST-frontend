import 'dart:ui';
import 'package:clust/models/spot_model.dart';
import 'package:clust/models/user_model.dart';
import 'package:clust/models/country_model.dart';
import 'package:clust/providers/rate_provider.dart';
import 'package:provider/provider.dart';
import 'image_model.dart';
import 'interaction_model.dart';

class Event {
  int id;
  String name;
  String description;
  String address;
  int category_id;
  int organizer_id;
  int country_id;
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
  var rate;
  User? organizer;
  Country? country;
  Interaction? interaction; // New field

  Event(
    this.name,
    this.description,
    this.category_id,
    this.organizer_id,
    this.start_date,
    this.end_date,
    this.dynamicImages,
    this.dynamicSpots,
    this.address,
    this.country_id,
    this.id, {
    this.organizer,
    this.status = Status.available,
    this.views,
    this.capacity,
    this.thanking_message,
    this.country,
    this.interaction, // Initialize the interaction field
  }) {
    if (dynamicImages != null) {
      dynamicImages.forEach((json) {
        images.add(Image.fromJson(json).path);
      });
    }
    if (dynamicSpots != null) {
      dynamicSpots.forEach((json) {
        spots.add(Spot.fromJson(json));
      });
    }
    spotsCount = spots.length;
    getRate();
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
      json["address"],
      json["country_id"], json['id'] ?? 0,
      organizer: User.fromJson(json["organizer"]),
      status: json['status'] == Status.available.toString()
          ? Status.available
          : Status.unavailable,

      views: json['views'] ?? 0,
      capacity: json['capacity'] ?? 0,
      thanking_message: json['thanking_message'] ?? '',
      country: Country.fromJson(json['country']),
      interaction: json['interaction'] != null
          ? Interaction.fromJson(json['interaction'])
          : null, // Parse the interaction field only if it's not null
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
      "country_id": country_id.toString(),
      "address": address,
      "start_date": start_date.toIso8601String(),
      "end_date": end_date.toIso8601String(),
      "status": status.name,
      "views": views.toString(),
      "capacity": capacity.toString(),
      "interaction": interaction
          ?.toJson(), // Include the interaction field in the JSON if it's not null
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Event &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id;

  void getRate() async {
    try {
      rate = await RateProvider().getEventRates(this);
    } catch (ex) {
      rate ??= 0;
    }
  }
}

enum Status { available, unavailable }
