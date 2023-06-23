import 'package:clust/providers/event_spot_provider.dart';
import 'package:flutter/material.dart';
import 'package:clust/widgets/events_view.dart' as EventsViewWidget;
import 'package:clust/styles/palate.dart';
import 'package:flutter/foundation.dart';
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:provider/provider.dart';

class EventsView extends StatefulWidget {
  EventsView(this.txt, {super.key});
  String txt;
  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: !kIsWeb ? theme(context) : ThemeData(),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.txt)),
        body: Container(
          child: Consumer(
            builder: (BuildContext context, eventSpotProvider provider,
                Widget? child) {
                     Future<void> refresh() async {
                setState(() {
                  provider.liveEvents.clear();
                });
              var event=  provider.liveEventsGenerate();
                await event;
              }

              return provider.liveEvents.isNotEmpty
                  ? RefreshIndicator(
                    onRefresh:refresh ,
                    child: SingleChildScrollView(child: EventsViewWidget.EventsView(provider.liveEvents)))
                  : Center(
                      child: Text("No Live Events"),
                    );
            },
          ),
        ),
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
