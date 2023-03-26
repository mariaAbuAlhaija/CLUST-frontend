class BlockList {
  int id;
  int blockedId;
  int userId;
  BlockList(
    this.id,
    this.blockedId,
    this.userId,
  );
  factory BlockList.fromJson(Map<String, dynamic> json) {
    return BlockList(
      json['id'] ?? 0,
      json['blockedId'] ?? 0,
      json['userId'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "blockedId": blockedId,
      "userId": userId,
      "id": id.toString(),
    };
  }
}
