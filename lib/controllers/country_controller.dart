import 'package:clust/models/country_model.dart';
import 'api_helper.dart';

class CountryController {
  String path = "country/";
  Future<List<Country>> getAll() async {
    dynamic jsonObject = await ApiHelper().get(path);
    List<Country> result = [];
    jsonObject.forEach((json) {
      result.add(Country.fromJson(json));
    });
    return result;
  }
}
