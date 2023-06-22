class Answer {
  int id;
  String textDescription;
    int interactionId;

  Answer(
    this.id,
    this.textDescription,
    this.interactionId,

  );
  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      json['id'] ?? 0,
      json['text_description'] ?? "",
     json['interactionId'] ?? 0,

    );
  }
  Map<String, dynamic> toJson() {
    return {
      "text_description": textDescription,
      "id": id.toString(),
      "interactionId": interactionId.toString(),

    };
  }
}
