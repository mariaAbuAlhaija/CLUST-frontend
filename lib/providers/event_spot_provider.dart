import 'package:clust/controllers/event_controller.dart';
import 'package:clust/controllers/spot_controller.dart';
import 'package:clust/models/event_model.dart';
import 'package:clust/models/spot_model.dart';
import 'package:flutter/material.dart';

class eventSpotProvider with ChangeNotifier {
  final List<Event> allEvents = [];
  final List<Event> hotEvents = [];
  final List<Event> liveEvents = [];
  final List<Spot> spottedSpots = [];
  final List<Spot> pastSpots = [];
  final List<Event> search = [];
  final List<Event> filteredEvents = [];

  late Event defaultEvent;

  static final eventSpotProvider _eventSpotProvider =
      eventSpotProvider._internal();

  factory eventSpotProvider() {
    return _eventSpotProvider;
  }

  eventSpotProvider._internal() {
    events();
    hotEventsGenerate();
    defaultEventGenerate();
    pastEventsGenerate();
    liveEventsGenerate();
    spots();
  }

  bool empty() {
    return allEvents.isEmpty;
  }

  spotAdded(Event event, Spot spot) {
    var index = allEvents.indexOf(event);
    allEvents[index].spotsCount++;
    addSpot(spot);
    notifyListeners();
  }

  eventIndex(Event event) {
    return allEvents.indexOf(event);
  }

  addSpot(Spot spot) {
    if (!spottedSpots.contains(spot)) {
      SpotController().create(spot);
      spottedSpots.add(spot);
    }
    notifyListeners();
  }

  removeSpot(Spot spot) {
    SpotController().destroy(spot.id);
    spottedSpots.remove(spot);
    notifyListeners();
  }

  containsSpot(eventId, userId) {
    Spot spot = Spot(0, eventId, userId, false);
    return spottedSpots.contains(spot);
  }

  addEvent(Event event) {
    if (!allEvents.contains(event)) {
      allEvents.add(event);
    }
    notifyListeners();
  }

  removeEvent(Event event) {
    allEvents.remove(event);
    notifyListeners();
  }

  Future<List<Event>> events() async {
    var result = await EventController().getAll();
    allEvents.addAll(result);
    notifyListeners();
    return allEvents;
  }

  Future<List<Event>> hotEventsGenerate() async {
    var result = await EventController().getAll(hot: true);
    hotEvents.addAll(result);
    notifyListeners();
    return hotEvents;
  }

  Future<Event> defaultEventGenerate() async {
    var result = await EventController().getByID(15);
    defaultEvent = result;
    notifyListeners();
    return defaultEvent;
  }

  Future<List<Spot>> spots() async {
    var result = await SpotController().getAll();
    spottedSpots.addAll(result);
    notifyListeners();
    return spottedSpots;
  }

  Future<List<Spot>> pastEventsGenerate() async {
    var result = await SpotController().getAll(past: true);
    pastSpots.addAll(result);
    notifyListeners();
    return pastSpots;
  }

  Future<List<Event>> liveEventsGenerate() async {
    var result = await EventController().getAll(live: true);
    liveEvents.addAll(result);
    notifyListeners();
    return liveEvents;
  }

  Future<List<Event>> searchResults(String query) async {
    search.clear();
    for (Event event in allEvents) {
      if (event.name.toLowerCase().contains(query.toLowerCase())) {
        search.add(event);
      }
    }
    return search;
  }
   Future<List<Event>> getEventsByCategoryIds(List<int> categoryIds) async {
 filteredEvents.clear();

  for (Event event in allEvents) {
    if (categoryIds.contains(event.category_id)) {
      filteredEvents.add(event);
    }
  }

  return filteredEvents;
}
}
