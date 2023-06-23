import '../models/event_model.dart';
import 'api_helper.dart';

class EventController {
  String path = "event/";
  Future<List<Event>> getAll({hot, live}) async {
    dynamic jsonObject = await ApiHelper().get(hot == true
        ? "${path}hot"
        : live == true
            ? "${path}getlive"
            : "${path}nonpast");
    List<Event> result = [];
    jsonObject.forEach((json) {
      // print(json);
      result.add(Event.fromJson(json));
    });
    return result;
  }

  Future<Event> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    late Event result;
    jsonObject.forEach((json) {
      result = Event.fromJson(json);
    });
    return result;
  }

  Future<Event> create(Event event) async {
    dynamic jsonObject = await ApiHelper().post(path, body: event.toJson());
    Event result = Event.fromJson(jsonObject[0]);
    return result;
  }

  Future<Event> update(Event event) async {
    dynamic jsonObject = await ApiHelper().put(path, event.toJson());
    Event result = Event.fromJson(jsonObject);
    return result;
  }

  void updateViews(Event event) async {
    dynamic jsonObject =
        await ApiHelper().put("$path" "increment/${event.id}", event.toJson());
  
   
  }

  Future<void> destroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id");
    // Event result = Event.fromJson(jsonObject);
    // return result;
  }

  Future<List<int>> getEventIdsByOrganizer(int? organizerId) async {
    String endpoint = "event/orgids/$organizerId";
    dynamic jsonObject = await ApiHelper().get(endpoint);
    List<int> eventIds = [];
    jsonObject.forEach((json) {
      eventIds.add(json["id"]);
    });
    return eventIds;
  }

  Future<List<Event>> getAllByOrganizer(int? organizerId) async {
    String endpoint = "${path}org/$organizerId";
    dynamic jsonObject = await ApiHelper().get(endpoint);
    List<Event> result = [];
    jsonObject.forEach((json) {
      result.add(Event.fromJson(json));
    });
    return result;
  }
}
