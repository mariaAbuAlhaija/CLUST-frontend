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
      json['blocked_id'] ?? 0,
      json['user_id'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "blocked_id": blockedId,
      "user_id": userId,
      "id": id.toString(),
    };
  }
}
