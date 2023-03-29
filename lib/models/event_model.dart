class Event {
  int id;
  String name;
  String description;
  int category_id;
  int organizer_id;
  DateTime start_date;
  DateTime end_date;
  String status;
  int views;
  int capacity;
  String thanking_message;

  Event(
      this.id,
      this.name,
      this.description,
      this.category_id,
      this.organizer_id,
      this.start_date,
      this.end_date,
      this.status,
      this.views,
      this.capacity,
      this.thanking_message);
  factory Event.fromJson(Map<String, dynamic> json) {
    DateTime st = DateTime.parse(json['start_date'] ?? '');
    DateTime en = DateTime.parse(json['end_date'] ?? '');
    return Event(
        json['id'] ?? 0,
        json['name'] ?? '',
        json['description'] ?? '',
        json['category_id'] ?? 0,
        json['organizer_id'] ?? 0,
        st,
        en,
        json['status'] ?? '',
        json['views'] ?? 0,
        json['capacity'] ?? 0,
        json['thanking_message'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'name': name,
      'description': description,
      'category_id': category_id.toString(),
      'organizer_id': organizer_id.toString(),
      'start_date': start_date,
      'end_date': end_date,
      'status': status,
      'views': views.toString(),
      'capacity': capacity.toString(),
      'thanking_message': thanking_message,
    };
  }
}
