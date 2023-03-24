
import '../models/image_model.dart';
import 'api_helper.dart';

class ImageController {
  Future<List<Image>> getAll() async {
    dynamic jsonObject = await ApiHelper(domain: '').getImages();
    List<Image> result = [];
    jsonObject.forEach((json) {
      result.add(Image.fromJson(json));
    });
    return result;
  }

  Future<Image> getByID(int id) async {
    dynamic jsonObject = await ApiHelper(domain: '').getImage(id);
    Image result = Image.fromJson(jsonObject);
    return result;
  }

//   Future<Image> createImage(Image image) async {
//   dynamic jsonObject = await ApiHelper(domain: '').postImage(image);
//   Image result = Image.fromJson(jsonObject);
//   return result;
// }

}