import '../models/spot_model.dart';
import 'api_helper.dart';

class SpotController {
  String path = "spot/";
  Future<List<Spot>> getAll() async {
    dynamic jsonObject = await ApiHelper().get(path);
    List<Spot> result = [];
    jsonObject.forEach((json) {
      result.add(Spot.fromJson(json));
    });
    return result;
  }

  Future<Spot> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    Spot result = Spot.fromJson(jsonObject);
    return result;
  }

  Future<Spot> create(Spot spot) async {
    dynamic jsonObject = await ApiHelper().post(path, body: spot.toJson());
    Spot result = Spot.fromJson(jsonObject);
    return result;
  }

  Future<Spot> update(Spot spot) async {
    dynamic jsonObject = await ApiHelper().put(path, spot.toJson());
    Spot result = Spot.fromJson(jsonObject);
    return result;
  }

  Future<void> destroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id");
    // Spot result = Spot.fromJson(jsonObject);
    // return result;
  }
}
