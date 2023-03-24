// import '../network_helper.dart';


// import '../models/event_model.dart';

// class EventController {
//   Future<List<Event>> getAll() async {
//     dynamic jsonObject = await ApiHelper().getEvents();
//     List<Event> result = [];
//     jsonObject.forEach((json) {
//       result.add(Event.fromJson(json));
//     });
//     return result;
//   }

//   Future<Event> getByID(int id) async {
//     dynamic jsonObject = await ApiHelper().getEvent(id);
//     Event result = Event.fromJson(jsonObject);
//     return result;
//   }
// }
