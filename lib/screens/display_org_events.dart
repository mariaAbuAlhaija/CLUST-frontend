import 'package:flutter/material.dart';
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:clust/styles/palate.dart';
import '../models/event_model.dart';
import '../controllers/event_controller.dart';
import '../widgets/events_view.dart';

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
            return Theme(
              data: theme(context),
              child: SingleChildScrollView(
                child: EventsView(events),
              ),
            );
          } else {
            return Center(child: Text('No events found.'));
          }
        },
      ),
    );
  }

  ThemeData theme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      textTheme: Theme.of(context).textTheme.copyWith(
            displayLarge: mobile.displayLarge(color: Colors.amber),
            headlineLarge: mobile.headlineLarge(color: Palate.black),
            headlineMedium: mobile.headlineMedium(color: Palate.black),
            headlineSmall: mobile.headlineSmall(color: Palate.black),
            bodySmall: mobile.bodySmall(color: Palate.black),
            labelSmall: mobile.labelSmall(color: Palate.black),
          ),
    );
  }
}
