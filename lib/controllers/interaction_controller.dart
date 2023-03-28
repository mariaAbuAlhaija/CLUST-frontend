import 'package:clust/models/interaction_model.dart';

import 'api_helper.dart';

class InteractionController {
  String domain = "192.168.1.24:3333";
  String path = "interaction/";
  Future<List<Interaction>> getAll() async {
    dynamic jsonObject = await ApiHelper(domain: domain).get(path);
    List<Interaction> result = [];
    jsonObject.forEach((json) {
      result.add(Interaction.fromJson(json));
    });
    return result;
  }

  Future<Interaction> getByID(int id) async {
    dynamic jsonObject = await ApiHelper(domain: domain).get("$path$id");
    Interaction result = Interaction.fromJson(jsonObject);
    return result;
  }

  Future<Interaction> create(Interaction interaction) async {
    dynamic jsonObject =
        await ApiHelper(domain: domain).post(path, interaction.toJson());
    Interaction result = Interaction.fromJson(jsonObject);
    return result;
  }

  Future<Interaction> update(Interaction interaction) async {
    dynamic jsonObject =
        await ApiHelper(domain: domain).put(path, interaction.toJson());
    Interaction result = Interaction.fromJson(jsonObject);
    return result;
  }

  Future<void> distroy(int id) async {
    dynamic jsonObject = await ApiHelper(domain: domain).delete("$path$id");
    // Interaction result = Interaction.fromJson(jsonObject);
    // return result;
  }
}
