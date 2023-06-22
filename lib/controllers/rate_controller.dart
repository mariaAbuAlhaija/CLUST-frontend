import 'package:clust/models/country_model.dart';
import 'package:clust/models/rate_model.dart';
import 'api_helper.dart';

class RateController {
  String path = "rate/";
  Future<List<Rate>> getAll() async {
    dynamic jsonObject = await ApiHelper().get(path);
    List<Rate> result = [];
    jsonObject.forEach((json) {
      result.add(Rate.fromJson(json));
    });
    return result;
  }

  Future<double> getRate({productId}) async {
    var jsonObject = await ApiHelper()
        .get("${path}rating/", body: {"product_id": productId});
    var result = double.parse(jsonObject[0]["avg(`rating`)"]);

    return result;
  }
}
