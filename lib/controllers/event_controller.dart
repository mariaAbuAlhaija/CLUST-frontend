import '../models/event_model.dart';
import 'api_helper.dart';

class EventController {
  Future<List<Event>> getAll() async {
    dynamic jsonObject = await ApiHelper(domain: '').getEvents();
    List<Event> result = [];
    jsonObject.forEach((json) {
      result.add(Event.fromJson(json));
    });
    return result;
  }

  Future<Event> getByID(int id) async {
    dynamic jsonObject = await ApiHelper(domain: '').getEvent(id);
    Event result = Event.fromJson(jsonObject);
    return result;
  }

//   Future<Event> createEvent(Event event) async {
//   dynamic jsonObject = await ApiHelper(domain: '').postEvent(event);
//   Event result = Event.fromJson(jsonObject);
//   return result;
// }

}
