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

  

  Future<Event> create(Event event) async {
    dynamic jsonObject = await ApiHelper(domain: '').createEvent("event", event.toJson());
    dynamic result = Event.fromJson(jsonObject);
    return result;
  }

 }

