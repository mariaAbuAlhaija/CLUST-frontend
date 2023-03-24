// export default class Tag extends BaseModel {
//   public static table= "tags"
//   @column({ isPrimary: true })
//   public id: number
//   @column({serializeAs:"text_description"})
//   public textDescription: string
// }

class Tag {
  int id;
  String text_description;

  Tag(this.id, this.text_description);
  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(json['id'], json['text_description']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'textDescription': text_description,
    };
  }
}
