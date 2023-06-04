import '../models/image_model.dart';
import 'api_helper.dart';

class BelongImageController {
  String path = "image/";
  Future<List<Image>> getAll() async {
    dynamic jsonObject = await ApiHelper().get(path);
    List<Image> result = [];
    jsonObject.forEach((json) {
      result.add(Image.fromJson(json));
    });
    return result;
  }

  Future<Image> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    print(jsonObject);
    Image result = Image.fromJson(jsonObject);
    return result;
  }

  Future<Image> create(Image image) async {
    dynamic jsonObject = await ApiHelper().post(path, body: image.toJson());
    Image result = Image.fromJson(jsonObject);
    return result;
  }

  Future<Image> update(Image image) async {
    dynamic jsonObject = await ApiHelper().put(path, image.toJson());
    Image result = Image.fromJson(jsonObject);
    return result;
  }

  Future<void> destroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id");
    // BelongImage result = BelongImage.fromJson(jsonObject);
    // return result;
  }
}
