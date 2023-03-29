import 'package:clust/models/answer_model.dart';

import 'api_helper.dart';

class AnswerController {
  String path = "answer/";
  Future<List<Answer>> getAll() async {
    dynamic jsonObject = await ApiHelper().get(path);
    List<Answer> result = [];
    jsonObject.forEach((json) {
      result.add(Answer.fromJson(json));
    });
    return result;
  }

  Future<Answer> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    Answer result = Answer.fromJson(jsonObject);
    return result;
  }

  Future<Answer> create(Answer answer) async {
    dynamic jsonObject = await ApiHelper().post(path, answer.toJson());
    Answer result = Answer.fromJson(jsonObject);
    return result;
  }

  Future<Answer> update(Answer answer) async {
    dynamic jsonObject = await ApiHelper().put(path, answer.toJson());
    Answer result = Answer.fromJson(jsonObject);
    return result;
  }

  Future<void> distroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id");
    // Answer result = Answer.fromJson(jsonObject);
    // return result;
  }
}
