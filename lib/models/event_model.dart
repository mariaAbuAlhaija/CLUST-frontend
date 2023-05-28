import 'package:intl/intl.dart';

class Event {
  int? id;
  String name;
  String description;
  int category_id;
  int organizer_id;
  DateTime start_date;
  DateTime end_date;
  String status;
  int? views;
  int ?capacity;
  String? thanking_message;

  Event({
       this.id,
     required this.name,
    required  this.description,
     required this.category_id,
   required   this.organizer_id,
   required   this.start_date,
    required  this.end_date,
   required   this.status,
      this.views,
      this.capacity,
      this.thanking_message});
  factory Event.fromJson(Map<String, dynamic> json) {
    DateTime st = DateTime.parse(json['start_date'] ?? '');
    DateTime en = DateTime.parse(json['end_date'] ?? '');
    Event _event=Event (
      id: json['id'] ?? 0,
    name:   json['name'] ?? '',
     description:  json['description'] ?? '',
      category_id:  json['category_id'] ?? 0,
      organizer_id:  json['organizer_id'] ?? 0,
       start_date:   st,
       end_date:en,
        status: json['status'] ?? '',
       views: json['views'] ?? 0,
       capacity:json['capacity'] ?? 0,
        thanking_message: json['thanking_message'] ?? ''
       );
 
    
    return _event; }

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


}
