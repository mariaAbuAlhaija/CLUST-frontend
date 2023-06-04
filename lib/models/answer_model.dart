class Answer {
  int id;
  String textDescription;
  Answer(
    this.id,
    this.textDescription,
  );
  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      json['id'] ?? 0,
      json['text_description'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "text_description": textDescription,
      "id": id.toString(),
    };
  }
}
