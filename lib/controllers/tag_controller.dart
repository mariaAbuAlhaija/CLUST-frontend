// import '../models/tag_model.dart';
// import 'api_helper.dart';

// class TagController {
//   Future<List<Tag>> getAll() async {
//     dynamic jsonObject = await ApiHelper(domain: '').getTags();
//     List<Tag> result = [];
//     jsonObject.forEach((json) {
//       result.add(Tag.fromJson(json));
//     });
//     return result;
//   }

//   Future<Tag> getByID(int id) async {
//     dynamic jsonObject = await ApiHelper(domain: '').getTag(id);
//     Tag result = Tag.fromJson(jsonObject);
//     return result;
//   }

 
//   Future<Tag> create(Tag tag) async {
//     dynamic jsonObject = await ApiHelper(domain: '').createTag("tag", tag.toJson());
//     dynamic result = Tag.fromJson(jsonObject);
//     return result;
//   }
// }
