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
      json['answerId'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "answerId": answerId,
      "id": id.toString(),
    };
  }
}
