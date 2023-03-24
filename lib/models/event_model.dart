class Event {
  int id;
  String name;
  String description;
  int category_id;
  int organizer_id;
  String start_date;
  String end_date;
  String status;
  int views;
 int capacity;
   String thanking_message;



  Event(this.id, this.name,this.description ,this.category_id ,this.organizer_id,this.start_date,this.end_date ,this.status ,this.views,this.capacity,this.thanking_message   );
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(json['id'], json['name'], json['description'], json['category_id'], json['organizer_id'], json['start_date'], json['end_date'], json['status'], json['views'], json['capacity'], json['thanking_message']);
  }

 Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category_id': category_id,
      'organizer_id': organizer_id,
      'start_date': start_date,
      'end_date': end_date,
      'status': status,
      'views': views,
      'capacity': capacity,
      'thanking_message': thanking_message,
      
    };
  }
}