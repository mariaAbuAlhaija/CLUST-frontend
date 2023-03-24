 class Image  {
int id;

  String path;

int eventId;

bool isMemory;

 Image(this.id, this.path,this.eventId,this.isMemory);
  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(json['id'], json['path'], json['eventId'], json['isMemory']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'path': path,
      'eventId': eventId,
       'isMemory': isMemory,
    };
  }

}
