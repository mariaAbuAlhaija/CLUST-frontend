class Report {
  int id;

  String description;

  int eventId;

 Report(this.id, this.description,this.eventId);
  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(json['id']??0, json['description']??'', json['eventId']??0);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'eventId': eventId,
    };
  }
}
