import 'package:clust/models/answer_model.dart';

import 'api_helper.dart';

class AnswerController {
  String domain = "192.168.1.24:3333";
  String path = "answer/";
  Future<List<Answer>> getAll() async {
    dynamic jsonObject = await ApiHelper(domain: domain).get(path);
    List<Answer> result = [];
    jsonObject.forEach((json) {
      result.add(Answer.fromJson(json));
    });
    return result;
  }

  Future<Answer> getByID(int id) async {
    dynamic jsonObject = await ApiHelper(domain: domain).get("$path$id");
    Answer result = Answer.fromJson(jsonObject);
    return result;
  }

  Future<Answer> create(Answer answer) async {
    dynamic jsonObject =
        await ApiHelper(domain: domain).post(path, answer.toJson());
    Answer result = Answer.fromJson(jsonObject);
    return result;
  }

  Future<Answer> update(Answer answer) async {
    dynamic jsonObject =
        await ApiHelper(domain: domain).put(path, answer.toJson());
    Answer result = Answer.fromJson(jsonObject);
    return result;
  }

  Future<void> distroy(int id) async {
    dynamic jsonObject = await ApiHelper(domain: domain).delete("$path$id");
    // Answer result = Answer.fromJson(jsonObject);
    // return result;
  }
}
