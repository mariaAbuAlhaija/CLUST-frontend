import 'package:clust/controllers/event_controller.dart';
import 'package:clust/models/event_model.dart';
import 'package:clust/widgets/events_view.dart';
import 'package:flutter/material.dart';

class OrgEventsScreen extends StatelessWidget {
   final int? organizerId;

  OrgEventsScreen({required this.organizerId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organizer Events'),
      ),
      body: FutureBuilder<List<Event>>(
        future: EventController().getAllByOrganizer(organizerId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Event> events = snapshot.data!;
            return EventsView(events);
          } else {
            return Center(child: Text('No events found.'));
          }
        },
      ),
    );
  }
}
