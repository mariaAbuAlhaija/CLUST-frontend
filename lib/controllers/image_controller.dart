import '../models/image_model.dart';
import 'api_helper.dart';

class BelongImageController {
  String path = "image/";
  Future<List<BelongImage>> getAll() async {
    dynamic jsonObject = await ApiHelper().get(path);
    List<BelongImage> result = [];
    jsonObject.forEach((json) {
      result.add(BelongImage.fromJson(json));
    });
    return result;
  }

  Future<BelongImage> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    print(jsonObject);
    BelongImage result = BelongImage.fromJson(jsonObject);
    return result;
  }

  Future<BelongImage> create(BelongImage image) async {
    dynamic jsonObject = await ApiHelper().post(path, image.toJson());
    BelongImage result = BelongImage.fromJson(jsonObject);
    return result;
  }

  Future<BelongImage> update(BelongImage image) async {
    dynamic jsonObject = await ApiHelper().put(path, image.toJson());
    BelongImage result = BelongImage.fromJson(jsonObject);
    return result;
  }

  Future<void> destroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id");
    // BelongImage result = BelongImage.fromJson(jsonObject);
    // return result;
  }
}
