class Interaction {
  int id;
  String type;
  int answerId;
  Interaction(
    this.id,
    this.type,
    this.answerId,
  );
  factory Interaction.fromJson(Map<String, dynamic> json) {
    return Interaction(
      json['id'] ?? 0,
      json['type'] ?? "",
      json['answer_id'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "answer_id": answerId,
      "id": id.toString(),
    };
  }
}
