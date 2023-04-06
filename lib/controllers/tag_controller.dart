import '../models/tag_model.dart';
import 'api_helper.dart';

class TagController {
  String path = "tag/";
  Future<List<Tag>> getAll() async {
    dynamic jsonObject = await ApiHelper().get(path);
    List<Tag> result = [];
    jsonObject.forEach((json) {
      result.add(Tag.fromJson(json));
    });
    return result;
  }

  Future<Tag> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    Tag result = Tag.fromJson(jsonObject);
    return result;
  }

  Future<Tag> create(Tag tag) async {
    dynamic jsonObject = await ApiHelper().post(path, body: tag.toJson());
    Tag result = Tag.fromJson(jsonObject);
    return result;
  }

  Future<Tag> update(Tag tag) async {
    dynamic jsonObject = await ApiHelper().put(path, tag.toJson());
    Tag result = Tag.fromJson(jsonObject);
    return result;
  }

  Future<void> destroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id");
    // Tag result = Tag.fromJson(jsonObject);
    // return result;
  }
}
