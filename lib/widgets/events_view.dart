import 'package:clust/models/event_model.dart';
import 'package:clust/providers/event_spot_provider.dart';
import 'package:clust/widgets/items_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsView extends StatelessWidget {
  EventsView(this.events, {super.key});
  List<Event> events;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Items(event: events[index]);
      },
    );
  }
}
