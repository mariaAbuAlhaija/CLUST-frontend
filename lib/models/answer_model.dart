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
      json['textDescription'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "textDescription": textDescription,
      "id": id.toString(),
    };
  }
}
