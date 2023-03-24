


class Category {
  int id;
  String name;

  Category(this.id, this.name);
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(json['id'], json['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}